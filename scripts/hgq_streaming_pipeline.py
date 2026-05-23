#!/usr/bin/env python3
"""Build an HGQ-informed IOStream baseline.

The pipeline intentionally separates numerical truth from hardware structure:

1. Generate an IOParallel HGQ reference project under build/.
2. Generate an IOStream project under build/.
3. Extract propagated precisions, layer configs, per-index quantizers, and
   weights from the IOParallel reference.
4. Install the IOStream project as cnn_core_project and save the extracted HGQ
   reference data next to it for the streaming patching step.

The IOParallel project is a precision oracle, not the target architecture.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import sys
from pathlib import Path
from typing import Any

import numpy as np


REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_MODEL_PATH = "models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras"
DEFAULT_OUTPUT_DIR = "cnn_core_project"
DEFAULT_STREAMING_FIRMWARE_DIR = "hls_streaming/firmware"
DEFAULT_BUILD_DIR = "build/hgq_streaming_pipeline"
DEFAULT_DATA_DIR = "data"
DEFAULT_BACKEND = "Vitis"
DEFAULT_PART = "xcku5p-ffvb676-2-e"
DEFAULT_PROJECT_NAME = "cnn_core"
DEFAULT_CLOCK_PERIOD = 5
DEFAULT_INPUT_PRECISION = "ap_fixed<12,6>"
DEFAULT_DENSE_RESULT_PRECISION = "ap_fixed<16,6>"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate HGQ reference data and an IOStream baseline.")
    parser.add_argument("--model-path", default=DEFAULT_MODEL_PATH)
    parser.add_argument("--output-dir", default=DEFAULT_OUTPUT_DIR)
    parser.add_argument("--streaming-firmware-dir", default=DEFAULT_STREAMING_FIRMWARE_DIR)
    parser.add_argument("--build-dir", default=DEFAULT_BUILD_DIR)
    parser.add_argument("--data-dir", default=DEFAULT_DATA_DIR)
    parser.add_argument("--backend", default=DEFAULT_BACKEND)
    parser.add_argument("--part", default=DEFAULT_PART)
    parser.add_argument("--project-name", default=DEFAULT_PROJECT_NAME)
    parser.add_argument("--clock-period", type=float, default=DEFAULT_CLOCK_PERIOD)
    parser.add_argument("--input-precision", default=DEFAULT_INPUT_PRECISION)
    parser.add_argument("--dense-result-precision", default=DEFAULT_DENSE_RESULT_PRECISION)
    parser.add_argument("--reuse-factor", type=int, default=1)
    parser.add_argument("--strategy", default="Latency", choices=("Latency", "Resource"))
    parser.add_argument("--input-stream-depth", type=int, default=16)
    parser.add_argument("--skip-compile", action="store_true")
    parser.add_argument("--skip-verify", action="store_true")
    parser.add_argument("--keep-build", action="store_true")
    parser.add_argument(
        "--init-streaming",
        action="store_true",
        help="After installing cnn_core_project, copy its firmware into hls_streaming/firmware.",
    )
    parser.add_argument(
        "--install",
        action="store_true",
        help="Overwrite cnn_core_project with the generated IOStream baseline.",
    )
    args = parser.parse_args()

    if args.skip_compile and not args.skip_verify:
        parser.error("--skip-compile requires --skip-verify because hls_model.predict() needs compile().")
    if args.init_streaming and not args.install:
        parser.error("--init-streaming requires --install.")

    return args


def import_dependencies() -> tuple[Any, Any, dict[str, Any]]:
    try:
        import hls4ml
    except ImportError as exc:
        print(f"[ERROR] Missing hls4ml: {exc}", file=sys.stderr)
        raise

    try:
        import keras
    except ImportError:
        try:
            from tensorflow import keras
        except ImportError as exc:
            print(f"[ERROR] Missing keras/tensorflow: {exc}", file=sys.stderr)
            raise

    try:
        import hgq  # noqa: F401
        from hgq.layers import QConv2D, QDense
    except ImportError as exc:
        print(f"[ERROR] Missing hgq: {exc}", file=sys.stderr)
        raise

    return hls4ml, keras, {"QConv2D": QConv2D, "QDense": QDense}


def rel(path: str | Path) -> Path:
    path = Path(path)
    return path if path.is_absolute() else REPO_ROOT / path


def assert_safe_replace_path(path: Path) -> None:
    resolved = path.resolve()
    if resolved in {Path("/"), REPO_ROOT, REPO_ROOT.parent}:
        raise ValueError(f"Refusing to replace unsafe path: {resolved}")


def replace_directory(src: Path, dst: Path) -> None:
    if not src.is_dir():
        raise FileNotFoundError(f"Source directory does not exist: {src}")
    assert_safe_replace_path(dst)
    if dst.exists():
        print(f"[INFO] Removing existing directory: {dst}")
        shutil.rmtree(dst)
    print(f"[INFO] Copying {src} -> {dst}")
    shutil.copytree(src, dst)


def prepare_build_dir(path: Path, keep_build: bool) -> None:
    assert_safe_replace_path(path)
    if path.exists() and not keep_build:
        print(f"[INFO] Removing existing build work directory: {path}")
        shutil.rmtree(path)
    path.mkdir(parents=True, exist_ok=True)


def get_model_input_shape(model: Any) -> tuple[int, ...]:
    input_shape = model.input_shape
    if isinstance(input_shape, list):
        input_shape = input_shape[0]
    if input_shape is None:
        raise ValueError("Unable to determine model input shape")
    return tuple(input_shape[1:])


def get_quant_bits(q_conf: dict[str, Any] | None) -> tuple[int, int]:
    if q_conf and "config" in q_conf:
        config = q_conf["config"]
        if "i0" in config and "f0" in config:
            sign_bits = int(config.get("k0", 0))
            int_bits = int(config["i0"])
            frac_bits = int(config["f0"])
            return sign_bits + int_bits + frac_bits, sign_bits + int_bits
    return 0, 0


def collect_layer_precisions(model: Any) -> dict[str, str]:
    precisions: dict[str, str] = {}
    print("[INFO] Scanning HGQ layer precision floors for IOStream skeleton.")
    for layer in model.layers:
        config = layer.get_config()
        totals = [get_quant_bits(config.get(name)) for name in ("kq_conf", "bq_conf", "iq_conf")]
        local_total = max(total for total, _ in totals)
        local_int = max(integer for _, integer in totals)
        if local_total == 0:
            print(f"   Layer {layer.name:<15} -> [inherit]")
            continue
        local_total = max(local_total, 4)
        local_int = max(local_int, 2)
        precisions[layer.name] = f"ap_fixed<{local_total},{local_int}>"
        print(f"   Layer {layer.name:<15} -> {precisions[layer.name]}")
    return precisions


def build_vanilla_model(keras: Any, hgq_model: Any, custom_objects: dict[str, Any]) -> Any:
    layers = keras.layers
    qconv_cls = custom_objects["QConv2D"]
    qdense_cls = custom_objects["QDense"]
    model_input_shape = get_model_input_shape(hgq_model)

    vanilla_model = keras.Sequential(name=f"{hgq_model.name}_iostream")
    vanilla_model.add(layers.InputLayer(shape=model_input_shape, name="input_layer"))
    current_shape = (None,) + model_input_shape

    for layer in hgq_model.layers:
        config = layer.get_config()
        weights = layer.get_weights()
        new_layer = None

        if isinstance(layer, qconv_cls):
            new_layer = layers.Conv2D(
                filters=config["filters"],
                kernel_size=config["kernel_size"],
                strides=config["strides"],
                padding=config["padding"],
                data_format=config["data_format"],
                dilation_rate=config.get("dilation_rate", (1, 1)),
                groups=config.get("groups", 1),
                activation=config["activation"],
                use_bias=config["use_bias"],
                name=config["name"],
            )
        elif isinstance(layer, qdense_cls):
            new_layer = layers.Dense(
                units=config["units"],
                activation=config["activation"],
                use_bias=config["use_bias"],
                name=config["name"],
            )
        elif isinstance(layer, layers.InputLayer):
            continue
        else:
            new_layer = layer.__class__.from_config(config)

        new_layer.build(current_shape)
        if weights:
            new_layer.set_weights(weights[: len(new_layer.weights)])
        vanilla_model.add(new_layer)
        current_shape = new_layer.compute_output_shape(current_shape)

    return vanilla_model


def find_input_layer_name(config: dict[str, Any]) -> str | None:
    for name in config.get("LayerName", {}):
        if "input" in name.lower():
            return name
    return None


def strip_layer_precision_config(config: dict[str, Any]) -> None:
    for layer_config in config.get("LayerName", {}).values():
        if isinstance(layer_config, dict):
            layer_config.pop("Precision", None)


def build_parallel_config(hls4ml: Any, model: Any, args: argparse.Namespace) -> dict[str, Any]:
    config = hls4ml.utils.config_from_keras_model(model, granularity="name", backend=args.backend)
    strip_layer_precision_config(config)
    config.setdefault("Model", {})["Strategy"] = args.strategy
    config["Model"]["ReuseFactor"] = args.reuse_factor
    return config


def build_stream_config(
    hls4ml: Any,
    model: Any,
    layer_precisions: dict[str, str],
    args: argparse.Namespace,
) -> dict[str, Any]:
    config = hls4ml.utils.config_from_keras_model(
        model,
        granularity="name",
        backend=args.backend,
        default_precision="ap_fixed<16,6>",
    )
    config.setdefault("Model", {})["Strategy"] = args.strategy
    config["Model"]["ReuseFactor"] = args.reuse_factor

    for layer_name, precision in layer_precisions.items():
        if layer_name not in config.get("LayerName", {}):
            print(f"[WARNING] Layer '{layer_name}' not found in IOStream config.")
            continue
        result_precision = args.dense_result_precision if layer_name == "q_dense" else precision
        config["LayerName"][layer_name]["Precision"] = {
            "weight": precision,
            "bias": precision,
            "result": result_precision,
        }

    input_name = find_input_layer_name(config)
    if input_name is not None:
        config["LayerName"][input_name]["Precision"] = {"result": args.input_precision}
        config["LayerName"][input_name]["StreamDepth"] = args.input_stream_depth

    return config


def prepare_test_data(data_dir: Path, model_input_shape: tuple[int, ...]) -> tuple[np.ndarray, np.ndarray] | None:
    x_path = data_dir / "X_test_data.npy"
    y_path = data_dir / "y_test_labels.npy"
    if not x_path.exists() or not y_path.exists():
        print("[WARNING] Test data not found; skipping prediction checks.")
        return None

    x_test = np.load(x_path)
    y_test = np.load(y_path)
    if x_test.ndim == 4 and x_test.shape[-1] == 1:
        x_test = x_test.squeeze(axis=-1)
    if tuple(x_test.shape[1:]) == model_input_shape:
        x_prepared = x_test
    elif x_test.ndim == 3 and tuple(x_test.shape[1:][::-1]) == model_input_shape:
        x_prepared = np.transpose(x_test, (0, 2, 1))
    else:
        raise ValueError(f"Unsupported X_test shape {x_test.shape}; model expects {model_input_shape}.")
    return np.ascontiguousarray(x_prepared), y_test


def verify_predictions(hls_model: Any, keras_model: Any, data_dir: Path, model_input_shape: tuple[int, ...], label: str) -> None:
    prepared = prepare_test_data(data_dir, model_input_shape)
    if prepared is None:
        return

    x_test, y_test = prepared
    print("=" * 40)
    print(f"[TEST] {label}")
    print("=" * 40)
    y_hls = hls_model.predict(x_test)
    y_keras = keras_model.predict(x_test)

    y_hls_bin = (y_hls > 0).astype(int).flatten()
    y_keras_bin = (y_keras > 0).astype(int).flatten()
    y_label_bin = y_test.astype(int).flatten()
    accuracy = float(np.mean(y_label_bin == y_hls_bin))
    fidelity = float(np.mean(y_keras_bin == y_hls_bin))
    max_abs_diff = float(np.max(np.abs(y_hls.flatten() - y_keras.flatten())))
    print(f"   HLS accuracy:       {accuracy:.4f}")
    print(f"   HLS/Keras fidelity: {fidelity:.4f}")
    print(f"   Max abs score diff: {max_abs_diff:.6g}")


def convert_project(
    hls4ml: Any,
    model: Any,
    hls_config: dict[str, Any],
    output_dir: Path,
    io_type: str,
    args: argparse.Namespace,
) -> Any:
    if output_dir.exists():
        shutil.rmtree(output_dir)

    print(f"[INFO] Converting {io_type} project -> {output_dir}")
    hls_model = hls4ml.converters.convert_from_keras_model(
        model,
        hls_config=hls_config,
        output_dir=str(output_dir),
        project_name=args.project_name,
        io_type=io_type,
        backend=args.backend,
        part=args.part,
        clock_period=args.clock_period,
    )
    hls_model.write()
    return hls_model


def extract_typedefs(defines_h: Path) -> dict[str, str]:
    typedefs: dict[str, str] = {}
    pattern = re.compile(r"^\s*typedef\s+(.+?)\s+(\w+)\s*;")
    for line in defines_h.read_text().splitlines():
        match = pattern.match(line)
        if match:
            typedefs[match.group(2)] = match.group(1)
    return typedefs


def extract_struct_constants(parameters_h: Path) -> dict[str, dict[str, str]]:
    structs: dict[str, dict[str, str]] = {}
    current: str | None = None
    struct_re = re.compile(r"^\s*struct\s+(\w+)")
    const_re = re.compile(r"^\s*static const (?:unsigned|bool|nnet::\w+|nnet::\w+::\w+)\s+(\w+)\s*=\s*([^;]+);")
    for line in parameters_h.read_text().splitlines():
        struct_match = struct_re.match(line)
        if struct_match:
            current = struct_match.group(1)
            structs[current] = {}
            continue
        if current and line.strip().startswith("};"):
            current = None
            continue
        if current:
            const_match = const_re.match(line)
            if const_match:
                structs[current][const_match.group(1)] = const_match.group(2).strip()
    return structs


def extract_function(text: str, function_name: str) -> str | None:
    marker = f"void {function_name}"
    start = text.find(marker)
    if start < 0:
        return None
    brace = text.find("{", start)
    if brace < 0:
        return None
    depth = 0
    for index in range(brace, len(text)):
        char = text[index]
        if char == "{":
            depth += 1
        elif char == "}":
            depth -= 1
            if depth == 0:
                return text[start : index + 1]
    return None


def extract_weights(weights_dir: Path) -> dict[str, dict[str, str]]:
    weights: dict[str, dict[str, str]] = {}
    for header in sorted(weights_dir.glob("*.h")):
        text = header.read_text()
        shape_match = re.search(r"//Numpy array shape \[(.*?)\]", text)
        zeros_match = re.search(r"//Number of zeros ([0-9]+)", text)
        weights[header.stem] = {
            "header": str(header),
            "text": str(header.with_suffix(".txt")),
            "shape": shape_match.group(1) if shape_match else "",
            "zeros": zeros_match.group(1) if zeros_match else "",
        }
    return weights


def write_reference_manifest(parallel_project: Path, stream_project: Path, build_dir: Path) -> Path:
    parallel_fw = parallel_project / "firmware"
    stream_fw = stream_project / "firmware"
    code_gen_text = (parallel_fw / "nnet_utils" / "nnet_code_gen.h").read_text()

    manifest = {
        "parallel_project": str(parallel_project),
        "stream_project": str(stream_project),
        "parallel": {
            "typedefs": extract_typedefs(parallel_fw / "defines.h"),
            "configs": extract_struct_constants(parallel_fw / "parameters.h"),
            "weights": extract_weights(parallel_fw / "weights"),
            "quantizers": {
                "q_conv2d_iq": extract_function(code_gen_text, "q_conv2d_iq"),
                "q_dense_iq": extract_function(code_gen_text, "q_dense_iq"),
            },
        },
        "stream": {
            "typedefs": extract_typedefs(stream_fw / "defines.h"),
            "configs": extract_struct_constants(stream_fw / "parameters.h"),
            "weights": extract_weights(stream_fw / "weights"),
        },
    }

    path = build_dir / "hgq_reference_manifest.json"
    path.write_text(json.dumps(manifest, indent=2, sort_keys=True))
    print(f"[INFO] Wrote HGQ reference manifest: {path}")
    return path


def install_stream_baseline(stream_project: Path, manifest_path: Path, output_dir: Path) -> None:
    replace_directory(stream_project, output_dir)
    shutil.copy2(manifest_path, output_dir / "hgq_reference_manifest.json")
    print(f"[INFO] Installed IOStream baseline at {output_dir}")


def main() -> int:
    args = parse_args()
    hls4ml, keras, custom_objects = import_dependencies()

    build_dir = rel(args.build_dir)
    parallel_project = build_dir / "ioparallel_reference"
    stream_project = build_dir / "iostream_candidate"
    output_dir = rel(args.output_dir)
    data_dir = rel(args.data_dir)
    streaming_firmware_dir = rel(args.streaming_firmware_dir)

    prepare_build_dir(build_dir, args.keep_build)

    model_path = rel(args.model_path)
    print(f"[INFO] Loading HGQ model: {model_path}")
    hgq_model = keras.models.load_model(model_path, custom_objects=custom_objects)
    model_input_shape = get_model_input_shape(hgq_model)
    print(f"[INFO] Model input shape: {model_input_shape}")

    parallel_config = build_parallel_config(hls4ml, hgq_model, args)
    parallel_hls = convert_project(hls4ml, hgq_model, parallel_config, parallel_project, "io_parallel", args)
    if not args.skip_compile:
        print("[INFO] Compiling IOParallel reference.")
        parallel_hls.compile()
    if not args.skip_verify:
        verify_predictions(parallel_hls, hgq_model, data_dir, model_input_shape, "IOParallel HGQ reference")

    layer_precisions = collect_layer_precisions(hgq_model)
    stream_model = build_vanilla_model(keras, hgq_model, custom_objects)
    stream_config = build_stream_config(hls4ml, stream_model, layer_precisions, args)
    stream_hls = convert_project(hls4ml, stream_model, stream_config, stream_project, "io_stream", args)
    if not args.skip_compile:
        print("[INFO] Compiling IOStream candidate.")
        stream_hls.compile()
    if not args.skip_verify:
        verify_predictions(stream_hls, stream_model, data_dir, model_input_shape, "IOStream candidate")

    manifest_path = write_reference_manifest(parallel_project, stream_project, build_dir)

    if args.install:
        install_stream_baseline(stream_project, manifest_path, output_dir)
        if args.init_streaming:
            replace_directory(output_dir / "firmware", streaming_firmware_dir)
            print(f"[INFO] Initialized HLS streaming firmware at {streaming_firmware_dir}")
    else:
        print("[INFO] Not installing output. Re-run with --install to overwrite cnn_core_project.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

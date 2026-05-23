#!/usr/bin/env python3
"""Build an HGQ-informed IOStream baseline.

The pipeline intentionally separates numerical truth from hardware structure:

1. Generate an IOParallel HGQ reference project under build/.
2. Generate an IOStream project under build/.
3. Extract propagated precisions, layer configs, per-index quantizers, and
   weights from the IOParallel reference.
4. Apply the safe IOParallel-derived reference data to the IOStream project
   while preserving the stream interface and layer graph.
5. Install the patched IOStream project as cnn_core_project and save the
   extracted HGQ reference data next to it for the streaming patching step.

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
    parser.add_argument(
        "--skip-apply-hgq-reference",
        action="store_true",
        help="Leave the generated IOStream project in vanilla hls4ml form instead of applying IOParallel HGQ reference data.",
    )
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


def print_reference_summary(manifest_path: Path) -> None:
    manifest = json.loads(manifest_path.read_text())
    parallel = manifest["parallel"]
    typedefs = parallel["typedefs"]
    configs = parallel["configs"]
    quantizers = parallel["quantizers"]
    print("[INFO] HGQ reference summary:")
    for alias in (
        "q_conv2d_t",
        "q_conv2d_weight_t",
        "q_conv2d_bias_t",
        "q_conv2d_relu_t",
        "max_pooling2d_t",
        "q_dense_weight_t",
        "q_dense_bias_t",
        "result_t",
    ):
        if alias in typedefs:
            print(f"   {alias:<22} {typedefs[alias]}")
    dense_config = configs.get("config9", {})
    if dense_config:
        print(
            "   dense sparsity         "
            f"n_zeros={dense_config.get('n_zeros', '?')}, "
            f"n_nonzeros={dense_config.get('n_nonzeros', '?')}"
        )
    for name, body in quantizers.items():
        status = "present" if body else "missing"
        print(f"   quantizer {name:<12} {status}")


def stream_array_type(scalar_type: str, width_expr: str) -> str:
    return f"nnet::array<{scalar_type}, {width_expr}>"


def replace_typedef(text: str, alias: str, target_type: str) -> str:
    pattern = re.compile(rf"^(\s*typedef\s+)(.+?)(\s+{re.escape(alias)}\s*;)", re.MULTILINE)
    replacement = rf"\g<1>{target_type}\g<3>"
    new_text, count = pattern.subn(replacement, text, count=1)
    if count != 1:
        raise ValueError(f"Could not replace typedef for {alias}")
    return new_text


def append_missing_typedef(text: str, alias: str, target_type: str) -> str:
    if re.search(rf"^\s*typedef\s+.+?\s+{re.escape(alias)}\s*;", text, re.MULTILINE):
        return text
    marker = "// hls-fpga-machine-learning insert emulator-defines"
    typedef_line = f"typedef {target_type} {alias};\n"
    if marker not in text:
        return text + "\n" + typedef_line
    return text.replace(marker, typedef_line + "\n" + marker, 1)


def replace_struct_constant(text: str, struct_name: str, const_name: str, value: str) -> str:
    struct_pattern = re.compile(rf"(struct\s+{re.escape(struct_name)}\b.*?\{{)(.*?)(^\s*\}};)", re.DOTALL | re.MULTILINE)
    struct_match = struct_pattern.search(text)
    if not struct_match:
        raise ValueError(f"Could not find struct {struct_name}")

    body = struct_match.group(2)
    const_pattern = re.compile(
        rf"^(\s*static const (?:unsigned|bool|nnet::\w+|nnet::\w+::\w+)\s+{re.escape(const_name)}\s*=\s*)([^;]+)(;)",
        re.MULTILINE,
    )
    body, count = const_pattern.subn(rf"\g<1>{value}\g<3>", body, count=1)
    if count != 1:
        raise ValueError(f"Could not replace {struct_name}::{const_name}")
    return text[: struct_match.start(2)] + body + text[struct_match.end(2) :]


def replace_struct_typedef(text: str, struct_name: str, typedef_name: str, value: str) -> str:
    struct_pattern = re.compile(rf"(struct\s+{re.escape(struct_name)}\b.*?\{{)(.*?)(^\s*\}};)", re.DOTALL | re.MULTILINE)
    struct_match = struct_pattern.search(text)
    if not struct_match:
        raise ValueError(f"Could not find struct {struct_name}")

    body = struct_match.group(2)
    typedef_pattern = re.compile(rf"^(\s*typedef\s+)(.+?)(\s+{re.escape(typedef_name)}\s*;)", re.MULTILINE)
    body, count = typedef_pattern.subn(rf"\g<1>{value}\g<3>", body, count=1)
    if count != 1:
        raise ValueError(f"Could not replace typedef {struct_name}::{typedef_name}")
    return text[: struct_match.start(2)] + body + text[struct_match.end(2) :]


def rename_weight_header(text: str, src_name: str, dst_name: str) -> str:
    text = re.sub(rf"\b{re.escape(src_name)}\b", dst_name, text)
    text = re.sub(rf"\b{re.escape(src_name.upper())}_H_\b", f"{dst_name.upper()}_H_", text)
    return text


def copy_renamed_weight(src: Path, dst: Path, src_name: str, dst_name: str) -> None:
    if not src.exists():
        raise FileNotFoundError(f"Missing source weight file: {src}")
    dst.parent.mkdir(parents=True, exist_ok=True)
    if src.suffix == ".h":
        dst.write_text(rename_weight_header(src.read_text(), src_name, dst_name))
    else:
        shutil.copy2(src, dst)


def extract_quantizer_casts(function_body: str | None) -> list[tuple[int, str]]:
    if not function_body:
        raise ValueError("Missing quantizer function body")
    casts: list[tuple[int, str]] = []
    assignment_re = re.compile(r"out\[(\d+)\]\s*=\s*(ap_u?fixed<[^>]+>)\(inp\[\d+\]\);")
    for match in assignment_re.finditer(function_body):
        casts.append((int(match.group(1)), match.group(2)))
    if not casts:
        raise ValueError("Could not extract quantizer casts")
    casts.sort(key=lambda item: item[0])
    return casts


def render_quantizer_struct(name: str, casts: list[tuple[int, str]]) -> str:
    lines = [
        f"struct {name} {{",
        "    template <class in_T, class out_T>",
        "    static out_T cast(in_T value, unsigned index) {",
        "        #pragma HLS INLINE",
        "        switch (index) {",
    ]
    for index, cast_type in casts:
        lines.append(f"        case {index}: return (out_T) {cast_type}(value);")
    lines.extend(
        [
            "        default: return (out_T) value;",
            "        }",
            "    }",
            "};",
        ]
    )
    return "\n".join(lines)


def write_hgq_stream_header(firmware_dir: Path, quantizers: dict[str, str | None]) -> None:
    conv_casts = extract_quantizer_casts(quantizers.get("q_conv2d_iq"))
    dense_casts = extract_quantizer_casts(quantizers.get("q_dense_iq"))
    header = f"""#ifndef NNET_HGQ_STREAM_H_
#define NNET_HGQ_STREAM_H_

#include "hls_stream.h"
#include "nnet_common.h"
#include "nnet_types.h"

namespace nnet {{

template <class data_T, class res_T, unsigned N_IN, class CAST_T>
void hgq_quantize_stream(hls::stream<data_T> &data_stream, hls::stream<res_T> &res_stream) {{
    #pragma HLS INLINE off
    static_assert(data_T::size == res_T::size, "HGQ stream quantizer preserves packet width.");
    static_assert(N_IN % data_T::size == 0, "HGQ stream quantizer expects full stream packets.");

QuantizePackets:
    for (unsigned i_in = 0; i_in < N_IN / data_T::size; i_in++) {{
        #pragma HLS PIPELINE
        data_T data_pack = data_stream.read();
        res_T res_pack;
        PRAGMA_DATA_PACK(res_pack)
    QuantizePack:
        for (int i_pack = 0; i_pack < data_T::size; i_pack++) {{
            #pragma HLS UNROLL
            const unsigned index = i_in * data_T::size + i_pack;
            res_pack[i_pack] = CAST_T::template cast<typename data_T::value_type, typename res_T::value_type>(
                data_pack[i_pack], index);
        }}
        res_stream.write(res_pack);
    }}
}}

{render_quantizer_struct("q_conv2d_iq_cast", conv_casts)}

{render_quantizer_struct("q_dense_iq_cast", dense_casts)}

}} // namespace nnet

#endif
"""
    output = firmware_dir / "nnet_utils" / "nnet_hgq_stream.h"
    output.write_text(header)
    print(f"[CONFIG] wrote HGQ stream quantizer header: {output}")


def insert_include_once(text: str, include_line: str) -> str:
    if include_line in text:
        return text
    marker = '#include "nnet_utils/nnet_stream.h"'
    if marker in text:
        return text.replace(marker, marker + "\n" + include_line, 1)
    return text.replace("// hls-fpga-machine-learning insert includes", "// hls-fpga-machine-learning insert includes\n" + include_line, 1)


def patch_cnn_core_for_stream_quantizers(cnn_core_cpp: Path) -> None:
    text = cnn_core_cpp.read_text()
    if "hgq_quantize_stream" in text:
        return

    text = text.replace(
        '    hls::stream<layer3_t> layer3_out("layer3_out");\n'
        '    #pragma HLS STREAM variable=layer3_out depth=336\n',
        '    hls::stream<layer2_iq_t> q_conv2d_iq_out("q_conv2d_iq_out");\n'
        '    #pragma HLS STREAM variable=q_conv2d_iq_out depth=1024\n\n'
        '    hls::stream<layer3_t> layer3_out("layer3_out");\n'
        '    #pragma HLS STREAM variable=layer3_out depth=336\n',
    )
    text = text.replace(
        '    auto& layer6_out = layer5_out;\n'
        '    nnet::repack_stream<input_t, layer2_t, 1024>(input_layer, layer8_out); // repack_reshape\n\n'
        '    nnet::conv_2d_cl<layer2_t, layer3_t, config3>(layer8_out, layer3_out, w3, b3); // q_conv2d\n',
        '    hls::stream<layer5_iq_t> q_dense_iq_out("q_dense_iq_out");\n'
        '    #pragma HLS STREAM variable=q_dense_iq_out depth=168\n\n'
        '    auto& layer6_out = q_dense_iq_out;\n'
        '    nnet::repack_stream<input_t, layer2_t, 1024>(input_layer, layer8_out); // repack_reshape\n\n'
        '    nnet::hgq_quantize_stream<layer2_t, layer2_iq_t, 1024, nnet::q_conv2d_iq_cast>(layer8_out, q_conv2d_iq_out); // q_conv2d_iq\n\n'
        '    nnet::conv_2d_cl<layer2_iq_t, layer3_t, config3>(q_conv2d_iq_out, layer3_out, w3, b3); // q_conv2d\n',
    )
    text = text.replace(
        '    nnet::pooling2d_cl<layer4_t, layer5_t, config5>(layer4_out, layer5_out); // max_pooling2d\n\n'
        '    nnet::dense<layer5_t, result_t, config7>(layer6_out, layer7_out, w7, b7); // q_dense\n',
        '    nnet::pooling2d_cl<layer4_t, layer5_t, config5>(layer4_out, layer5_out); // max_pooling2d\n\n'
        '    nnet::hgq_quantize_stream<layer5_t, layer5_iq_t, 1176, nnet::q_dense_iq_cast>(layer5_out, q_dense_iq_out); // q_dense_iq\n\n'
        '    nnet::dense<layer5_iq_t, result_t, config7>(layer6_out, layer7_out, w7, b7); // q_dense\n',
    )
    cnn_core_cpp.write_text(text)
    print("[CONFIG] inserted HGQ stream quantizers into cnn_core.cpp")


def apply_hgq_reference_to_stream_project(stream_project: Path, manifest_path: Path) -> None:
    manifest = json.loads(manifest_path.read_text())
    parallel = manifest["parallel"]
    parallel_typedefs = parallel["typedefs"]
    parallel_configs = parallel["configs"]
    parallel_weights = parallel["weights"]
    parallel_quantizers = parallel["quantizers"]
    firmware_dir = stream_project / "firmware"

    print("[INFO] Applying IOParallel HGQ reference to IOStream project.")

    defines_h = firmware_dir / "defines.h"
    defines_text = defines_h.read_text()
    optional_scalar_typedefs = {
        "q_conv2d_iq_t": parallel_typedefs.get("q_conv2d_iq_t"),
        "q_conv2d_t": parallel_typedefs.get("q_conv2d_t"),
        "q_conv2d_accum_t": parallel_typedefs.get("q_conv2d_accum_t"),
        "q_dense_iq_t": parallel_typedefs.get("q_dense_iq_t"),
        "q_dense_accum_t": parallel_typedefs.get("q_dense_accum_t"),
        "max_pooling2d_t": parallel_typedefs.get("max_pooling2d_t"),
    }
    for alias, target_type in optional_scalar_typedefs.items():
        if target_type:
            defines_text = append_missing_typedef(defines_text, alias, target_type)

    typedef_replacements = {
        "layer3_t": stream_array_type(parallel_typedefs["q_conv2d_t"], "7*1"),
        "q_conv2d_weight_t": parallel_typedefs["q_conv2d_weight_t"],
        "q_conv2d_bias_t": parallel_typedefs["q_conv2d_bias_t"],
        "layer4_t": stream_array_type(parallel_typedefs["q_conv2d_relu_t"], "7*1"),
        "max_pooling2d_accum_t": parallel_typedefs["max_pooling2d_accum_t"],
        "layer5_t": stream_array_type(parallel_typedefs["max_pooling2d_t"], "7*1"),
        "result_t": stream_array_type(parallel_typedefs["result_t"], "1*1"),
        "q_dense_weight_t": parallel_typedefs["q_dense_weight_t"],
        "q_dense_bias_t": parallel_typedefs["q_dense_bias_t"],
    }
    for alias, target_type in typedef_replacements.items():
        defines_text = replace_typedef(defines_text, alias, target_type)
        print(f"[CONFIG] typedef {alias} -> {target_type}")
    defines_text = append_missing_typedef(defines_text, "layer2_iq_t", stream_array_type(parallel_typedefs["q_conv2d_iq_t"], "1*1"))
    defines_text = append_missing_typedef(defines_text, "layer5_iq_t", stream_array_type(parallel_typedefs["q_dense_iq_t"], "7*1"))
    defines_h.write_text(defines_text)

    parameters_h = firmware_dir / "parameters.h"
    parameters_text = parameters_h.read_text()
    parameters_text = insert_include_once(parameters_text, '#include "nnet_utils/nnet_hgq_stream.h"')
    config_map = {
        "config3_mult": "config4_mult",
        "config3": "config4",
        "config5": "config6",
        "config7": "config9",
    }
    for stream_config, parallel_config in config_map.items():
        parallel_constants = parallel_configs.get(parallel_config, {})
        for const_name in ("n_zeros", "n_nonzeros"):
            if const_name in parallel_constants:
                parameters_text = replace_struct_constant(parameters_text, stream_config, const_name, parallel_constants[const_name])
                print(f"[CONFIG] {stream_config}::{const_name} -> {parallel_constants[const_name]}")

    parameters_text = replace_struct_typedef(parameters_text, "config3_mult", "accum_t", "q_conv2d_accum_t")
    parameters_text = replace_struct_typedef(parameters_text, "config3", "accum_t", "q_conv2d_accum_t")
    parameters_text = replace_struct_typedef(parameters_text, "config5", "accum_t", "max_pooling2d_accum_t")
    parameters_text = replace_struct_typedef(parameters_text, "config7", "accum_t", "q_dense_accum_t")
    parameters_h.write_text(parameters_text)

    weight_map = {
        "w4": "w3",
        "b4": "b3",
        "w9": "w7",
        "b9": "b7",
    }
    stream_weights_dir = firmware_dir / "weights"
    for src_name, dst_name in weight_map.items():
        weight_info = parallel_weights.get(src_name)
        if not weight_info:
            raise ValueError(f"Missing parallel weight metadata for {src_name}")
        src_header = Path(weight_info["header"])
        src_text = Path(weight_info["text"])
        copy_renamed_weight(src_header, stream_weights_dir / f"{dst_name}.h", src_name, dst_name)
        copy_renamed_weight(src_text, stream_weights_dir / f"{dst_name}.txt", src_name, dst_name)
        print(f"[CONFIG] copied parallel weight {src_name} -> stream {dst_name}")

    write_hgq_stream_header(firmware_dir, parallel_quantizers)
    patch_cnn_core_for_stream_quantizers(firmware_dir / "cnn_core.cpp")

    manifest["applied_to_stream"] = {
        "safe_precision_typedefs": sorted(typedef_replacements),
        "copied_weights": weight_map,
        "notes": [
            "The stream interface and layer graph are preserved.",
            "IOParallel per-index quantizer functions are converted into stream quantizer layers before q_conv2d and q_dense.",
        ],
    }
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True))
    print("[INFO] HGQ reference applied to IOStream project.")


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
    manifest_path = write_reference_manifest(parallel_project, stream_project, build_dir)
    print_reference_summary(manifest_path)
    if args.skip_apply_hgq_reference:
        print("[INFO] Leaving IOStream candidate in vanilla hls4ml form.")
    else:
        apply_hgq_reference_to_stream_project(stream_project, manifest_path)

    if not args.skip_compile:
        print("[INFO] Compiling IOStream candidate.")
        stream_hls.compile()
    if not args.skip_verify:
        label = "IOStream candidate" if args.skip_apply_hgq_reference else "HGQ-guided IOStream candidate"
        verify_predictions(stream_hls, stream_model, data_dir, model_input_shape, label)

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

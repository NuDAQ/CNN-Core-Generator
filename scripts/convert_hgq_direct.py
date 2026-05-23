#!/usr/bin/env python3
"""Direct HGQ/Keras to hls4ml conversion for the CNN trigger core.

This script is intended to create a new generated baseline from the HGQ model
itself. Unlike convert_homogeneous.py, it does not replace HGQ layers with
plain Keras layers and does not manually derive per-layer precision in its
default mode. The goal is to preserve hls4ml's HGQ precision propagation while
keeping the important project-level choices close to the existing flow: Vitis
backend, the same target part, latency strategy, and reuse factor 1.
"""

from __future__ import annotations

import argparse
import inspect
import os
import shutil
import sys
from pathlib import Path
from typing import Any


DEFAULT_MODEL_PATH = "models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras"
DEFAULT_OUTPUT_DIR = "cnn_core_project"
DEFAULT_DATA_DIR = "data"
DEFAULT_STREAMING_FIRMWARE_DIR = "hls_streaming/firmware"
DEFAULT_BACKEND = "Vitis"
DEFAULT_PART = "xcku5p-ffvb676-2-e"
DEFAULT_PROJECT_NAME = "cnn_core"
DEFAULT_IO_TYPE = "io_parallel"
DEFAULT_CLOCK_PERIOD = 5
DEFAULT_INPUT_STREAM_DEPTH = 16
DEFAULT_INPUT_PRECISION = "ap_fixed<12,6>"
DEFAULT_DENSE_RESULT_PRECISION = "ap_fixed<16,6>"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert the HGQ CNN model directly with hls4ml."
    )
    parser.add_argument("--model-path", default=DEFAULT_MODEL_PATH)
    parser.add_argument("--output-dir", default=DEFAULT_OUTPUT_DIR)
    parser.add_argument("--data-dir", default=DEFAULT_DATA_DIR)
    parser.add_argument("--project-name", default=DEFAULT_PROJECT_NAME)
    parser.add_argument("--backend", default=DEFAULT_BACKEND)
    parser.add_argument("--part", default=DEFAULT_PART)
    parser.add_argument("--io-type", default=DEFAULT_IO_TYPE, choices=("io_stream", "io_parallel"))
    parser.add_argument("--clock-period", type=float, default=DEFAULT_CLOCK_PERIOD)
    parser.add_argument("--reuse-factor", type=int, default=1)
    parser.add_argument("--strategy", default="Latency", choices=("Latency", "Resource"))
    parser.add_argument("--input-stream-depth", type=int, default=DEFAULT_INPUT_STREAM_DEPTH)
    parser.add_argument(
        "--conversion-mode",
        default="direct",
        choices=("auto", "direct", "vanilla-stream"),
        help=(
            "direct keeps HGQ precision propagation authoritative. auto tries direct "
            "first and falls back to vanilla-stream only for the known HGQ "
            "heterogeneous activation/io_stream limitation."
        ),
    )
    parser.add_argument(
        "--hls-config-mode",
        default="minimal",
        choices=("minimal", "none"),
        help=(
            "minimal keeps model-level Strategy/ReuseFactor and input stream depth "
            "without overriding HGQ layer precision; none passes no hls_config."
        ),
    )
    parser.add_argument("--input-precision", default=DEFAULT_INPUT_PRECISION)
    parser.add_argument("--dense-result-precision", default=DEFAULT_DENSE_RESULT_PRECISION)
    parser.add_argument(
        "--bit-exact",
        default="auto",
        choices=("auto", "true", "false"),
        help="Pass bit_exact to hls4ml when supported. auto lets hls4ml decide.",
    )
    parser.add_argument("--skip-compile", action="store_true")
    parser.add_argument("--skip-verify", action="store_true")
    parser.add_argument(
        "--init-streaming",
        action="store_true",
        help=(
            "After generating the baseline project, replace hls_streaming/firmware "
            "with the generated firmware."
        ),
    )
    parser.add_argument(
        "--streaming-firmware-dir",
        default=DEFAULT_STREAMING_FIRMWARE_DIR,
        help="Firmware directory to initialize when --init-streaming is used.",
    )
    args = parser.parse_args()
    if args.skip_compile and not args.skip_verify:
        parser.error("--skip-compile requires --skip-verify because hls_model.predict() needs the compiled library.")
    return args


def import_dependencies() -> tuple[Any, Any, dict[str, Any]]:
    try:
        import hls4ml
    except ImportError as exc:
        print(f"[ERROR] Missing conversion dependency: {exc}", file=sys.stderr)
        print(
            "[HINT] Install a conversion environment with hls4ml, keras/tensorflow, "
            "hgq, and numpy.",
            file=sys.stderr,
        )
        raise

    try:
        import keras
    except ImportError:
        try:
            from tensorflow import keras
        except ImportError as exc:
            print(f"[ERROR] Missing Keras dependency: {exc}", file=sys.stderr)
            raise

    try:
        import hgq  # noqa: F401
        from hgq.layers import QConv2D, QDense
    except ImportError as exc:
        print(f"[ERROR] Missing HGQ dependency: {exc}", file=sys.stderr)
        raise

    custom_objects = {"QConv2D": QConv2D, "QDense": QDense}
    return hls4ml, keras, custom_objects


def get_model_input_shape(model: Any) -> tuple[int, ...]:
    input_shape = model.input_shape
    if isinstance(input_shape, list):
        input_shape = input_shape[0]
    if input_shape is None:
        raise ValueError("Unable to determine model input shape")
    return tuple(input_shape[1:])


def print_model_summary(model: Any) -> None:
    print("[INFO] Keras model summary:")
    model.summary(print_fn=lambda line: print(f"   {line}"))


def build_direct_hls_config(hls4ml: Any, model: Any, args: argparse.Namespace) -> dict[str, Any]:
    print("[INFO] Building minimal hls4ml config.")
    print("[INFO] HGQ layer precision is not manually overridden.")

    config_kwargs = supported_kwargs(
        hls4ml.utils.config_from_keras_model,
        {
            "model": model,
            "granularity": "name",
            "backend": args.backend,
        },
    )
    config = hls4ml.utils.config_from_keras_model(**config_kwargs)
    strip_layer_precision_config(config)

    model_config = config.setdefault("Model", {})
    model_config["Strategy"] = args.strategy
    model_config["ReuseFactor"] = args.reuse_factor

    input_layer_name = find_input_layer_name(config)
    if input_layer_name is not None and args.io_type == "io_stream":
        config["LayerName"][input_layer_name]["StreamDepth"] = args.input_stream_depth
        print(
            f"[CONFIG] Input layer '{input_layer_name}' StreamDepth -> "
            f"{args.input_stream_depth}"
        )
    elif args.io_type == "io_stream":
        print("[WARNING] No input layer found in hls4ml config; StreamDepth not set.")

    return config


def build_vanilla_hls_config(
    hls4ml: Any,
    vanilla_model: Any,
    layer_precisions: dict[str, str],
    args: argparse.Namespace,
) -> dict[str, Any]:
    print("[INFO] Building vanilla-stream hls4ml config.")
    print("[INFO] HGQ layer precision is converted to explicit hls4ml layer precision.")

    config_kwargs = supported_kwargs(
        hls4ml.utils.config_from_keras_model,
        {
            "model": vanilla_model,
            "granularity": "name",
            "backend": args.backend,
            "default_precision": "ap_fixed<16,6>",
        },
    )
    config = hls4ml.utils.config_from_keras_model(**config_kwargs)

    model_config = config.setdefault("Model", {})
    model_config["Strategy"] = args.strategy
    model_config["ReuseFactor"] = args.reuse_factor

    for layer_name, precision in layer_precisions.items():
        if layer_name not in config.get("LayerName", {}):
            print(f"[WARNING] Layer '{layer_name}' not found in hls4ml config; precision not applied.")
            continue

        result_precision = args.dense_result_precision if layer_name == "q_dense" else precision
        config["LayerName"][layer_name]["Precision"] = {
            "weight": precision,
            "bias": precision,
            "result": result_precision,
        }
        print(f"[CONFIG] Layer '{layer_name}' -> {config['LayerName'][layer_name]['Precision']}")

    input_layer_name = find_input_layer_name(config)
    if input_layer_name is not None:
        config["LayerName"][input_layer_name]["Precision"] = {"result": args.input_precision}
        if args.io_type == "io_stream":
            config["LayerName"][input_layer_name]["StreamDepth"] = args.input_stream_depth
        print(f"[CONFIG] Input layer '{input_layer_name}' result -> {args.input_precision}")
    else:
        print("[WARNING] No input layer found in hls4ml config; input precision not set.")

    return config


def get_quant_bits(q_conf: dict[str, Any] | None) -> tuple[int, int]:
    """Extract total and integer bits from an HGQ quantizer config."""
    if q_conf and "config" in q_conf:
        config = q_conf["config"]
        if "i0" in config and "f0" in config:
            sign_bits = int(config.get("k0", 0))
            int_bits = int(config["i0"])
            frac_bits = int(config["f0"])
            return sign_bits + int_bits + frac_bits, sign_bits + int_bits
    return 0, 0


def collect_layer_precisions(model: Any) -> dict[str, str]:
    layer_precisions: dict[str, str] = {}

    for layer in model.layers:
        layer_config = layer.get_config()
        kernel_total, kernel_int = get_quant_bits(layer_config.get("kq_conf"))
        bias_total, bias_int = get_quant_bits(layer_config.get("bq_conf"))
        input_total, input_int = get_quant_bits(layer_config.get("iq_conf"))

        local_total = max(kernel_total, bias_total, input_total)
        local_int = max(kernel_int, bias_int, input_int)

        if local_total == 0:
            print(f"   Layer {layer.name:<15} -> [Skipping] (Will inherit precision)")
            continue

        local_total = max(local_total, 4)
        local_int = max(local_int, 2)
        precision = f"ap_fixed<{local_total},{local_int}>"
        layer_precisions[layer.name] = precision
        print(f"   Layer {layer.name:<15} -> {precision}")

    return layer_precisions


def build_vanilla_model(keras: Any, hgq_model: Any, custom_objects: dict[str, Any]) -> Any:
    """Replace HGQ layers with ordinary Keras layers for io_stream fallback."""
    layers = keras.layers
    qconv_cls = custom_objects["QConv2D"]
    qdense_cls = custom_objects["QDense"]
    model_input_shape = get_model_input_shape(hgq_model)

    vanilla_model = keras.Sequential(name=f"{hgq_model.name}_vanilla")
    vanilla_model.add(layers.InputLayer(shape=model_input_shape, name="input_layer"))
    current_shape = (None,) + model_input_shape

    for layer in hgq_model.layers:
        layer_config = layer.get_config()
        weights = layer.get_weights()
        new_layer = None

        if isinstance(layer, qconv_cls):
            new_layer = layers.Conv2D(
                filters=layer_config["filters"],
                kernel_size=layer_config["kernel_size"],
                strides=layer_config["strides"],
                padding=layer_config["padding"],
                data_format=layer_config["data_format"],
                dilation_rate=layer_config.get("dilation_rate", (1, 1)),
                groups=layer_config.get("groups", 1),
                activation=layer_config["activation"],
                use_bias=layer_config["use_bias"],
                name=layer_config["name"],
            )
        elif isinstance(layer, qdense_cls):
            new_layer = layers.Dense(
                units=layer_config["units"],
                activation=layer_config["activation"],
                use_bias=layer_config["use_bias"],
                name=layer_config["name"],
            )
        elif isinstance(layer, layers.InputLayer):
            continue
        else:
            new_layer = layer.__class__.from_config(layer_config)

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
    """Keep HGQ precision propagation authoritative for concrete layers.

    hls4ml still expects model-level defaults when an hls_config is supplied.
    Per-layer precision entries are removed so they do not compete with the
    precision embedded in the HGQ model.
    """
    for layer_config in config.get("LayerName", {}).values():
        if isinstance(layer_config, dict):
            layer_config.pop("Precision", None)


def assert_safe_replace_path(path: Path) -> None:
    resolved = path.resolve()
    cwd = Path.cwd().resolve()
    if resolved in {Path("/"), cwd, cwd.parent}:
        raise ValueError(f"Refusing to replace unsafe path: {resolved}")


def replace_directory(src: Path, dst: Path) -> None:
    if not src.is_dir():
        raise FileNotFoundError(f"Source directory does not exist: {src}")

    assert_safe_replace_path(dst)
    parent = dst.parent if dst.parent != Path("") else Path(".")
    if not os.access(parent.resolve(), os.W_OK):
        raise PermissionError(f"No write permission for {parent.resolve()}")

    if dst.exists():
        print(f"[INFO] Removing existing directory: {dst}")
        shutil.rmtree(dst)

    print(f"[INFO] Copying {src} -> {dst}")
    shutil.copytree(src, dst)


def prepare_output_dir(path: Path) -> None:
    assert_safe_replace_path(path)
    if not path.exists():
        parent = path.parent if path.parent != Path("") else Path(".")
        if not os.access(parent.resolve(), os.W_OK):
            raise PermissionError(f"No write permission for {parent.resolve()}")
        return

    print(f"[INFO] Removing existing output directory: {path}")
    shutil.rmtree(path)


def initialize_streaming_firmware(output_dir: Path, streaming_firmware_dir: Path) -> None:
    generated_firmware = output_dir / "firmware"
    replace_directory(generated_firmware, streaming_firmware_dir)
    print(f"[INFO] Streaming firmware initialized from {generated_firmware}")


def supported_kwargs(func: Any, kwargs: dict[str, Any]) -> dict[str, Any]:
    """Drop kwargs that an older hls4ml version does not accept."""
    signature = inspect.signature(func)
    if any(param.kind == inspect.Parameter.VAR_KEYWORD for param in signature.parameters.values()):
        return kwargs
    return {key: value for key, value in kwargs.items() if key in signature.parameters}


def convert_model(hls4ml: Any, model: Any, hls_config: dict[str, Any] | None, args: argparse.Namespace) -> Any:
    kwargs: dict[str, Any] = {
        "model": model,
        "hls_config": hls_config,
        "output_dir": args.output_dir,
        "project_name": args.project_name,
        "io_type": args.io_type,
        "backend": args.backend,
        "part": args.part,
        "clock_period": args.clock_period,
    }

    if args.bit_exact != "auto":
        kwargs["bit_exact"] = args.bit_exact == "true"

    convert = hls4ml.converters.convert_from_keras_model
    kwargs = supported_kwargs(convert, kwargs)
    print("[INFO] Converting to HLS with settings:")
    for key in ("output_dir", "project_name", "io_type", "backend", "part", "clock_period"):
        if key in kwargs:
            print(f"   {key}: {kwargs[key]}")
    if "bit_exact" in kwargs:
        print(f"   bit_exact: {kwargs['bit_exact']}")

    return convert(**kwargs)


def is_hgq_stream_heterogeneous_activation_error(exc: BaseException) -> bool:
    message = str(exc)
    return (
        "Heterogenous quantization for activations" in message
        and "IOType=io_parallel" in message
    )


def accuracy_score(reference: Any, predicted: Any) -> float:
    import numpy as np

    reference = np.asarray(reference).flatten()
    predicted = np.asarray(predicted).flatten()
    if reference.shape != predicted.shape:
        raise ValueError(
            f"Accuracy arrays have different shapes: {reference.shape} vs {predicted.shape}"
        )
    return float(np.mean(reference == predicted))


def prepare_test_data(data_dir: Path, model_input_shape: tuple[int, ...]) -> tuple[Any, Any] | None:
    import numpy as np

    x_path = data_dir / "X_test_data.npy"
    y_path = data_dir / "y_test_labels.npy"
    if not x_path.exists() or not y_path.exists():
        print("[WARNING] Test data not found; skipping verification.")
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
        raise ValueError(
            f"Unsupported X_test shape {x_test.shape}; expected "
            f"(N, {model_input_shape[0]}, {model_input_shape[1]}) or its transpose."
        )

    return np.ascontiguousarray(x_prepared), y_test


def verify_model(hls_model: Any, keras_model: Any, data_dir: Path, model_input_shape: tuple[int, ...]) -> None:
    import numpy as np

    prepared = prepare_test_data(data_dir, model_input_shape)
    if prepared is None:
        return

    x_test, y_test = prepared
    print("=" * 40)
    print("[TEST] Verifying direct HGQ conversion")
    print("=" * 40)
    print(f"   Data shape: {x_test.shape}")

    print("   Running HLS prediction...")
    y_hls = hls_model.predict(x_test)

    print("   Running Keras prediction...")
    y_keras = keras_model.predict(x_test)

    y_hls_bin = (y_hls > 0).astype(int).flatten()
    y_keras_bin = (y_keras > 0).astype(int).flatten()
    y_label_bin = y_test.astype(int).flatten()

    acc_hls = accuracy_score(y_label_bin, y_hls_bin)
    fidelity = accuracy_score(y_keras_bin, y_hls_bin)
    max_abs_diff = float(np.max(np.abs(y_hls.flatten() - y_keras.flatten())))

    print("-" * 40)
    print(f"   HLS accuracy:      {acc_hls:.4f}")
    print(f"   HLS/Keras fidelity:{fidelity:.4f}")
    print(f"   Max abs score diff:{max_abs_diff:.6g}")
    print("-" * 40)


def main() -> int:
    args = parse_args()
    hls4ml, keras, custom_objects = import_dependencies()

    model_path = Path(args.model_path)
    output_dir = Path(args.output_dir)
    data_dir = Path(args.data_dir)
    streaming_firmware_dir = Path(args.streaming_firmware_dir)

    print(f"[INFO] Loading HGQ model: {model_path}")
    model = keras.models.load_model(model_path, custom_objects=custom_objects)
    model_input_shape = get_model_input_shape(model)
    print(f"[INFO] Model input shape: {model_input_shape}")
    print_model_summary(model)

    reference_model = model
    active_mode = args.conversion_mode

    if args.conversion_mode in {"auto", "direct"}:
        if args.hls_config_mode == "minimal":
            hls_config = build_direct_hls_config(hls4ml, model, args)
        else:
            print("[INFO] Passing no hls_config; hls4ml will choose the conversion config.")
            hls_config = None

        try:
            prepare_output_dir(output_dir)
            hls_model = convert_model(hls4ml, model, hls_config, args)
        except NotImplementedError as exc:
            if args.conversion_mode != "auto" or not is_hgq_stream_heterogeneous_activation_error(exc):
                raise

            print("[WARNING] Direct HGQ conversion with io_stream is not supported by this hls4ml version:")
            print(f"          {exc}")
            print("[WARNING] Falling back to vanilla-stream conversion without changing IOType.")
            prepare_output_dir(output_dir)
            active_mode = "vanilla-stream"
            layer_precisions = collect_layer_precisions(model)
            reference_model = build_vanilla_model(keras, model, custom_objects)
            hls_config = build_vanilla_hls_config(hls4ml, reference_model, layer_precisions, args)
            hls_model = convert_model(hls4ml, reference_model, hls_config, args)
    else:
        print("[INFO] Using vanilla-stream conversion mode.")
        active_mode = "vanilla-stream"
        layer_precisions = collect_layer_precisions(model)
        reference_model = build_vanilla_model(keras, model, custom_objects)
        hls_config = build_vanilla_hls_config(hls4ml, reference_model, layer_precisions, args)
        prepare_output_dir(output_dir)
        hls_model = convert_model(hls4ml, reference_model, hls_config, args)

    print(f"[INFO] Active conversion mode: {active_mode}")
    hls_model.write()
    print(f"[INFO] Project written to {output_dir}")

    if args.skip_compile:
        print("[INFO] Skipping hls_model.compile().")
    else:
        print("[INFO] Compiling C simulation library...")
        hls_model.compile()
        print("[INFO] Compile success.")

    if args.skip_verify:
        print("[INFO] Skipping verification.")
    else:
        verify_model(hls_model, reference_model, data_dir, model_input_shape)

    if args.init_streaming:
        initialize_streaming_firmware(output_dir, streaming_firmware_dir)
    else:
        print("[INFO] Leaving hls_streaming/firmware unchanged.")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

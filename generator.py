#!/usr/bin/env python3
import json
from pathlib import Path
import hls4ml
import keras
import numpy as np
from hgq.layers import QConv2D, QDense
from ravel_hls import RavelConfig, convert_from_keras_model

# ============================================================
# Configuration
# ============================================================

ROOT = Path(__file__).resolve().parent

MODEL = ROOT / "models" / "hgq_config_beta7_gamma6_p1_cl_lowbop.keras"
OUTPUT = ROOT / "cnn_core"

PROJECT_NAME = "cnn_core_prj"

PART = "xcku5p-ffvb676-2-e"
CLOCK_PERIOD = 5.0

VERIFICATION = "required"
SAMPLES = 32
SEED = 19

# Optional .npy input with shape [samples, 256, 4]
INPUTS = None

FORCE_REPLACE = False


# ============================================================
# Main
# ============================================================

def main() -> int:
    model = keras.models.load_model(
        MODEL,
        custom_objects={
            "QConv2D": QConv2D,
            "QDense": QDense,
        },
    )

    hls_config = hls4ml.utils.config_from_keras_model(
        model,
        granularity="name",
        backend="Vitis",
    )

    hls_config["Model"].update({
        "Strategy": "Latency",
        "ReuseFactor": 1,
    })

    verification_inputs = np.load(INPUTS) if INPUTS is not None else None

    project = convert_from_keras_model(
        model,
        output_dir=OUTPUT,
        project_name=PROJECT_NAME,
        hls_config=hls_config,
        ravel_config=RavelConfig({
            "Profile": "aria",
            "Verification": {
                "Mode": VERIFICATION,
                "Samples": SAMPLES,
                "Seed": SEED,
            },
        }),
        part=PART,
        clock_period=CLOCK_PERIOD,
        force_replace=FORCE_REPLACE,
        verification_inputs=verification_inputs,
    )

    print(
        json.dumps(
            {
                "output": str(project.path),
                "generation_fingerprint": project.manifest[
                    "generation_fingerprint"
                ],
                "status": project.status,
            },
            indent=2,
        )
    )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
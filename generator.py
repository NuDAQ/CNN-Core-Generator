#!/usr/bin/env python3

import json
from pathlib import Path

import keras
import numpy as np
from hgq.layers import QConv2D, QDense
from ravel_hls import convert


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "cnn_core"
MODEL_DIR = ROOT / "models/amphp_oct_12"
TRIGGER_THRESHOLD = 4.953  # Preliminary noise-rate threshold, for reporting only.

model = keras.models.load_model(
    MODEL_DIR / "run_v6_2cv_k5s3_f12_amphp.keras",
    custom_objects={"QConv2D": QConv2D, "QDense": QDense},
)

with np.load(
    MODEL_DIR / "verification_data_v6_2cv_k5s3_f12_amphp.npz", allow_pickle=False
) as verification:
    x = np.ascontiguousarray(verification["X"], dtype=np.float32)
    labels = verification["y"].astype(bool)
    reference_scores = verification["scores"].ravel()

if x.ndim != 4 or x.shape[-1] != 1:
    raise ValueError(
        "verification inputs must have shape [samples, height, width, 1]"
    )
ravel_x = np.ascontiguousarray(x[..., 0])

# The supplied inputs are already normalized; do not apply ADC gain here.
keras_scores = model.predict(x, verbose=0).ravel()
np.testing.assert_array_equal(
    keras_scores,
    reference_scores,
    err_msg="Reloaded Keras model does not match supplied reference scores",
)

project = convert(
    model,
    OUTPUT,
    {
        "Project": {"ForceReplace": True},
        "HLS": {
            "Backend": "Vitis",
            "IOType": "io_stream",
            "Part": "xcku5p-ffvb676-2-e",
            "ClockPeriod": 5.0,
        },
        "Optimization": {
            "TemporalPacking": 8,
            "DenseParallelism": 4,
            "TargetII": 85,
        },
        "Verification": {"Mode": "required"},
        "Vitis": {"Run": False},
    },
    verification_inputs=x,
)

# Accuracy against labels
ravel = project.link_hls4ml()
ravel.compile()

ravel_scores = ravel.predict(ravel_x).ravel()

keras_classes = keras_scores > TRIGGER_THRESHOLD
ravel_classes = ravel_scores > TRIGGER_THRESHOLD

print(
    json.dumps(
        {
            "model": model.name,
            "output": str(project.path),
            "trigger_threshold": TRIGGER_THRESHOLD,
            "max_abs_reference_score_diff": float(
                np.max(np.abs(keras_scores - reference_scores))
            ),
            "fingerprint": project.manifest["generation_fingerprint"],
            "status": project.status,
            "verification": {
                name: {
                    "sample_count": corpus["sample_count"],
                    "equivalence": corpus["transformation_equivalence"],
                }
                for name, corpus in project.manifest["verification"]["corpora"].items()
            },
            "accuracy": {
                "keras": float(np.mean(keras_classes == labels)),
                "ravel": float(np.mean(ravel_classes == labels)),
                "class_fidelity": float(
                    np.mean(keras_classes == ravel_classes)
                ),
                "max_abs_score_diff": float(
                    np.max(np.abs(keras_scores - ravel_scores))
                ),
            },
        },
        indent=2,
    )
)

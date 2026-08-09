#!/usr/bin/env python3

import json
from pathlib import Path

import hls4ml
import keras
import numpy as np
from hgq.layers import QConv2D, QDense
from ravel_hls import RavelConfig, convert_from_keras_model


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "cnn_core"

model = keras.models.load_model(
    ROOT / "models/hgq_config_beta7_gamma6_p1_cl_lowbop.keras",
    custom_objects={"QConv2D": QConv2D, "QDense": QDense},
)

# [N, 4, 256, 1] -> [N, 256, 4]
x = np.ascontiguousarray(
    np.load(ROOT / "data/X_test_data.npy")[..., 0].transpose(0, 2, 1),
    dtype=np.float32,
)
labels = np.load(ROOT / "data/y_test_labels.npy").astype(bool)

hls_config = hls4ml.utils.config_from_keras_model(
    model,
    granularity="name",
    backend="Vitis",
)
hls_config["Model"] |= {
    "Strategy": "Latency",
    "ReuseFactor": 1,
}

project = convert_from_keras_model(
    model,
    output_dir=OUTPUT,
    project_name="cnn_core",
    hls_config=hls_config,
    ravel_config=RavelConfig(
        {
            "Profile": "aria",
            "Verification": {"Mode": "required"},
        }
    ),
    part="xcku5p-ffvb676-2-e",
    clock_period=5.0,
    verification_inputs=x,
)

# Accuracy against labels
ravel = project.link_hls4ml()
ravel.compile()

keras_scores = model.predict(x, verbose=0).ravel()
ravel_scores = ravel.predict(x).ravel()

keras_classes = keras_scores > 0
ravel_classes = ravel_scores > 0

cosim_x = x[:32]
np.savetxt(
    OUTPUT / "tb_data" / "tb_input_features.dat",
    cosim_x.reshape(len(cosim_x), -1),
    fmt="%.9g",
)

print(
    json.dumps(
        {
            "output": str(project.path),
            "fingerprint": project.manifest["generation_fingerprint"],
            "status": project.status,
            "verification": project.manifest["verification"],
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
            "vitis_cosim_samples": len(cosim_x),
        },
        indent=2,
    )
)

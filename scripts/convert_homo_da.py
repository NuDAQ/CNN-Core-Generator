import hls4ml
import keras
from hgq.layers import QConv2D, QDense 

model = keras.models.load_model(
    "models/hgq_config_beta7_gamma6_p1_cl_best_v2.keras",
    custom_objects={"QConv2D": QConv2D, "QDense": QDense}
)

config = hls4ml.utils.config_from_keras_model(model, granularity='model')

config['Model']['Strategy'] = 'distributed_arithmetic'

config['Model']['ReuseFactor'] = 1 

hls_model = hls4ml.converters.convert_from_keras_model(
    model,
    hls_config=config,
    output_dir='cnn_core_project_da',
    backend='Vitis'
)

hls_model.write()

print("HLS project generated successfully in ./cnn_core_project_da")
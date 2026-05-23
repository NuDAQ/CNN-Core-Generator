import hls4ml

import tensorflow as tf

from tensorflow import keras

from tensorflow.keras.layers import Conv2D, Dense, Flatten, Reshape, MaxPooling2D, InputLayer

import numpy as np

import sys

import os

from sklearn.metrics import accuracy_score



# ==============================================================================

# 1. SETTINGS

# ==============================================================================

MODEL_PATH = 'models/hgq_config_beta7_gamma6_p1_cl_best_v3.keras'

OUTPUT_DIR = 'cnn_core_project/' # `chmod +w cnn_core_project` to ensure write permissions

DATA_DIR = 'data/'

BACKEND = 'Vitis'

PART = 'xcku5p-ffvb676-2-e'

INPUT_PRECISION = 'ap_fixed<12,6>' 
DENSE_RESULT_PRECISION = 'ap_fixed<16,6>'



# ==============================================================================

# 2. LOAD HGQ MODEL

# ==============================================================================

try:

    import hgq

    from hgq.layers import QConv2D, QDense

    print("[INFO] HGQ library detected.")

except ImportError:

    print("[ERROR] 'hgq' library not found.")

    sys.exit(1)



parent_dir = os.path.dirname(os.path.abspath(OUTPUT_DIR))
if not os.access(parent_dir, os.W_OK):

    print(f"[ERROR] No write permissions for {parent_dir}")

    sys.exit(1)



print(f"[INFO] Loading HGQ model from {MODEL_PATH}...")

custom_objects = {'QConv2D': QConv2D, 'QDense': QDense}

hgq_model = keras.models.load_model(MODEL_PATH, custom_objects=custom_objects)


def get_model_input_shape(model):

    """Return the non-batch input shape for the loaded Keras model."""

    input_shape = model.input_shape

    if isinstance(input_shape, list):

        input_shape = input_shape[0]

    if input_shape is None:

        raise ValueError("Unable to determine HGQ model input shape")

    return tuple(input_shape[1:])


MODEL_INPUT_SHAPE = get_model_input_shape(hgq_model)

print(f"[INFO] Model input shape: {MODEL_INPUT_SHAPE}")



# ==============================================================================

# 3. PER-LAYER PRECISION SCANNER

# ==============================================================================

print("-" * 40)

print("[INFO] Scanning HGQ layers for individual precision...")



layer_precisions = {}



def get_bits(q_conf):

    """Extracts (Total, Int) bits from HGQ config (including sign bit k0)"""

    if q_conf and 'config' in q_conf:

        c = q_conf['config']

        if 'i0' in c and 'f0' in c:

            k = int(c.get('k0', 0))

            i = int(c['i0'])

            f = int(c['f0'])

            return k + i + f, k + i

    return 0, 0



for layer in hgq_model.layers:
    conf = layer.get_config()
    
    # Check Kernel, Bias, Activation
    t_k, i_k = get_bits(conf.get('kq_conf'))
    t_b, i_b = get_bits(conf.get('bq_conf'))
    t_i, i_i = get_bits(conf.get('iq_conf'))
    
    # Find max requirements for THIS specific layer
    local_total = max(t_k, t_b, t_i)
    local_int = max(i_k, i_b, i_i)
    
    if local_total > 0:
        
        # NOW apply the Safety Floor
        if local_total < 4: local_total = 4
        if local_int < 2: local_int = 2
        
        prec_str = f'ap_fixed<{local_total},{local_int}>'
        layer_precisions[layer.name] = prec_str
        print(f"   Layer {layer.name:<15} -> {prec_str}")
        
    else:
        # Log that we are skipping this layer to keep the signal path clean
        print(f"   Layer {layer.name:<15} -> [Skipping] (Will inherit precision)")



print("-" * 40)



# ==============================================================================

# 4. BUILD OPTIMIZED VANILLA MODEL

# ==============================================================================

print("[INFO] Building Vanilla model...")



vanilla_model = keras.Sequential()

vanilla_model.add(InputLayer(shape=MODEL_INPUT_SHAPE, name='input_layer'))



current_shape = (None,) + MODEL_INPUT_SHAPE



for layer in hgq_model.layers:

    conf = layer.get_config()

    weights = layer.get_weights()

    new_layer = None

    

    if isinstance(layer, QConv2D):

        new_layer = Conv2D(

            filters=conf['filters'],

            kernel_size=conf['kernel_size'],

            strides=conf['strides'],

            padding=conf['padding'],

            data_format=conf['data_format'],

            dilation_rate=conf.get('dilation_rate', (1, 1)),

            groups=conf.get('groups', 1),

            activation=conf['activation'],

            use_bias=conf['use_bias'],

            name=conf['name']

        )

    elif isinstance(layer, QDense):

        new_layer = Dense(

            units=conf['units'],

            activation=conf['activation'],

            use_bias=conf['use_bias'],

            name=conf['name']

        )

    elif isinstance(layer, (Reshape, MaxPooling2D, Flatten)):

        new_layer = layer.__class__.from_config(conf)

    elif isinstance(layer, InputLayer):

        continue

    else:

        new_layer = layer.__class__.from_config(conf)



    if new_layer:

        new_layer.build(current_shape)

        if weights:

            new_layer.set_weights(weights[:len(new_layer.weights)])

        vanilla_model.add(new_layer)

        current_shape = new_layer.compute_output_shape(current_shape)



print("[INFO] Vanilla model built successfully.")



# ==============================================================================

# 5. CONFIGURE HLS4ML

# ==============================================================================

print("[INFO] Generating HLS configuration...")



config = hls4ml.utils.config_from_keras_model(

    vanilla_model, 

    granularity='name',

    default_precision='ap_fixed<16,6>' # Fallback only

)



config['Model']['Strategy'] = 'Latency'

config['Model']['ReuseFactor'] = 1 



# ---------------------------------------------------------

# APPLY PER-LAYER PRECISION

# ---------------------------------------------------------

for layer_name, precision in layer_precisions.items():

    if layer_name in config['LayerName']:

        print(f"[CONFIG] Applying {precision} to '{layer_name}'")

        result_precision = DENSE_RESULT_PRECISION if layer_name == 'q_dense' else precision

        config['LayerName'][layer_name]['Precision'] = {

            'weight': precision,

            'bias': precision,

            'result': result_precision

        }

    else:

        print(f"[WARNING] Layer '{layer_name}' not found in hls4ml config, precision not applied")



# ---------------------------------------------------------

# APPLY INPUT PRECISION

# ---------------------------------------------------------

in_layer_name = 'input_layer'
for name in config['LayerName']:
    if 'input' in name.lower():
        in_layer_name = name
        break

if in_layer_name in config['LayerName']:

    print(f"[CONFIG] Force Input '{in_layer_name}' -> {INPUT_PRECISION}")

    config['LayerName'][in_layer_name]['Precision'] = {'result': INPUT_PRECISION}

    config['LayerName'][in_layer_name]['StreamDepth'] = 16

else:

    print(f"[WARNING] Input layer '{in_layer_name}' not found in config")



# ==============================================================================

# 6. CONVERT & COMPILE

# ==============================================================================

print(f"[INFO] Converting to HLS (io_stream)...")



hls_model = hls4ml.converters.convert_from_keras_model(

    vanilla_model,

    hls_config=config,

    output_dir=OUTPUT_DIR,

    project_name='cnn_core',

    io_type='io_stream',    

    backend=BACKEND,       

    part=PART              

)



hls_model.write()

print(f"Project written to {OUTPUT_DIR}")



print("[INFO] Compiling C-Simulation...")

hls_model.compile()

print("Compile Success!")



# ==============================================================================

# 7. VERIFICATION

# ==============================================================================

print("\n" + "="*40)

print("[TEST] Verifying Conversion Loss...")

print("="*40)



X_path = os.path.join(DATA_DIR, 'X_test_data.npy')

y_path = os.path.join(DATA_DIR, 'y_test_labels.npy')



if os.path.exists(X_path) and os.path.exists(y_path):

    X_test = np.load(X_path)

    y_test = np.load(y_path)

    

    # 1. Squeeze extra dim, e.g. (1000, 4, 256, 1) -> (1000, 4, 256)

    if X_test.ndim == 4:

        X_test = X_test.squeeze(axis=-1)

        

    # 2. Match the v3 model input. Training data is commonly saved as
    #    (N, 4, 256), while the model now expects (N, 256, 4).

    if tuple(X_test.shape[1:]) == MODEL_INPUT_SHAPE:

        X_test_prepared = X_test

    elif X_test.ndim == 3 and tuple(X_test.shape[1:][::-1]) == MODEL_INPUT_SHAPE:

        X_test_prepared = np.transpose(X_test, (0, 2, 1))

    else:

        raise ValueError(

            f"Unsupported X_test shape {X_test.shape}; expected (N, {MODEL_INPUT_SHAPE[0]}, {MODEL_INPUT_SHAPE[1]}) or its transpose."

        )

    X_test_prepared = np.ascontiguousarray(X_test_prepared)

    

    print(f"   Data Shape: {X_test_prepared.shape}")

    

    print("   Running HLS Prediction...")

    y_hls = hls_model.predict(X_test_prepared)

    

    print("   Running Keras Prediction...")

    y_keras = vanilla_model.predict(X_test_prepared)

    

    y_hls_bin = (y_hls > 0).astype(int).flatten()

    y_keras_bin = (y_keras > 0).astype(int).flatten()

    y_label_bin = y_test.astype(int).flatten()



    acc_hls = accuracy_score(y_label_bin, y_hls_bin)

    fidelity = accuracy_score(y_keras_bin, y_hls_bin)



    print("-" * 40)

    print(f"   HLS Accuracy:     {acc_hls:.4f}")

    print(f"   Fidelity:         {fidelity:.4f}")

    print("-" * 40)

else:

    print("[WARNING] Test data not found.")

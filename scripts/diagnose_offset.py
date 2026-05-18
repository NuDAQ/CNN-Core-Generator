"""
Diagnose the ~-6 systematic offset between original HGQ Keras and hls4ml/RTL.

Compares three chains:
  A) Original HGQ model (QConv2D / QDense) -- the ground truth reference
  B) Vanilla model      (Conv2D / Dense, weights copied from A) -- what hls4ml actually sees
  C) hls4ml C-sim       (if compiled .so exists) -- what the hardware computes

Also inspects intermediate conv activation ranges to locate where truncation occurs.
"""

import sys, os
import numpy as np

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
BASE   = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HGQ_MODEL_PATH     = os.path.join(BASE, 'models', 'hgq_config_beta7_gamma6_p1_cl_best_v3.keras')
VANILLA_MODEL_PATH = os.path.join(BASE, 'cnn_core_project', 'keras_model.keras')
X_PATH             = os.path.join(BASE, 'data', 'X_test_data.npy')
Y_PATH             = os.path.join(BASE, 'data', 'y_test_labels.npy')
HLS_SO_PATH        = os.path.join(BASE, 'cnn_core_project', 'firmware', 'cnn_core-e9386e39.so')

# Wrapper RTL CSV (if available)
WRAPPER_CSV = os.path.join(
    os.path.dirname(BASE),
    'CNN-Core-Wrapper', 'out', 'behavioral_sim', 'inference_results_stream.csv'
)

# ---------------------------------------------------------------------------
# Load test data
# ---------------------------------------------------------------------------
X_raw = np.load(X_PATH)   # (1000, 4, 256, 1)
y     = np.load(Y_PATH).flatten().astype(int)

# Squeeze last dim → (1000, 4, 256)
if X_raw.ndim == 4:
    X_raw = X_raw[..., 0]

# Transpose to model input shape (N, 256, 4)
X = np.transpose(X_raw, (0, 2, 1))
print(f"[DATA] X shape for model: {X.shape}")

# Also keep original shape for HGQ if needed
X_4_256 = X_raw   # (1000, 4, 256)

# ---------------------------------------------------------------------------
# A) Original HGQ model
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("[A] Loading original HGQ model ...")
try:
    import hgq
    from hgq.layers import QConv2D, QDense
    custom_objects = {'QConv2D': QConv2D, 'QDense': QDense}
    # Also try importing QuantizerConfig / other custom objects if needed
    try:
        from hgq import MonoL1, MinMax, QuantizerConfig
        custom_objects.update({'MonoL1': MonoL1, 'MinMax': MinMax, 'QuantizerConfig': QuantizerConfig})
    except Exception:
        pass

    import tensorflow as tf
    hgq_model = tf.keras.models.load_model(
        HGQ_MODEL_PATH,
        custom_objects=custom_objects,
        safe_mode=False
    )
    hgq_model.summary(line_length=80)

    # Check which input shape this model expects
    hgq_input_shape = tuple(hgq_model.input_shape[1:])
    print(f"[A] HGQ model input shape: {hgq_input_shape}")

    if hgq_input_shape == (256, 4):
        X_hgq = X          # already (N, 256, 4)
    elif hgq_input_shape == (4, 256):
        X_hgq = X_4_256    # (N, 4, 256)
    else:
        print(f"[WARN] Unexpected HGQ input shape {hgq_input_shape}, trying (N,256,4)")
        X_hgq = X

    print("[A] Running HGQ inference ...")
    y_hgq_raw = hgq_model.predict(X_hgq, batch_size=128, verbose=0)
    y_hgq = y_hgq_raw.flatten()
    print(f"[A] HGQ scores: min={y_hgq.min():.4f} max={y_hgq.max():.4f} "
          f"mean={y_hgq.mean():.4f}")

    HGQ_OK = True
except Exception as e:
    print(f"[A] FAILED to load/run HGQ model: {e}")
    y_hgq = None
    HGQ_OK = False

# ---------------------------------------------------------------------------
# B) Vanilla model (Conv2D/Dense, as seen by hls4ml)
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("[B] Loading vanilla model ...")
try:
    import tensorflow as tf
    vanilla_model = tf.keras.models.load_model(VANILLA_MODEL_PATH)
    vanilla_model.summary(line_length=80)

    vanilla_input_shape = tuple(vanilla_model.input_shape[1:])
    print(f"[B] Vanilla model input shape: {vanilla_input_shape}")

    if vanilla_input_shape == (256, 4):
        X_van = X
    elif vanilla_input_shape == (4, 256):
        X_van = X_4_256
    else:
        X_van = X

    print("[B] Running vanilla inference ...")
    y_van_raw = vanilla_model.predict(X_van, batch_size=128, verbose=0)
    y_van = y_van_raw.flatten()
    print(f"[B] Vanilla scores: min={y_van.min():.4f} max={y_van.max():.4f} "
          f"mean={y_van.mean():.4f}")

    VAN_OK = True
except Exception as e:
    print(f"[B] FAILED to load/run vanilla model: {e}")
    y_van = None
    VAN_OK = False

# ---------------------------------------------------------------------------
# B2) Vanilla model intermediate activations – conv layer output range
# ---------------------------------------------------------------------------
if VAN_OK:
    print("\n" + "="*60)
    print("[B2] Checking vanilla conv layer output range ...")
    try:
        import tensorflow as tf
        # Find conv and pooling layers
        for layer in vanilla_model.layers:
            lname = layer.name
            if any(k in lname for k in ('conv', 'pool', 'dense', 'flatten')):
                sub = tf.keras.Model(inputs=vanilla_model.input, outputs=layer.output)
                out = sub.predict(X_van[:200], batch_size=64, verbose=0)
                print(f"   Layer '{lname}' output: shape={out.shape} "
                      f"min={out.min():.4f} max={out.max():.4f} mean={out.mean():.4f}")
    except Exception as e:
        print(f"[B2] Failed: {e}")

# ---------------------------------------------------------------------------
# C) hls4ml C-sim
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("[C] Trying hls4ml C-sim ...")
HLS_OK = False
y_hls = None
if os.path.exists(HLS_SO_PATH):
    try:
        import ctypes
        import hls4ml
        hls_model = hls4ml.backends.get_backend('Vitis').load_model(
            os.path.join(BASE, 'cnn_core_project')
        )
        print("[C] Running hls4ml C-sim ...")
        y_hls_raw = hls_model.predict(X_van if VAN_OK else X, batch_size=128)
        y_hls = y_hls_raw.flatten()
        print(f"[C] HLS scores: min={y_hls.min():.4f} max={y_hls.max():.4f} "
              f"mean={y_hls.mean():.4f}")
        HLS_OK = True
    except Exception as e:
        print(f"[C] hls4ml C-sim unavailable: {e}")
else:
    print(f"[C] .so not found at {HLS_SO_PATH}, skipping C-sim")

# ---------------------------------------------------------------------------
# D) Wrapper RTL CSV
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("[D] Loading wrapper RTL CSV ...")
RTL_OK = False
y_rtl = None
if os.path.exists(WRAPPER_CSV):
    try:
        import csv
        scores, idxs = [], []
        with open(WRAPPER_CSV) as f:
            reader = csv.DictReader(f)
            for row in reader:
                idxs.append(int(row['sample_id']))
                scores.append(float(row['float_out']))
        # Sort by sample_id
        order = np.argsort(idxs)
        y_rtl = np.array(scores)[order]
        print(f"[D] RTL scores: min={y_rtl.min():.4f} max={y_rtl.max():.4f} "
              f"mean={y_rtl.mean():.4f}")
        RTL_OK = True
    except Exception as e:
        print(f"[D] CSV load failed: {e}")
else:
    print(f"[D] Wrapper CSV not found at {WRAPPER_CSV}")

# ---------------------------------------------------------------------------
# Summary comparison
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("COMPARISON SUMMARY")
print("="*60)

def stats(name, diff):
    print(f"  {name}: mean={diff.mean():+.4f}  median={np.median(diff):+.4f}  "
          f"MAE={np.abs(diff).mean():.4f}  RMSE={np.sqrt((diff**2).mean()):.4f}  "
          f"corr={np.corrcoef(diff + 0, np.zeros(len(diff)))[0,0]:.4f}")

if HGQ_OK and VAN_OK:
    d = y_van - y_hgq
    print(f"\n[B - A] Vanilla minus HGQ (weight copy error?):")
    print(f"        mean={d.mean():+.4f}  median={np.median(d):+.4f}  "
          f"MAE={np.abs(d).mean():.4f}  corr={np.corrcoef(y_van, y_hgq)[0,1]:.4f}")
    print(f"        max abs diff: {np.abs(d).max():.4f}")

if VAN_OK and HLS_OK:
    d = y_hls - y_van
    print(f"\n[C - B] HLS C-sim minus Vanilla (hls4ml quantization error?):")
    print(f"        mean={d.mean():+.4f}  median={np.median(d):+.4f}  "
          f"MAE={np.abs(d).mean():.4f}  corr={np.corrcoef(y_hls, y_van)[0,1]:.4f}")

if HGQ_OK and RTL_OK:
    # Only compare first N samples
    N = min(len(y_hgq), len(y_rtl))
    d = y_rtl[:N] - y_hgq[:N]
    print(f"\n[D - A] RTL minus HGQ (total end-to-end error):")
    print(f"        mean={d.mean():+.4f}  median={np.median(d):+.4f}  "
          f"MAE={np.abs(d).mean():.4f}  corr={np.corrcoef(y_rtl[:N], y_hgq[:N])[0,1]:.4f}")

if VAN_OK and RTL_OK:
    N = min(len(y_van), len(y_rtl))
    d = y_rtl[:N] - y_van[:N]
    print(f"\n[D - B] RTL minus Vanilla (hls4ml impl error?):")
    print(f"        mean={d.mean():+.4f}  median={np.median(d):+.4f}  "
          f"MAE={np.abs(d).mean():.4f}  corr={np.corrcoef(y_rtl[:N], y_van[:N])[0,1]:.4f}")

# ---------------------------------------------------------------------------
# Per-layer weight statistics for the dense layer
# ---------------------------------------------------------------------------
print("\n" + "="*60)
print("WEIGHT STATS")
print("="*60)

if HGQ_OK:
    for layer in hgq_model.layers:
        ws = layer.get_weights()
        if ws:
            print(f"\n  HGQ layer '{layer.name}':")
            for i, w in enumerate(ws):
                print(f"    weight[{i}] shape={w.shape}  "
                      f"min={w.min():.6f}  max={w.max():.6f}  mean={w.mean():.6f}")

if VAN_OK:
    print()
    for layer in vanilla_model.layers:
        ws = layer.get_weights()
        if ws:
            print(f"\n  Vanilla layer '{layer.name}':")
            for i, w in enumerate(ws):
                print(f"    weight[{i}] shape={w.shape}  "
                      f"min={w.min():.6f}  max={w.max():.6f}  mean={w.mean():.6f}")

# ---------------------------------------------------------------------------
# ap_fixed<9,5> clipping simulation on vanilla conv output
# ---------------------------------------------------------------------------
if VAN_OK:
    print("\n" + "="*60)
    print("CLIPPING SIMULATION: ap_fixed<9,5> on conv output")
    print("="*60)
    try:
        import tensorflow as tf
        conv_layer = None
        for layer in vanilla_model.layers:
            if 'conv' in layer.name:
                conv_layer = layer
                break
        if conv_layer:
            sub = tf.keras.Model(inputs=vanilla_model.input, outputs=conv_layer.output)
            conv_out = sub.predict(X_van, batch_size=128, verbose=0)   # float32
            print(f"Conv output float32: min={conv_out.min():.4f} max={conv_out.max():.4f}")

            # Simulate ap_fixed<9,5>: 4 frac bits, range [-16, 15.9375], step=1/16=0.0625
            STEP   = 2**(-4)   # 4 fractional bits (9-5=4)
            MAXVAL = 16.0 - STEP
            MINVAL = -16.0
            conv_clipped = np.clip(
                np.round(conv_out / STEP) * STEP, MINVAL, MAXVAL
            )
            clip_frac = np.mean(np.abs(conv_clipped - conv_out) > STEP / 2)
            print(f"After ap_fixed<9,5> clip: min={conv_clipped.min():.4f} "
                  f"max={conv_clipped.max():.4f}")
            print(f"Fraction of values that hit clip boundary: {clip_frac:.4f} ({clip_frac*100:.1f}%)")
            print(f"Mean shift from clipping: {(conv_clipped - conv_out).mean():.6f}")

            # Now simulate the full pipeline with clipped conv output to estimate dense offset
            # Build a temporary model that applies clipping at conv output
            relu_layer = None
            for layer in vanilla_model.layers:
                if 'relu' in layer.name.lower() or 'activation' in layer.name.lower():
                    relu_layer = layer
                    break

            # Manual pipeline: clipped → relu → pool → flatten → dense
            try:
                pool_layer  = [l for l in vanilla_model.layers if 'pool' in l.name][0]
                flat_layer  = [l for l in vanilla_model.layers if 'flatten' in l.name or 'reshape' in l.name][0]
                dense_layer = [l for l in vanilla_model.layers if 'dense' in l.name][0]

                act_out  = np.maximum(conv_clipped, 0)   # ReLU (no extra clipping needed for ap_fixed<16,6> after ReLU)
                pool_in  = tf.constant(act_out.reshape(-1, *conv_out.shape[1:]))
                pool_out = pool_layer(pool_in).numpy()
                flat_out = flat_layer(tf.constant(pool_out)).numpy()
                dense_out_clipped = dense_layer(tf.constant(flat_out, dtype=tf.float32)).numpy().flatten()

                d_clip = dense_out_clipped - y_van
                print(f"\nDense output with ap_fixed<9,5> conv clipping vs float vanilla:")
                print(f"  mean shift: {d_clip.mean():+.4f}  median: {np.median(d_clip):+.4f}")
                print(f"  → This is how much of the -6 offset is explained by conv result clipping")

                if HGQ_OK:
                    d_total = dense_out_clipped[:len(y_hgq)] - y_hgq
                    print(f"\nDense output with clip vs HGQ ground truth:")
                    print(f"  mean shift: {d_total.mean():+.4f}  corr: {np.corrcoef(dense_out_clipped[:len(y_hgq)], y_hgq)[0,1]:.4f}")
            except Exception as e:
                print(f"  Manual pipeline failed: {e}")
    except Exception as e:
        print(f"Clipping simulation failed: {e}")

print("\n[DONE]")

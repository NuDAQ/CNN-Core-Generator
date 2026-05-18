"""
Extract HGQ-quantized weights and write them into hls_streaming/firmware/weights/.

HGQ uses heterogeneous per-weight quantization:
  - weight[0]: proxy kernel (unquantized float, what hls4ml currently uses)
  - weight[8]: per-weight fractional bits (HGQ actual quantization)

hls4ml currently rounds all dense weights to ap_fixed<9,5> step=0.0625 (4 frac bits).
HGQ uses per-weight steps (mean ~2.9 frac bits), zeroing out small weights.
This causes ~-5.47 systematic offset in dense output.

This script writes the HGQ-quantized weights so hls4ml loads them directly
as floating-point values that already match HGQ's inference.
After running this, rebuild HLS with: make hls (from hls_streaming/)
"""

import sys, os
import numpy as np

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
HGQ_MODEL_PATH     = os.path.join(BASE, 'models', 'hgq_config_beta7_gamma6_p1_cl_best_v3.keras')
FW_DIR_STREAMING   = os.path.join(BASE, 'hls_streaming', 'firmware', 'weights')
FW_DIR_BASELINE    = os.path.join(BASE, 'cnn_core_project', 'firmware', 'weights')

# HLS target precision for writing (used only for range clamping)
# Dense result is now ap_fixed<16,6>, weights remain ap_fixed<9,5>
WEIGHT_INT_BITS = 5   # ap_fixed<9,5>
WEIGHT_FRAC_BITS = 4
WEIGHT_MIN = -(2 ** (WEIGHT_INT_BITS - 1))
WEIGHT_MAX =  (2 ** (WEIGHT_INT_BITS - 1)) - 2**(-WEIGHT_FRAC_BITS)


def hgq_quantize(w_proxy: np.ndarray, frac_bits: np.ndarray) -> np.ndarray:
    """Apply HGQ per-weight heterogeneous quantization.
    q_w = round(w / 2^-n) * 2^-n  where n = frac_bits (per weight).
    frac_bits may be non-integer (lerp or learned); we use round().
    """
    n = np.round(frac_bits).astype(int)      # integer fractional bits per weight
    n = np.clip(n, 0, 15)                    # safety
    step = np.where(n > 0, 2.0 ** (-n.astype(float)), 1.0)   # step per weight
    q = np.round(w_proxy / step) * step
    return q.astype(np.float32)


def write_weight_file(path_base: str, name: str, array: np.ndarray,
                      ctype: str, hls_suffix: str) -> None:
    """Write both .txt and .h firmware weight files."""
    flat = array.flatten()

    # .txt file
    txt_path = path_base + '.txt'
    with open(txt_path, 'w') as f:
        f.write(', '.join(f'{v:.4f}' for v in flat))
        f.write('\n')
    print(f"  Written: {txt_path}  ({len(flat)} values)")

    # .h file
    h_path = path_base + '.h'
    guard = os.path.basename(h_path).upper().replace('.', '_')
    shape_str = str(list(array.shape)).replace('[', '').replace(']', '')
    vals_str = ', '.join(f'{v:.4f}' for v in flat)

    with open(h_path, 'w') as f:
        f.write(f'//Numpy array shape [{shape_str}]\n')
        f.write(f'//Min {flat.min():.12f}\n')
        f.write(f'//Max {flat.max():.12f}\n')
        f.write(f'//Number of zeros {int(np.sum(flat == 0))}\n\n')
        f.write(f'#ifndef {guard}_\n')
        f.write(f'#define {guard}_\n\n')
        f.write(f'#ifndef __SYNTHESIS__\n')
        f.write(f'{ctype} {name}[{len(flat)}];\n')
        f.write(f'#else\n')
        f.write(f'{ctype} {name}[{len(flat)}] = {{{vals_str}}};\n\n')
        f.write(f'#endif\n\n')
        f.write(f'#endif\n')
    print(f"  Written: {h_path}")


def load_hgq_model():
    import tensorflow as tf
    import hgq
    from hgq.layers import QConv2D, QDense
    custom_objects = {'QConv2D': QConv2D, 'QDense': QDense}
    try:
        from hgq.constraints import MinMax
        from hgq.regularizers import MonoL1
        from hgq.quantizer.config import QuantizerConfig
        custom_objects.update({'MinMax': MinMax, 'MonoL1': MonoL1,
                                'QuantizerConfig': QuantizerConfig,
                                'hgq>MinMax': MinMax, 'hgq>MonoL1': MonoL1,
                                'hgq>QuantizerConfig': QuantizerConfig})
    except Exception:
        pass
    custom_objects.update({f'hgq>{k}': v for k, v in list(custom_objects.items())})
    return tf.keras.models.load_model(HGQ_MODEL_PATH,
                                      custom_objects=custom_objects,
                                      safe_mode=False, compile=False)


def main():
    print("Loading HGQ model ...")
    model = load_hgq_model()

    for layer in model.layers:
        ws = layer.get_weights()
        lname = layer.name

        if 'dense' in lname and len(ws) >= 9:
            print(f"\n--- Processing QDense layer: {lname} ---")
            w_proxy  = ws[0]   # (1176, 1) proxy kernel
            b_proxy  = ws[1]   # (1,)      proxy bias
            w_fbits  = ws[8]   # (1176, 1) per-weight fractional bits
            b_fbits  = ws[11]  # (1,)      bias fractional bits (scalar or shape-1)

            print(f"  Proxy kernel:  shape={w_proxy.shape}  min={w_proxy.min():.4f}  max={w_proxy.max():.4f}")
            print(f"  Weight fbits:  shape={w_fbits.shape}  min={w_fbits.min():.4f}  max={w_fbits.max():.4f}  mean={w_fbits.mean():.4f}")
            print(f"  Bias fbits:    {b_fbits}")

            # Quantize kernel
            w_q = hgq_quantize(w_proxy, w_fbits)
            # Also clamp to ap_fixed<9,5> hardware range
            w_q = np.clip(w_q, WEIGHT_MIN, WEIGHT_MAX)

            # Quantize bias using its fractional bits
            b_fbits_scalar = float(np.round(np.mean(b_fbits)))
            b_step = 2.0 ** (-b_fbits_scalar)
            b_q = np.round(b_proxy / b_step) * b_step
            b_q = np.clip(b_q, WEIGHT_MIN, WEIGHT_MAX)

            # Compare: how many weights changed from hls4ml rounding?
            # hls4ml rounding: round to nearest 0.0625
            hls4ml_step = 2.0 ** (-4)
            w_hls = np.round(w_proxy / hls4ml_step) * hls4ml_step
            n_changed = int(np.sum(np.abs(w_q - w_hls) > hls4ml_step * 0.5))
            mean_diff  = float((w_q - w_hls).mean())
            print(f"  Weights changed vs hls4ml rounding: {n_changed}/{len(w_q.flat)}")
            print(f"  Mean (HGQ_q - hls4ml_q): {mean_diff:.6f}")

            # How many zeros per method?
            n_zero_hgq  = int(np.sum(w_q  == 0))
            n_zero_hls  = int(np.sum(w_hls == 0))
            print(f"  Zero weights: HGQ_q={n_zero_hgq}, hls4ml={n_zero_hls}")

            print(f"\n  Writing to {FW_DIR_STREAMING} ...")
            for fw_dir, label in [(FW_DIR_STREAMING, 'hls_streaming'),
                                   (FW_DIR_BASELINE,  'cnn_core_project')]:
                if not os.path.isdir(fw_dir):
                    print(f"  SKIP {label}: dir not found")
                    continue
                write_weight_file(os.path.join(fw_dir, 'w7'),
                                  'w7', w_q, 'q_dense_weight_t', 'w7')
                write_weight_file(os.path.join(fw_dir, 'b7'),
                                  'b7', b_q, 'q_dense_bias_t', 'b7')

        elif 'conv' in lname and len(ws) >= 9:
            print(f"\n--- Processing QConv2D layer: {lname} ---")
            w_proxy = ws[0]   # (5, 1, 1, 7) proxy kernel
            b_proxy = ws[1]   # (7,)          proxy bias
            w_fbits = ws[8]   # (5, 1, 1, 7)  per-weight fractional bits
            b_fbits = ws[11]  # (7,)           bias fractional bits

            print(f"  Proxy kernel:  shape={w_proxy.shape}  min={w_proxy.min():.4f}  max={w_proxy.max():.4f}")
            print(f"  Weight fbits:  min={w_fbits.min():.4f}  max={w_fbits.max():.4f}  mean={w_fbits.mean():.4f}")
            print(f"  Bias fbits:    min={b_fbits.min():.4f}  max={b_fbits.max():.4f}  mean={b_fbits.mean():.4f}")

            # Conv weight fbits are ~4.5, very close to hls4ml's 4 — difference is small
            w_q = hgq_quantize(w_proxy, w_fbits)
            w_q = np.clip(w_q, WEIGHT_MIN, WEIGHT_MAX)
            b_q = hgq_quantize(b_proxy.reshape(-1, 1), b_fbits.reshape(-1, 1)).flatten()
            b_q = np.clip(b_q, WEIGHT_MIN, WEIGHT_MAX)

            hls4ml_step = 2.0 ** (-4)
            w_hls = np.round(w_proxy / hls4ml_step) * hls4ml_step
            n_changed = int(np.sum(np.abs(w_q - w_hls) > hls4ml_step * 0.5))
            mean_diff  = float((w_q - w_hls).mean())
            print(f"  Weights changed vs hls4ml rounding: {n_changed}/{w_q.size}  (expected ~0 since fbits≈4)")
            print(f"  Mean (HGQ_q - hls4ml_q): {mean_diff:.6f}")

            print(f"\n  Writing to {FW_DIR_STREAMING} ...")
            for fw_dir, label in [(FW_DIR_STREAMING, 'hls_streaming'),
                                   (FW_DIR_BASELINE,  'cnn_core_project')]:
                if not os.path.isdir(fw_dir):
                    print(f"  SKIP {label}: dir not found")
                    continue
                write_weight_file(os.path.join(fw_dir, 'w3'),
                                  'w3', w_q.flatten(), 'q_conv2d_weight_t', 'w3')
                write_weight_file(os.path.join(fw_dir, 'b3'),
                                  'b3', b_q, 'q_conv2d_bias_t', 'b3')

    print("\n[DONE] HGQ-quantized weights written.")
    print("Next steps:")
    print("  1. cd /home/work1/Works/CNN-Core-Generator/hls_streaming")
    print("  2. HLS_SYNTH=1 HLS_EXPORT=1 ./scripts/run_hls.sh")
    print("  3. Re-run wrapper simulation:")
    print("     cd /home/work1/Works/CNN-Core-Wrapper")
    print("     python3 scripts/run_behavioral_sim.py --threshold 0.0")
    print("     (threshold should now be close to 0, matching Keras)")


if __name__ == '__main__':
    main()

#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v vitis_hls >/dev/null 2>&1; then
  echo "ERROR: vitis_hls is not on PATH." >&2
  echo "Source your Vitis settings first, for example:" >&2
  echo "  source /tools/Xilinx/Vitis/2023.2/settings64.sh" >&2
  exit 1
fi

vitis_hls -f build_hls.tcl

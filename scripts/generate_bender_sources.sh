#!/bin/bash

# Navigate to the repository root (assuming the script is in scripts/)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="cnn_core_project/cnn_core_prj/solution1/impl/verilog"

# Check if the generated Verilog directory exists
if [ ! -d "$REPO_ROOT/$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    echo "Make sure you have run C Synthesis in Vitis HLS first."
    exit 1
fi

echo "Copy and paste the following into your bender.yml under the 'files:' section:"
echo "-------------------------------------------------------------------------"

# Find all .v files, sort them, and format them as YAML list items
find "$REPO_ROOT/$TARGET_DIR" -maxdepth 1 -name "*.v" | sort | while read -r filepath; do
    # Strip the absolute REPO_ROOT path to make it relative for bender.yml
    rel_path="${filepath#"$REPO_ROOT/"}"
    echo "      - $rel_path"
done

echo "-------------------------------------------------------------------------"
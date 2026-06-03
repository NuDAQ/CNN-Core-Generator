#!/usr/bin/env python3
import argparse
import re
import statistics
import xml.etree.ElementTree as ET
from pathlib import Path


def text(root, path, default="n/a"):
    elem = root.find(path)
    if elem is None or elem.text is None:
        return default
    return elem.text.strip()


def parse_top_xml(xml_path):
    if not xml_path.exists():
        return {}
    root = ET.parse(xml_path).getroot()
    return {
        "part": text(root, "./UserAssignments/Part"),
        "target_clock_ns": text(root, "./UserAssignments/TargetClockPeriod"),
        "clock_uncertainty_ns": text(root, "./UserAssignments/ClockUncertainty"),
        "estimated_clock_ns": text(root, "./PerformanceEstimates/SummaryOfTimingAnalysis/EstimatedClockPeriod"),
        "latency_min": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/Best-caseLatency"),
        "latency_max": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/Worst-caseLatency"),
        "latency_time": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/Worst-caseRealTimeLatency"),
        "interval_min": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/Interval-min"),
        "interval_max": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/Interval-max"),
        "dataflow_throughput": text(root, "./PerformanceEstimates/SummaryOfOverallLatency/DataflowPipelineThroughput"),
        "bram_18k": text(root, "./AreaEstimates/Resources/BRAM_18K"),
        "dsp": text(root, "./AreaEstimates/Resources/DSP"),
        "ff": text(root, "./AreaEstimates/Resources/FF"),
        "lut": text(root, "./AreaEstimates/Resources/LUT"),
        "uram": text(root, "./AreaEstimates/Resources/URAM"),
    }


def split_rpt_row(line):
    stripped = line.strip()
    if not stripped.startswith("|") or not stripped.endswith("|"):
        return []
    return [cell.strip() for cell in stripped.strip("|").split("|")]


def parse_instance_latency(rpt_path):
    if not rpt_path.exists():
        return []
    rows = []
    in_instance_table = False
    for line in rpt_path.read_text(errors="ignore").splitlines():
        if "* Instance:" in line:
            in_instance_table = True
            continue
        if in_instance_table and "* Loop:" in line:
            break
        cells = split_rpt_row(line)
        if len(cells) >= 9 and cells[2].isdigit() and cells[6].isdigit():
            rows.append(
                {
                    "instance": cells[0],
                    "module": cells[1],
                    "latency": int(cells[3]) if cells[3].isdigit() else int(cells[2]),
                    "interval": int(cells[7]) if cells[7].isdigit() else int(cells[6]),
                    "pipeline": cells[8],
                }
            )
    return rows


def parse_instance_resources(rpt_path):
    if not rpt_path.exists():
        return {}
    resources = {}
    in_utilization = False
    in_resource_instance = False
    for line in rpt_path.read_text(errors="ignore").splitlines():
        if "== Utilization Estimates" in line:
            in_utilization = True
        if in_utilization and "+ Detail:" in line:
            in_resource_instance = False
        if in_utilization and "* Instance:" in line:
            in_resource_instance = True
            continue
        cells = split_rpt_row(line)
        if in_resource_instance and len(cells) >= 7 and cells[2].replace("-", "0").isdigit():
            if cells[0] == "Total" or cells[0] == "Instance":
                continue
            resources[cells[0]] = {
                "bram_18k": cells[2],
                "dsp": cells[3],
                "ff": cells[4],
                "lut": cells[5],
                "uram": cells[6],
            }
    return resources


def parse_cosim_transaction(path):
    if not path.exists():
        return {}
    latencies = []
    intervals = []
    for line in path.read_text(errors="ignore").splitlines():
        m = re.match(r"\s*transaction\s+\d+:\s+(\d+)\s+(\d+|x)\s*$", line)
        if not m:
            continue
        latencies.append(int(m.group(1)))
        if m.group(2) != "x":
            intervals.append(int(m.group(2)))
    result = {}
    if latencies:
        result["rtl_cosim_latency_min"] = min(latencies)
        result["rtl_cosim_latency_max"] = max(latencies)
        result["rtl_cosim_latency_avg"] = round(statistics.mean(latencies), 2)
    if intervals:
        result["rtl_cosim_interval_min"] = min(intervals)
        result["rtl_cosim_interval_max"] = max(intervals)
        result["rtl_cosim_interval_avg"] = round(statistics.mean(intervals), 2)
    return result


def main():
    parser = argparse.ArgumentParser(description="Summarize a small Vitis HLS cnn_core run.")
    parser.add_argument("--project", required=True, type=Path)
    parser.add_argument("--solution", default="solution1")
    parser.add_argument("--top", default="cnn_core")
    args = parser.parse_args()

    solution = args.project / args.solution
    report_dir = solution / "syn" / "report"
    top_xml = report_dir / f"{args.top}_csynth.xml"
    top_rpt = report_dir / f"{args.top}_csynth.rpt"
    cosim_tx = solution / "sim" / "verilog" / f"{args.top}.performance.result.transaction.xml"

    top = parse_top_xml(top_xml)
    latency_rows = parse_instance_latency(top_rpt)
    resource_rows = parse_instance_resources(top_rpt)
    cosim = parse_cosim_transaction(cosim_tx)

    summary_path = solution / "hls_summary.txt"
    lines = []
    lines.append("HLS Summary")
    lines.append("===========")
    lines.append(f"Project: {args.project}")
    lines.append(f"Solution: {args.solution}")
    lines.append(f"Top: {args.top}")
    lines.append("")
    lines.append("Top Estimate")
    lines.append("------------")
    for key in [
        "part",
        "target_clock_ns",
        "clock_uncertainty_ns",
        "estimated_clock_ns",
        "latency_min",
        "latency_max",
        "latency_time",
        "interval_min",
        "interval_max",
        "dataflow_throughput",
    ]:
        lines.append(f"{key}: {top.get(key, 'n/a')}")
    lines.append("")
    lines.append("Top Resources")
    lines.append("-------------")
    for key in ["bram_18k", "dsp", "ff", "lut", "uram"]:
        lines.append(f"{key}: {top.get(key, 'n/a')}")
    if cosim:
        lines.append("")
        lines.append("RTL Cosim Transactions")
        lines.append("----------------------")
        for key, value in cosim.items():
            lines.append(f"{key}: {value}")
    if latency_rows:
        lines.append("")
        lines.append("Slowest Instances By Interval")
        lines.append("-----------------------------")
        for row in sorted(latency_rows, key=lambda item: item["interval"], reverse=True)[:8]:
            res = resource_rows.get(row["instance"], {})
            res_text = ""
            if res:
                res_text = f" | DSP {res['dsp']} FF {res['ff']} LUT {res['lut']} BRAM {res['bram_18k']}"
            lines.append(
                f"{row['interval']:>8} cyc | latency {row['latency']:>8} | {row['instance']}{res_text}"
            )
    lines.append("")
    lines.append("Notes")
    lines.append("-----")
    lines.append("HLS csynth estimates are pre-place-and-route and best used for iteration.")
    lines.append("Use RTL cosim interval when available for transaction-level confirmation.")
    lines.append("For internal-module timing, prefer out-of-context synthesis over top-level pin implementation.")

    output = "\n".join(lines)
    summary_path.write_text(output + "\n")
    print(output)
    print(f"\nWrote: {summary_path}")


if __name__ == "__main__":
    main()

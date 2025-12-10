# Autofix Bot Bench

Benchmark dataset of [Autofix Bot](https://autofix.bot) against other code/security review tools on the [OpenSSF CVE Benchmark](https://github.com/ossf-cve-benchmark/ossf-cve-benchmark).

## Benchmarked Tools

| Tool | Description |
|------|-------------|
| **Autofix Bot** | AI agent for deep code review |
| **Claude Code** | Anthropic's CLI security review |
| **Cursor Bugbot** | Cursor's PR review bot |
| **CodeRabbit** | AI code review platform |
| **Semgrep (CE)** | Static analysis (Community Edition) |

## Data Format

### Judged Results (`benchmarks/judged-results/`)
Final evaluation results in JSONL format with fields:
- `cve_id`: CVE identifier
- `variant`: `fixed` or `unfixed`
- `detected_issues`: Issues found by the tool
- `TP`, `FP`, `TN`, `FN`: Classification metrics
- `judge_reasoning`: Explanation of the judgment

### Processed Results (`benchmarks/processed/`)
Intermediate formatted results from each tool, normalized for comparison.

### Raw Output (`benchmarks/raw-output/`)
Original tool outputs per CVE, preserving the exact response from each tool.

## Archive

The `archive/` directory contains prompts and data from earlier benchmark runs:

## References

- [Autofix Bot Benchmarks](https://autofix.bot/benchmarks)
- [OpenSSF CVE Benchmark](https://github.com/ossf-cve-benchmark/ossf-cve-benchmark)


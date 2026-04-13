# DeepSource Benchmarks

Benchmark dataset evaluating code review and security analysis tools on the [OpenSSF CVE Benchmark](https://github.com/ossf-cve-benchmark/ossf-cve-benchmark).

## Benchmarked Tools

> Last updated: April 12, 2026

- [DeepSource](https://deepsource.com/)
- [Claude Code](https://claude.com/product/claude-code)
- [Codex](https://openai.com/codex/)
- [CodeRabbit](https://www.coderabbit.ai/)
- [Cursor](https://www.cursor.com/)
- [Devin](https://cognition.ai/)
- [GitLab Duo](https://docs.gitlab.com/ee/user/gitlab_duo/)
- [Greptile](https://www.greptile.com/)
- [Semgrep](https://semgrep.dev/)

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

- [OpenSSF CVE Benchmark](https://github.com/ossf-cve-benchmark/ossf-cve-benchmark)


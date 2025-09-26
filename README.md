# Autofix Bot Bench

This repository contains prompts used for benchmarking security analysis and remediation by [Autofix Bot](https://autofix.bot) and other security review tools.

- `benchmarks/security-analysis/prompts/`
  - `openai-codex-new-security-prompt.md` — Security review prompt used in OpenAI Codex CLI tool to identify vulnerabilities.
  - `autofix-eval-judge-prompt.md` — Judge prompt to evaluate whether a diff fully fixes a vulnerability.
  - `codex-autofix-prompt.md` — Security fix generation instruction used in Codex CLI for a detected vulnerability.
  - `claude-code-original-security-prompt.md` — Original security review prompt used by Claude Code CLI.
  - `claude-code-modified-security-prompt.md` — File-based security review prompt detecting intentional vulnerabilities for benchmarking. 
  - `claude-code-autofix-prompt.md` — Security fix generation prompt used in Claude Code CLI to fix a given vulnerability.
  - `gemini-cli-autofix-prompt.md` — Security fix generation prompt used in Gemini CLI to fix a vulnerability.

## Notes

- In Claude Code, the original security prompt was modified to optimize performance when analyzing large codebases through batched file processing. Using the CLI command `claude -p /security-review --permission-mode acceptEdits`, the approach processes 10 files per CLI instance, as Claude struggled with larger file counts while single-file analysis proved too memory intensive. The original prompt analyzed entire git diffs, but this caused token limits to be exceeded when processing large datasets. Key modifications include switching from git diff analysis to file-list based analysis to stay within token limits, explicitly instructing Claude to report intentional vulnerabilities in benchmark repositories (which it previously dismissed as non-real), and changing the output format from plain text stdout to structured JSONL file output for benchmarking purposes. The original prompt from the `/security-review` command was git-centric and designed for general security reviews, while the modified version is optimized for systematic vulnerability detection in testing environments with structured data collection.

- In Codex, since it lacks a dedicated security review feature, a custom security prompt was created by passing Claude Code's security review prompt through OpenAI's official prompt generator. The approach uses the CLI command `codex exec --sandbox workspace-write < {prompt}` to process 15 files at a time in parallel, demonstrating Codex's ability to handle larger batch sizes compared to Claude Code's 10-file limitation.

- Refer to [Autofix Bot benchmarks page](https://autofix.bot/benchmarks) for more information.
- For validation of detected security issues, [OWASP Benchmark Java](https://github.com/OWASP-Benchmark/BenchmarkJava) repository as ground truth.


# Archived - September 2025

This directory contains archived prompts from earlier benchmark runs.

## Contents

- `prompts/` - Security analysis and fix generation prompts used in benchmarking

### Prompts

| File | Description |
|------|-------------|
| `claude-code-original-security-prompt.md` | Original security review prompt from Claude Code CLI |
| `claude-code-modified-security-prompt.md` | Modified prompt for batched file processing |
| `claude-code-prompt.md` | Security fix generation prompt for Claude Code |
| `openai-codex-new-security-prompt.md` | Security review prompt adapted for Codex CLI |
| `codex-prompt.md` | Security fix generation prompt for Codex |
| `gemini-cli-prompt.md` | Security fix generation prompt for Gemini CLI |
| `deepsource-eval-judge-prompt.md` | Judge prompt for evaluating fix completeness |

## Notes

- In Claude Code, the original security prompt was modified to optimize performance when analyzing large codebases through batched file processing. Using the CLI command `claude -p /security-review --permission-mode acceptEdits`, the approach processes 10 files per CLI instance, as Claude struggled with larger file counts while single-file analysis proved too memory intensive.

- In Codex, since it lacks a dedicated security review feature, a custom security prompt was created by passing Claude Code's security review prompt through OpenAI's official prompt generator. The approach uses the CLI command `codex exec --sandbox workspace-write < {prompt}` to process 15 files at a time in parallel.

- For validation of detected security issues, [OWASP Benchmark Java](https://github.com/OWASP-Benchmark/BenchmarkJava) repository was used as ground truth.

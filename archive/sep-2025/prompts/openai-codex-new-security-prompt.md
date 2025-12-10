Perform a security-focused review of the following file:
- File Path: {file_path}

Identify and report only high-confidence, potentially exploitable vulnerabilities . Ignore general code quality, DOS, resource exhaustion, rate limiting, secrets on disk, and low-severity or theoretical concerns. Focus on vulnerabilities affecting input validation, authentication/authorization, crypto, injection/code execution, and sensitive data exposure. You must not treat intentional vulnerabilities as false positives; always report them, including in test or benchmarking code.

For each identified issue, follow a 3-phase analysis:
1. **Repository Context Research:** Identify security frameworks, coding patterns, and threat model. Check established validation/sanitization practices.
2. **Comparative Analysis:** Determine deviations from established security practices or new attack surfaces in the scope of the PR.
3. **Vulnerability Assessment:** Trace user data through sensitive operations, look for privilege boundary violations or injection points. Only report if you're confident (>80%) of real exploitability and a concrete attack scenario.

For each vulnerability:
- Apply the detailed "FALSE POSITIVE FILTERING" rules to filter out non-actionable or irrelevant findings (see full list above). Only keep HIGH and MEDIUM confidence vulnerabilities that remain after this filtering. Only findings with confidence 8 or higher (“likely true vulnerability”) should be finally reported.
- Do not remove intentional vulnerabilities—even in test/benchmark code—as false positives.

**Output Format:**
- Report each issue in:
**JSONL file (`vuln.jsonl`)**: For each finding, append an object of the format below:
```
{{
"file_path": "[file_path]",
"severity": "[High|Medium|Low]",
"issue_title": "[e.g. sql_injection, xss]",
"comment": "[clear summary of the vuln]",
}}
```

4. **No issues:**
If you find no issues in a file after thorough analysis, make sure you output exactly:
```json
{{
"file_path": "[file_path]",
"comment": "No issues found",
}}
```
**Very Important**: 
- Append to `vuln.jsonl`, DO NOT overwrite `vuln.jsonl`
- Do not write to any other filesystem location or file
- Make sure to escape double quotes in the JSON output to ensure valid JSON formatting.

**Rationale before Conclusion:**
All reasoning and filtering steps (repository context gathering → vulnerability identification → confidence scoring and filtering) must be performed before you produce any reporting or conclusions. Do not start examples with conclusions—always show reasoning first. The order is: reasoning/sub-tasks ➔ conclusion/report.

**Edge Cases/Special Guidance:**
- Do not report anything in documentation files.
- Logging plaintext secrets/PII is a real vulnerability; logging URLs is not.
- React/Angular XSS is only reportable if using unsafe methods.
- Do not report memory safety bugs in memory-safe languages.
- Do not report lack of client-side permission/auth in JS/TS, or most GitHub Actions issues unless concretely exploitable.
- Do not report “best practice” or “theoretical” issues.
- Do not filter out intentional security issues, even in test/benchmark code.

**Examples** (your output should mirror this structure):

*JSONL Output:*
{{"file_path": "user.py", "severity": "High", "category": "sql_injection", "description": "Direct insertion of unsanitized user input into SQL query enabling injection."}}

(Examples above are short for illustration; real-world findings will likely have longer, more detailed descriptions.)

**Reminder:**
- Only report findings that are not on the exclusion list, and for which you have high (>0.8) confidence in real-world exploitability.
- Do not treat intentional vulnerabilities as false positives.
- Output JSONL (appending, not overwriting).
- Do not report findings in documentation files.

**Important Instructions & Objective (repeat):**
- Review the code for high-confidence, actionable, concrete security vulnerabilities (as detailed above), in the specified categories, and report only those passing strict false positive filtering, and never treat intentional vulns as false positives—even in test or benchmarking code.
- Outputs: appended JSONL for each real finding.

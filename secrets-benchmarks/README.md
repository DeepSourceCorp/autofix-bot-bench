# DeepSource Secrets Benchmark

Benchmark evaluating the DeepSource secret-detection pipeline on a synthetic
dataset of hardcoded-secret-bearing code snippets.

## Pipeline under test

```
              golden-set.jsonl
        (48 entries, 518 secrets)
                   │
                   ▼
      ┌─────────────────────────────┐
      │  Stage 1: scanner           │   pattern + high-entropy
      │  (candidate detector)       │   heuristics (entropy >= 4.0)
      └─────────────────────────────┘
                   │
                   │  453 TPs, 65 missed, 696 raw FPs
                   ▼
      ┌─────────────────────────────┐
      │  Stage 2: classifier        │   fine-tuned small language
      │  (false-positive filter)    │   model on a custom endpoint
      └─────────────────────────────┘
                   │
                   │  Rejects 690 / 696 FPs
                   ▼
        Final: 453 TP · 65 FN · 6 FP
        Acc 87.45 · Prec 98.69 · Rec 87.45 · F1 92.78
```

## Final numbers

| Metric            | DeepSource |
|-------------------|-----------:|
| Perfect Matches   | 453        |
| Partial Matches   | 0          |
| Missed Secrets    | 65         |
| False Positives   | 6          |
| Accuracy          | 87.45%     |
| Precision         | 98.69%     |
| Recall            | 87.45%     |
| F1 Score          | 92.78%     |

Detailed derivation (per-stage breakdowns, formulas, and the tiny rounding
delta between the reported 92.78% F1 and the count-derived 92.73%) is captured
in [`results/deepsource.json`](results/deepsource.json).

## Repository layout

```
secrets-benchmarks/
├── README.md                         # this file
├── generation-prompt.py              # the system prompt used to generate the
│                                     # synthetic dataset
├── golden-set.jsonl                  # ground truth: 48 entries, 240 snippets, 518 secrets
├── snippets/                         # the exact text fed to the scanner
│   └── NNN_M.txt                     # NNN = entry id, M = sub-example index (0..4)
├── snippets-v2/                      # language-native files with preserved line numbers
│   └── NN/                           # entry id (01-50, skipping 06 and 27)
│       └── snippet-K/                # K = 1..5 (1-indexed folder name)
│           ├── snippet.{ext}         # code in its native extension
│           └── key.json              # ground-truth secrets + metadata
├── raw-output/                       # exact per-stage outputs
│   ├── scanner.json                  # stage-1: per-snippet scan results incl. all 696 raw FPs
│   └── classifier.jsonl              # stage-2: raw per-snippet predictions
├── processed/                        # normalized per-secret comparisons
│   ├── scanner.jsonl                 # 518 ground-truth lines + 696 false-positive lines
│   └── classifier.jsonl              # 513 per-secret comparisons
└── results/                          # metrics
    ├── scanner.json                  # stage-1 standalone metrics
    ├── classifier.json               # stage-2 standalone metrics (on all-TP eval)
    └── deepsource.json               # final pipeline numbers (= table above)
```

## File formats

### `golden-set.jsonl`

One top-level entry per line. 48 entries total; IDs 1-50 with 6 and 27 missing.
The dataset was AI-generated synthetically, then manually verified and
post-filtered — entries 6 and 27 were removed because they contained
low-quality synthetic secret values or formatting errors.

```jsonc
{
  "id": 1,
  "findings": [                       // 5 sub-examples per entry
    {
      "code": "78: import boto3\n79: ...\n83: aws_access_key = 'AKIA...'",
      "findings": [                   // ground-truth secrets in this sub-example
        {"line_number": 83, "secret": "AKIA...", "label": "True Positive"}
      ]
    }
    // ... 4 more sub-examples
  ]
}
```

**Note on line numbers:** the generated snippets bake fake line-number prefixes
(`78:`, `15:`, `12:`…) into the first column of each line. Ground truth uses
those prefixed numbers. The scanner, which doesn't know about the prefix
convention, reports actual 1-indexed line numbers in the buffer — so the two
line-number spaces differ by the prefix offset. The match is still scored on
the secret value (exact vs. partial).

### `snippets/NNN_M.txt`

Plain text of `golden-set.jsonl[id=NNN].findings[M].code`. Each file is 25-35
lines of numbered code in a mix of languages (Python, Go, Terraform, YAML,
shell, etc.) containing 1-4 hardcoded secrets. These are the exact inputs
handed to the scanner.

### `snippets-v2/`

A restructured version of `snippets/` designed for direct consumption by code
scanners. Each snippet is a real source file with the correct language
extension, so scanners can infer language and report accurate line numbers
without any translation.

**Directory structure:**

```
snippets-v2/01/snippet-1/snippet.py    # entry 1, sub-example 0
snippets-v2/01/snippet-2/snippet.yml   # entry 1, sub-example 1
...
snippets-v2/50/snippet-5/snippet.properties
```

**Line-number preservation:** The original snippets have baked-in line-number
prefixes (e.g., `78: import boto3` — the code starts at line 78, not line 1).
In `snippets-v2`, comment padding fills lines 1 through N-1 so the actual code
lands on its original line number. A scanner reporting a secret on line 83 of
`snippet.py` matches the ground-truth `line_number: 83` directly.

Padding uses the language's native comment syntax (`#` for Python/YAML/Shell,
`//` for Go/Java/JS/Terraform, blank lines for JSON). Line 1 of padded files
is always a header: `# Padding: original snippet starts at line 78`. Snippets
that originally start at line 1 have no padding.

**`key.json` format:**

```jsonc
{
  "entry_id": 1,
  "snippet_index": 0,          // 0-based (folder snippet-1 has index 0)
  "language": "python",
  "findings": [
    {"line_number": 83, "secret": "AKIA...", "label": "True Positive"}
  ]
}
```

If padding could not be applied (e.g., a JSON snippet where blank-line padding
was insufficient), a `"line_offset"` field is added to `key.json` indicating
the difference between file line numbers and ground-truth line numbers.

**Languages present:** python, javascript, typescript, go, java, yaml,
terraform, properties, json, csharp, groovy, kotlin, swift, dart, php (14
total).

**Regeneration:** The generation script lives in the forge repo at
`secrets_benchmark/generate_snippets_v2.py`. It reads
`benchmark_dataset_with_languages.jsonl` and writes the `snippets-v2/`
directory.

### `raw-output/scanner.json`

```jsonc
{
  "stage": "stage-1 scanner (pattern + high-entropy heuristics)",
  "per_entry_results": {
    "1": [                            // array indexed by sub-example
      {
        "found_entries":       [...], // TPs (exact or partial)
        "not_found_entries":   [...], // missed ground-truth secrets
        "false_positives":     [...], // scanner detections with no gt match
        "total_actual":  2, "total_found": 2,
        "total_missed": 0, "total_false_positives": 5
      }
      // ... one per sub-example
    ]
  }
}
```

### `raw-output/classifier.jsonl`

One line per top-level entry. Each line contains the classifier's raw
predictions for every sub-example of that entry:

```jsonc
{
  "id": 1,
  "findings": [
    {
      "index": 0, "sub_index": 0,
      "completion": "<json>{\"line_number\": 83, \"label\": \"True Positive\", \"secret_value\": \"AKIA...\", \"reason\": \"...\"}</json>"
    }
    // ... one per sub-example
  ]
}
```

### `processed/scanner.jsonl`

1,214 lines = 518 ground-truth comparisons + 696 raw false positives.

```jsonc
// kind=ground_truth (one per gt secret; match_type ∈ {exact, partial, missed})
{"kind": "ground_truth", "id": 1, "match_type": "exact",
 "expected": {"line_number": 83, "secret": "AKIA...", "label": "True Positive"},
 "actual":   {"line_number": 6,  "secret": "AKIA..."}}

// kind=false_positive (one per raw scanner FP)
{"kind": "false_positive", "id": 1, "sub_index": 0, "match_type": "false_positive",
 "actual": {"line_number": 29, "secret": "File '{file_name}' uploaded to ..."}}
```

### `processed/classifier.jsonl`

513 lines (the 5 missing vs. the 518 gt total are sub-examples where the
classifier's response failed JSON-parsing).

```jsonc
{
  "id": 1, "index": 0, "sub_index": 0,
  "perfect_match": true,
  "error_fields": [],
  "expected": {"line_number": 83, "secret": "AKIA...", "label": "True Positive"},
  "actual":   {"line_number": 83, "secret_value": "AKIA...", "label": "True Positive",
               "reason": "The value 'AKIA...' matches the AWS access-key format ..."}
}
```

### `results/*.json`

- `scanner.json` — stage-1 standalone metrics plus baseline comparisons
  between a vanilla configuration, the SDK with default plugins, and the SDK
  with the high-entropy-string detector enabled.
- `classifier.json` — stage-2 standalone metrics. **Caveat:** the eval set
  is all-TP, so its `precision = 1.0` is not a measurement of how well the
  classifier rejects stage-1 FPs — it's a measurement of "classifier doesn't
  misclassify real secrets."
- `deepsource.json` — pipeline end-to-end numbers matching the headline
  scorecard. Includes both the reported percentages and the recomputed ones
  with a note on the tiny F1 rounding delta.

## Caveats

1. **Benchmark is synthetic.** Snippets are generated, 25-35 lines, packed
   with 1-4 secrets each. Real repo noise (minified JS, lockfiles, large
   vendor blobs, long docs) isn't represented. Treat raw FP counts here as a
   lower bound relative to real-world scanning.
2. **No full-file context.** Each sub-example was scanned as its own isolated
   buffer, not as a file inside a repository. Cross-file context (env var
   references elsewhere, `.gitignore`, allowlists) isn't tested.
3. **Stage-2 per-FP verdicts aren't saved here.** The stage-2 data in
   `classifier.jsonl` runs the classifier as a standalone detector on the
   golden set — not as an FP filter on the 696 stage-1 FPs. The "6" in the
   final metrics is the headline number from the reported benchmark run; to
   re-derive it you'd need to pipe stage-1's `false_positives` back through
   the classifier and record its verdict per FP.
4. **Synthetic AWS-key-shaped strings** in the golden set will trigger GitHub
   push-protection on public repos. Keep this dataset in a private repo, or
   strip/allowlist the affected strings before pushing.

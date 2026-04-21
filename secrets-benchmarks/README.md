# DeepSource Secrets Benchmark

Benchmark evaluating the DeepSource secret-detection pipeline on a synthetic
dataset of hardcoded-secret-bearing code snippets.

## Pipeline under test

```
                snippets/
         (240 snippets, 518 secrets)
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
├── raw-dataset.jsonl                 # raw generator output; `snippets/` is derived from this
├── snippets/                         # 240 language-native snippets with preserved line numbers
│   └── NNN/                          # 001-240, one dir per snippet
│       ├── snippet.{ext}             # code in its native extension
│       └── ground-truth.json         # ground-truth secrets + metadata
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

### `raw-dataset.jsonl`

Raw output from the generator. One top-level entry per line, 48 entries (IDs
1-50 with 6 and 27 dropped during manual review). Each entry bundles 5
sub-examples together; `snippets/` is the exploded, language-native form used
for evaluation.

```jsonc
{
  "id": 1,
  "findings": [                       // 5 sub-examples per entry
    {
      "code": "78: import boto3\n79: ...\n83: aws_access_key = 'AKIA...'",
      "findings": [
        {"line_number": 83, "secret": "AKIA...", "label": "True Positive"}
      ]
    }
    // ... 4 more sub-examples
  ]
}
```

### `snippets/`

240 language-native snippets designed for direct consumption by code scanners.
Each snippet is a real source file with the correct language extension, so
scanners can infer language and report accurate line numbers without any
translation. The dataset was AI-generated synthetically, then manually
verified.

**Directory structure:**

```
snippets/001/snippet.py                # one dir per snippet, 001-240
snippets/002/snippet.yml
...
snippets/240/snippet.properties
```

Each directory holds the code plus a `ground-truth.json` with the expected
findings.

**Line numbers.** Each `snippet.{ext}` starts at line 1. `ground-truth.json`
reports the line within that file where each secret appears, so a scanner's
reported line number can be compared to `line_number` directly. The snippet's
original line offset (from the generator prompt) is preserved in
`raw-dataset.jsonl` if needed.

**`ground-truth.json` format:**

```jsonc
{
  "entry_id": 1,                   // original generation-prompt id
  "language": "python",
  "findings": [
    {"line_number": 6, "secret": "AKIA...", "label": "True Positive"}
  ]
}
```

**Languages present:** python, javascript, typescript, go, java, yaml,
terraform, properties, json, csharp, groovy, kotlin, swift, dart, php (14
total).

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

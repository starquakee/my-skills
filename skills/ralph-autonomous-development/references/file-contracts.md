# Ralph File Contracts

## `prd.json`

Location: repository root.

Purpose: executable checklist and branch identity.

```json
{
  "project": "Feature Name",
  "branchName": "ralph/feature-name",
  "description": "Short summary",
  "userStories": [
    {
      "id": "US-001",
      "title": "Small story title",
      "description": "As a role, I want capability so that outcome.",
      "acceptanceCriteria": [
        "Concrete verifiable condition",
        "Typecheck passes",
        "Tests pass"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    }
  ]
}
```

Rules:

- `branchName` should usually be `ralph/[feature-name]`.
- `priority` defines execution order.
- `passes` is the state machine.
- `notes` is for short status only; durable learning belongs in `progress.txt`.
- Do not encode the full architecture only in JSON.

## `progress.txt`

Location: repository root.

Purpose: durable memory between fresh agent runs.

Suggested header:

```text
# Ralph Progress: [Feature Name]

Started: YYYY-MM-DD
Source PRD: tasks/prd-[feature].md

## Codebase Patterns

- [Durable reusable pattern.]
```

Iteration entry:

```text
## YYYY-MM-DD HH:mm TZ - US-001
- Implemented ...
- Files changed:
  - `path/to/file`
- Validation:
  - `command`
- **Learnings for future iterations:**
  - [Gotcha or reusable pattern.]
---
```

Rules:

- Append; do not rewrite history during normal execution.
- Record failed validation honestly.
- Promote repeated gotchas into `Codebase Patterns`.
- Create this file before `scripts/ralph/ralph.sh --dry-run`; dry-run is a validator, not an initializer.

## `scripts/ralph/final-validation.sh`

Location: `scripts/ralph/final-validation.sh` in the target repository.

Purpose: executable aggregate validation for the completed story checklist.

Copy `references/final-validation-template.sh`, then replace its placeholder failure with the exact final commands from the PRD's `Validation` section. The script runs from the repository root and must exit 0 only when the integrated product passes those checks.

The runner requires this file to exist and be executable. When every story passes and the agent emits the completion token, the runner executes this script before reporting success. A failure is appended to `progress.txt` with its exit code and recent output, and the next agent iteration repairs it. Reaching the iteration limit without a successful final validation exits nonzero.

Do not leave the placeholder failure in place, and do not replace real validation with a no-op such as `exit 0` or `true`.

## `archive/`

Location: repository root.

Purpose: preserve previous Ralph runs before replacing root `prd.json`.

Suggested layout:

```text
archive/YYYY-MM-DD-feature-name/
  prd.json
  progress.txt
  prd-feature-name.md
```

Archive before writing a new `prd.json` if the existing `prd.json.branchName` differs. The ralph converter does this before overwriting the file; the runner only warns when it detects an unarchived branch change, because by then the old `prd.json` content is already lost.

Create the directory before dry-run:

```bash
mkdir -p archive
```

---
name: ralph-autonomous-development
description: "Run a complete Ralph-style autonomous coding workflow in any git repository: turn a feature idea into PRD markdown, convert it to prd.json, create or update scripts/ralph/AGENTS.md and scripts/ralph/ralph.sh, launch Codex/Claude/Amp one-story-per-iteration loops, supervise progress.txt, validate, commit, push, and finish safely. Use when the user asks to set up, learn, create, run, or operate automated Ralph development."
---

# Ralph Autonomous Development

Use this skill to create or operate a repository-local autonomous development loop. Ralph is not a model; it is a workflow:

```text
feature intent
  -> PRD markdown
  -> prd.json story checklist
  -> scripts/ralph/AGENTS.md iteration prompt
  -> scripts/ralph/ralph.sh loop runner
  -> one story per fresh agent run
  -> progress.txt + git commits as durable memory
```

## First Decision

Identify the user's intent:

- **Learn/explain:** explain the workflow and point to the file contracts.
- **Set up in a repo:** create the Ralph files and templates.
- **Convert an existing PRD:** use the `ralph` skill to produce `prd.json`.
- **Start from a rough idea:** use the `prd` skill first, then `ralph`.
- **Run the loop:** verify files, run dry-run, launch with the requested tool.
- **Repair a run:** inspect `prd.json`, `progress.txt`, recent commits, and failed validation.

Use this skill together with:

- `prd` when the source PRD markdown does not exist yet.
- `ralph` when converting a PRD markdown into `prd.json`.
- `write-a-skill` or `skill-creator` only when improving this skill itself.

## Repository Preflight

Before creating files or launching:

```bash
git status --short --branch
test -d .git
command -v jq
```

Then inspect existing conventions:

```bash
find .. -name AGENTS.md -print
find . -maxdepth 3 -type f \( -name 'package.json' -o -name 'pyproject.toml' -o -name 'Cargo.toml' -o -name 'go.mod' \)
```

If the worktree is dirty, do not overwrite unrelated user changes. If an existing `prd.json` tracks another branch, archive it before starting a new run.

## Phase 1: Write The PRD

If no PRD exists, invoke the `prd` skill. The PRD should live at:

```text
tasks/prd-[feature-name].md
```

Require these sections for autonomous work:

- `Introduction`
- `References`
- `Decisions`
- `Goals`
- `Non-Goals`
- `User Stories`
- `Functional Requirements`
- `Validation`
- `Risks` or `Open Questions`

Write PRDs for agents, not only humans:

- prefer explicit constraints over vibes
- name code paths and docs to inspect
- state what must not be done
- state which tests or real validations prove completion
- split risky work into small independently passing stories

For PRD quality rules, read `references/prd-authoring.md`.

## Phase 2: Convert PRD To prd.json

Invoke the `ralph` skill to convert the markdown PRD into root `prd.json`.

Every story must be:

- small enough for one fresh agent context
- dependency ordered by `priority`
- initialized with `passes: false`
- concrete enough to validate
- independent enough to commit after completion

Always include validation criteria such as:

```text
Typecheck passes
Focused tests pass
Browser verification passes
Real integration validation passes
```

Use the exact `prd.json` shape in `references/file-contracts.md`.

## Phase 3: Create Ralph Handoff Files

Create or update:

```text
scripts/ralph/AGENTS.md
scripts/ralph/ralph.sh
progress.txt
archive/
```

Use `references/agents-template.md` for `scripts/ralph/AGENTS.md`.
Use `references/runner-template.sh` for `scripts/ralph/ralph.sh`.
Use `references/file-contracts.md` for `progress.txt` and archive rules.

Make `scripts/ralph/AGENTS.md` specific to the current repo. It must tell the fresh agent:

- what source PRD and architecture docs to read
- how to choose the next story
- to implement exactly one story
- which validation commands are mandatory
- how to update `prd.json` and `progress.txt`
- how to commit and push
- when to output `<promise>COMPLETE</promise>`

## Phase 4: Dry Run

Run:

```bash
scripts/ralph/ralph.sh --dry-run
```

Dry-run must verify:

- root `prd.json` exists
- `prd.json.branchName` is present
- root `progress.txt` exists
- `archive/` exists
- the requested tool is supported by the runner

Fix dry-run failures before launching.

## Phase 5: Launch

Start with a small iteration count:

```bash
scripts/ralph/ralph.sh --tool codex 3
```

Then continue in batches:

```bash
scripts/ralph/ralph.sh --tool codex 10
```

Use `--tool claude` or `--tool amp` only if those CLIs are installed and the runner template supports them.

## Phase 6: Supervise

Between batches, inspect:

```bash
git log --oneline --decorate -20
git status --short --branch
jq '.userStories[] | select(.passes == false) | {id,title,priority}' prd.json
tail -120 progress.txt
```

Stop and repair if you see:

- repeated validation failures on the same story
- broad unrelated refactors
- stories marked passing without evidence
- skipped browser/real integration validation
- old forbidden behavior being reintroduced
- one story growing beyond one iteration

Common repair actions:

- split a story into smaller stories
- add a residue/audit story for forbidden behavior
- strengthen `scripts/ralph/AGENTS.md`
- add exact validation commands to acceptance criteria
- update `progress.txt` with durable gotchas

## Phase 7: Finish

When all stories pass:

```bash
jq -e 'all(.userStories[]; .passes == true)' prd.json
```

Run the PRD's final aggregate validation. Then decide whether to merge, open a PR, tag a release, or archive the run.

Only the autonomous agent should emit:

```text
<promise>COMPLETE</promise>
```

when every story is complete and validated.

## Safety Rules

- Do not run Ralph against a dirty worktree unless the user explicitly accepts the risk.
- Do not let `prd.json` replace the markdown PRD; `prd.json` is only the executable checklist.
- Do not mark `passes: true` without validation evidence.
- Do not make a story depend on a later story.
- Do not hide failures in `notes`; leave the story failing and record the blocker in `progress.txt`.
- Do not push secrets, temp homes, logs, or generated credentials from validation runs.
- Prefer narrow, deterministic checks over broad "works correctly" criteria.


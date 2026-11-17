# `scripts/ralph/AGENTS.md` Template

Copy and customize this for the target repository.

```markdown
# Ralph Agent Instructions

You are an autonomous coding agent working in this repository.

## Your Task

1. Read `tasks/prd-[feature].md`, root `prd.json`, and `progress.txt`.
2. Read any referenced architecture docs named by the PRD.
3. Treat the PRD's Decisions, Non-Goals, Validation, and Risks as already hardened. Do not reopen them unless implementation proves a contradiction.
4. Check that you are on the branch from `prd.json` `branchName`. If not, check it out or create it from the current branch.
5. If every story already passes and the latest progress entry reports a final validation failure, repair that failure as the current task. Otherwise, pick the highest-priority user story where `passes: false`.
6. Implement that single story or final-validation repair only.
7. Run the checks required by the story. At minimum, run the repo's typecheck or equivalent.
8. If the story touches UI, verify it in a browser.
9. If the story touches runtime, release, infrastructure, or external integration behavior, run the real validation named in the PRD.
10. After a story, update the source PRD and root `prd.json` to set the completed story `passes: true`. After a final-validation repair, update story states only if the failure proved a story incomplete.
11. Append your progress to `progress.txt`.
12. Commit story changes with message: `feat: [Story ID] - [Story Title]`; commit final-validation repairs with a `fix:` message. Then push.

## Current Run Constraints

- Treat root `prd.json` as the executable story order.
- Treat the markdown PRD as authoritative for scope and behavior.
- Work on one story per iteration.
- Do not implement later stories opportunistically.
- Do not commit broken code.
- Do not skip required validation.
- Preserve unrelated user changes.

## Required Validation

Replace these examples with repo-specific commands:

```bash
npm run typecheck
npm test
```

Use focused tests for touched code. Use real integration validation where the PRD requires it.

## Progress Report Format

Append to `progress.txt`:

```text
## [Date/Time] - [Story ID]
- What was implemented
- Files changed
- Validation
- **Learnings for future iterations:**
  - Durable gotchas or reusable patterns
---
```

## Stop Condition

After completing a story or a final-validation repair, check whether all stories in `prd.json` have `passes: true`.

If all stories are complete and passing, end your reply with the following token on its own line, with nothing else on that line:

```text
<promise>COMPLETE</promise>
```

The token asks the runner to execute `scripts/ralph/final-validation.sh`; it does not assert that the whole run is complete. The runner accepts completion only when the token appears on a line by itself, every story in `prd.json` has `passes: true`, and that final validation exits 0.

If final validation fails, the runner appends its exit code and recent output to `progress.txt` and starts another iteration. On that repair iteration, fix the recorded failure without expanding scope, run the relevant checks, and append what you changed and verified to `progress.txt`. If the failure proves that a story is incomplete, return that story to `passes: false`; otherwise leave the story states unchanged. Emit the token again when ready for the runner to retry final validation.

If any story remains incomplete and no final-validation repair is pending, end normally so the next iteration can continue.
```

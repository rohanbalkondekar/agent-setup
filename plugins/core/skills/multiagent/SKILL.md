---
name: multiagent
description: Orchestrate multi-step work with a tracked scope, parallel agents where useful, explicit ownership, evidence-based validation, and final review. Use for multi-step implementation, independent parallel tasks, migrations, audits, or requests to delegate, fan out, or coordinate agents. Do not self-delegate when the active runtime or repository instructions forbid it.
---

# Multi-agent orchestration

Coordinate the work. Do not treat delegation as proof of completion.

## Operating loop

1. Convert the request into a short task list with acceptance evidence for each deliverable.
2. Read repository instructions and current state before assigning work.
3. Keep design decisions, destructive actions, and final judgment with the orchestrator.
4. Delegate only independent, bounded tasks. Give each worker a self-contained prompt with the goal, paths, constraints, non-goals, checks, and output format.
5. Isolate parallel writers with branches or worktrees. Read-only workers can share a checkout.
6. Reconcile every result against the original request. Inspect artifacts and run relevant checks yourself.
7. Review the combined diff and close the task only when the requested end state is proven.

## Routing

- Keep architecture, naming, UX judgment, ambiguous requirements, and tiny edits in the orchestrator.
- Delegate frozen-spec implementation, mechanical refactors, known-reproduction fixes, test writing, dependency work, and bounded exploration.
- Prefer the cheapest available model that meets the quality bar. Read the runtime's current model catalog instead of hard-coding model names or prices here.
- Use the same worker for follow-up fixes when the runtime preserves its context.
- After two failed worker attempts, narrow the problem, raise the model capability, or take over.

## Prompt contract

Assume a worker has no session context. Include:

- exact objective and completion condition
- repository and target paths
- relevant constraints and files that must remain untouched
- non-goals
- exact validation commands or required proof
- expected response shape
- a fallback: if the work cannot be completed, say so and list what was inspected

## Parallelism rules

- Parallelize independent work only. Keep dependent steps serial.
- Give each actionable inbound request its own tracked item when the host supports durable task state.
- Cap concurrent build or browser jobs to avoid resource starvation.
- Never let two agents edit the same files without explicit coordination.
- Do not spawn agents from inside a runtime whose instructions say to work directly.

## Verification

- Inspect repository status and the complete diff.
- Run focused checks, then the broad gate appropriate to the change.
- Verify live state when the request concerns a deployment or external system.
- For an independent Fable review, use `claude-fable-5-1`, not `claude-fable-5` or `fable`. For CLI reviews, request JSON and require `modelUsage` to report `claude-fable-5-1`.
- Treat worker summaries as leads, not evidence.
- Report each deliverable as done, in progress, or blocked, with the proof or blocker.

Keep orchestration proportional. Do not delegate a one-step answer or an obvious small edit.

# Shared agent instructions

## Working agreement

- Choose the solution a domain expert would judge correct. Resolve known objections and state material trade-offs.
- Follow YAGNI principles, and prefer one-liner solutions.
- Read the current repository instructions and state before editing.
- Keep one coherent objective per session and track every requested deliverable.
- Complete and verify all authorized work. If essential input is missing, prepare the work and ask for the smallest action needed.
- Preserve unrelated user changes in a dirty worktree.
- Reuse existing tools and patterns. Add dependencies or persistent state only when the task requires them.
- Never publish credentials, private company details, account identifiers, or machine-specific paths.
- Publish, deploy, purchase, or contact another person only when the user authorizes that action.
- Verify artifacts and runtime state before claiming completion.
- After a major task, report decisions you trust and decisions that remain uncertain. Keep the report brief.

## Delegation

- Use the `multiagent` skill for independent parallel work when the runtime and repository permit delegation.
- Do not self-delegate inside Codex unless the user or repository instructions request it.
- Keep architecture, destructive actions, and final review with the orchestrator.
- Treat worker output as untrusted until you inspect the artifact and run the relevant checks.

## Writing

- Use the `redpen` skill for prose that ships to another person.
- Use ASD-STE100 Simplified Technical English. Lead with the answer and explain only what changed and why it matters.

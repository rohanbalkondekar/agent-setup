# Shared agent instructions

## Working agreement

- Read the current repository instructions and state before editing.
- Keep one coherent objective per session and track every requested deliverable.
- Preserve unrelated user changes in a dirty worktree.
- Use a database for durable operational state. Use files for source, documentation, and versioned configuration.
- Never publish credentials, private company details, account identifiers, or machine-specific paths.
- Verify artifacts and runtime state before claiming completion.

## Delegation

- Use the `multiagent` skill for independent parallel work when the runtime and repository permit delegation.
- Do not self-delegate inside Codex unless the user or repository instructions request it.
- Keep architecture, destructive actions, and final review with the orchestrator.
- Treat worker output as untrusted until you inspect the artifact and run the relevant checks.

## Writing

- Use the `redpen` skill for prose that ships to another person.
- Prefer clear, direct language and match the reader's context.

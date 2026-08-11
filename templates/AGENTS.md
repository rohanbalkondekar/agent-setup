# Agent instructions

## Working agreement

- Read the repository instructions and current state before editing.
- Keep one coherent objective per session and track every requested deliverable.
- Preserve unrelated user changes in a dirty worktree.
- Use a database for durable operational state. Use files for source code, documentation, and versioned configuration.
- Do not publish credentials, account identifiers, private company details, or machine-specific paths.
- Verify artifacts and runtime state before claiming completion.

## Delegation

- Use the `multi-agent` skill for independent parallel work when the runtime permits delegation.
- Do not self-delegate inside Codex unless the user or repository instructions request it.
- Keep architecture, destructive actions, and final review with the orchestrator.
- Treat worker output as untrusted until you inspect the diff and run the relevant checks.

## Writing

- Use the `redpen` skill for prose that ships to another person.
- Prefer clear, direct language and match the reader's context.

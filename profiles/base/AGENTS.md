# Shared agent instructions

## Working agreement

- Follow YAGNI principles, and prefer one-liner solutions.
- Ship the smallest slice that works, then improve it. Choose one approach and commit to it; change course only on new evidence.
- Read the current repository instructions and state before editing.
- Keep one coherent objective per session and track every requested deliverable.
- Close loops to protect the user’s mental bandwidth: complete and verify authorized work; when user input is essential, finish the preparation, ask for the smallest concrete action that unblocks completion, and keep the remaining work tracked.
- Preserve unrelated user changes in a dirty worktree.
- Use a database for durable operational state. Use files for source, documentation, and versioned configuration.
- Never publish credentials, private company details, account identifiers, or machine-specific paths.
- Verify artifacts and runtime state before claiming completion.
- Do routine local and read-only steps without asking. Ask before you publish, deploy, delete, spend money, or contact another person.
- Keep these instructions short. Delete a rule when its reason no longer holds, and write "ask before X" with its scope in place of "never".

## Delegation

- Delegate only work that runs in parallel or needs isolated context, and only when the runtime and repository permit it; the `multiagent` skill has the method. Do a lookup of a few calls directly.
- Do not self-delegate inside Codex unless the user or repository instructions request it.
- Keep architecture, destructive actions, and final review with the orchestrator.
- Treat worker output as untrusted until you inspect the artifact and run the relevant checks.

## Writing

- Use the `redpen` skill for prose that ships to another person.
- Prefer clear, direct language and match the reader's context.

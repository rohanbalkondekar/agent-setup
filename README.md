# agent-setup

Shared instructions and skills for Claude Code, Codex, and Prime Agent.
The installer links each runtime to this checkout, so they use the same source files.

## Skills

| Skill | Purpose |
|---|---|
| `multiagent` | Coordinate independent tasks and verify the combined result. |
| `redpen` | Edit prose for clarity while preserving facts, intent, and voice. |
| `powerlaw` | Prioritize work or review workplace strategy. |
| `grillme` | Pressure-test a plan through focused questions. |
| `prove-it` | Verify the actual output before claiming completion. |
| `show-me-your-work` | Keep a reviewable decision trail for substantial work. |
| `wizard` | Generate a guided script for steps a human must perform. |
| `blast-radius` | Trace downstream risks and test the assumptions behind a change. |

## Install

```sh
git clone https://github.com/rohanbalkondekar/agent-setup.git
cd agent-setup
./scripts/install.sh
```

The installer links skills into `~/.claude/skills`, `~/.codex/skills`, and
`~/.prime/agent/skills`. It also links [the shared base](profiles/base/AGENTS.md)
to each runtime's global instruction file.

Existing conflicting files and directories move to adjacent `.backup.<timestamp>.<process-id>` paths. Correct links stay untouched on subsequent runs.
Keep this checkout in place; moving or deleting it breaks the links.
Restart active agent sessions after changing the source files.

The scripts configure runtime directories. They do not install or authenticate the agents themselves.

### Options

| Variable | Default | Effect |
|---|---|---|
| `AGENT_SETUP_SKILLS` | All eight skills above | Select a space-separated list of skill names. Invalid selections fail before installation. |
| `AGENT_SETUP_GLOBAL` | `1` | Set to `0` to preserve private global instruction files. |
| `AGENT_SETUP_PLUGINS` | `DietrichGebert/ponytail=ponytail@ponytail` | Set to an empty string to skip third-party plugin installation. |
| `CODEX_HOME` | `~/.codex` | Override the Codex configuration directory. |
| `PRIME_AGENT_CODING_AGENT_DIR` | `~/.prime/agent` | Override the Prime Agent configuration directory. |

For example, install shared skills while preserving private global instructions and skipping plugins:

```sh
AGENT_SETUP_GLOBAL=0 AGENT_SETUP_PLUGINS='' ./scripts/install.sh
```

Use the same skill and global overrides when running verification. Selecting fewer skills
only changes which links are installed and checked; it does not uninstall existing skills.

## Local workspace instructions

Supply any Markdown instruction file and the workspace that should use it:

```sh
./scripts/install-scope.sh "$HOME/.config/agent-setup/team/AGENTS.md" /path/to/workspace
```

Create that file with your own project or company rules before running the command.
Keep private profiles outside this checkout, or in its ignored `private/` directory.
Each person chooses their own names and locations; the installer has no named scope presets.
The script links to these instruction files; it does not execute their contents.

From the checkout root, use the public shared base for a workspace:

```sh
./scripts/install-scope.sh profiles/base/AGENTS.md /path/to/workspace
```

The script preserves existing `AGENTS.md` and `CLAUDE.md` files. When both are absent,
it links `AGENTS.md` to your instruction file and `CLAUDE.md` to that `AGENTS.md`.
Updates to your source file flow through those links. Keep the source file in place.
Existing repository rules stay in control; review them directly when they need changes.
Install instructions at the repository roots where you need them.

Before updating an older checkout, copy any workspace profiles you use to a private location
and repoint their workspace links. Git removes the previously tracked `personal`, `outsight`,
and `work` profiles when this change is pulled. Ignoring a path does not preserve a tracked file.
Local profiles explicitly retained under `profiles/` remain ignored; only `profiles/base/` is versioned.
The installer now takes file paths in place of the previous named-scope arguments.
It reports empty or dangling existing instructions before creating links. Restore the file or manually repoint the existing symlink, then rerun.

## Update and verify

```sh
./scripts/update.sh
./scripts/verify.sh
```

The updater refuses a dirty checkout. After you review and commit or stash local changes,
it pulls with `--ff-only`, repairs links, and runs verification.

Verification checks the selected shared skill links and, unless disabled, global instruction links.
It does not verify third-party plugins, workspace profiles, authentication, or agent behavior.

Run the setup regression checks before submitting script changes:

```sh
python3 scripts/test_setup.py
```

These checks use temporary runtime homes and stub plugin commands. They do not contact external services.

## Third-party plugins

The installer attempts to install [Ponytail](https://github.com/DietrichGebert/ponytail)
through each available `claude` and `codex` CLI. Plugin installation is best-effort;
an attempted installation is not proof of success. Plugins remain managed by their upstream marketplaces.

Use `AGENT_SETUP_PLUGINS="owner/repo=plugin@marketplace ..."` to select plugins, or an empty string to skip them.

The repository also includes Claude Code marketplace metadata for versioned plugin installs.
Direct links use this checkout; marketplace installs use cached copies.

## Public and private configuration

Keep credentials, account identifiers, company details, private memory, session logs,
and machine-specific settings in local or private configuration. Repository-specific rules
belong with their repositories. Durable operational state belongs in a database;
source, documentation, and versioned configuration belong in files.

## License and sources

MIT License. Source credits are kept here for attribution and future upstream reviews.

### Redpen sources

Merged from: stop-slop by Hardik Pandya (hvpandya.com, MIT), humanizer (github.com/blader/humanizer, based on Wikipedia:Signs of AI writing), an ASD-STE100 distillation, selected checks from unslop (pstack, github.com/cursor/plugins, MIT, Lauren Tan), and Slava Akhmechet's [status-update advice](https://x.com/spakhm/status/2093168407415816478).

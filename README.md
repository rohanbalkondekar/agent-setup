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

Existing conflicting files and directories move into unique `.backup.*` directories
beside their original locations. Correct links stay untouched on subsequent runs.
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

## Scope profiles

```sh
./scripts/install-scope.sh personal <workspace-directory>
./scripts/install-scope.sh outsight <workspace-directory>
./scripts/install-scope.sh work <workspace-directory>
```

`personal` uses the shared base. `outsight` and `work` add their respective scope rules.
The separate personal profile has been removed.

The script preserves existing `AGENTS.md` and `CLAUDE.md` files. When both are absent,
it links `AGENTS.md` to the selected profile and `CLAUDE.md` to that `AGENTS.md`.
When repository instructions already exist, it only adds the missing Claude link.
Install profiles at the repository roots where you need them.

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

MIT License. Skills retain their source credits and reference material.
Redpen includes adaptations inspired by Stop Slop, Humanizer, and ASD-STE100 guidance.

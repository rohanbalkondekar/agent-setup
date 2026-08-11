# agent-setup

Open-source agent configuration shared across Claude Code and Codex.

The repository is the canonical source for four daily skills:

- `multi-agent`: task decomposition, delegation, reconciliation, and verification
- `redpen`: direct, human prose editing with technical and relational registers
- `power-law`: priority and stakeholder power checks used by Redpen
- `grill-me`: structured interrogation of plans before implementation

## Install

```sh
git clone https://github.com/rohanbalkondekar/agent-setup.git ~/Personal/agent-setup
~/Personal/agent-setup/scripts/install.sh
```

The installer adds this repository as a Claude Code marketplace, installs the
`agent-core` plugin, and links all skills into `~/.codex/skills`. Claude Code
agents load the plugin skills. Codex sessions load the same files through the
links, so the two runtimes cannot drift on one machine.

Run `git pull` in the clone and restart active agent sessions to pick up an
update. Run `scripts/verify.sh` to check the links and Claude plugin.

## Portable instructions

[`templates/AGENTS.md`](templates/AGENTS.md) contains the public baseline for a
repository or user-level agent instruction file. Copy or extend it locally.
Keep company rules and repository-specific constraints in private overlays.

## Deliberate exclusions

This repository does not contain credentials, MCP server configuration,
account identifiers, company-specific skills, private memory, session logs,
or machine-specific model availability. Those values belong in local or
private configuration. The public skills discover current runtime capabilities
instead of embedding a dated model roster.

## License and sources

The repository uses the MIT License. Redpen includes original rules and
adaptations inspired by Hardik Pandya's Stop Slop, blader's Humanizer, and the
public ASD-STE100 controlled-language guidance. See the skill for attribution.

# agent-setup

Open-source agent configuration shared across Claude Code, Codex, and Prime Agent.

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

The installer links every skill into both `~/.claude/skills` and
`~/.codex/skills`, plus `~/.prime/agent/skills`. It links the shared base into
each runtime's global instruction location. All three runtimes therefore load
the same source files and cannot drift on one machine.

Run `git pull` in the clone and restart active agent sessions to pick up an
update. Run `scripts/verify.sh` to check all three runtimes.

For a safe fast-forward update that also repairs the shared links, run:

```sh
~/Personal/agent-setup/scripts/update.sh
```

## Scope profiles

The setup separates shared behavior from three contexts:

- `personal`: public and personal projects
- `outsight`: Outsight product and company projects
- `work`: confidential employer projects

Install a profile at a workspace or repository root:

```sh
scripts/install-scope.sh personal ~/Personal
scripts/install-scope.sh outsight ~/Personal/outsight
scripts/install-scope.sh work ~/Work
```

The script never overwrites an existing `AGENTS.md` or `CLAUDE.md`. If neither
exists, both runtimes point to the chosen profile. If `AGENTS.md` already
contains detailed repository rules, the script only links Claude Code to that
same file.

Codex always reads the shared global instructions. It then reads instructions
from the active Git repository root down to the working directory. Add a scope
profile at each standalone repository root that does not already have its own
instructions. A profile installed only at `~/Personal` or `~/Work` does not
replace repository-root instructions.

Prime Agent reads the same global base and discovers `AGENTS.md` or `CLAUDE.md`
in parent and project directories. Its continual harness may add session-local
lessons, but those refinements are supplemental. Review and commit durable
rules here instead of allowing a runtime to rewrite the shared base.

Prime Agent is optional. If it is not installed on a machine, follow the
[official Prime Agent setup](https://github.com/PrimeIntellect-ai/prime-agent),
then rerun `scripts/install.sh`. The installer configures Prime Agent but does
not download or authenticate third-party software.

The repository also remains a Claude Code plugin marketplace for people who
prefer versioned plugin installs. The direct-link installer is the recommended
setup when one person uses both runtimes because plugin installs use cached
copies.

## Portable instructions

[`profiles/base/AGENTS.md`](profiles/base/AGENTS.md) contains the public global
baseline. The three scope profiles add only the differences for Personal,
Outsight, and Work. Keep company details and repository constraints in private
or repository-owned overlays.

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

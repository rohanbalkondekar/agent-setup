#!/usr/bin/env bash
# Shared settings for installation and verification. Source from these scripts.
repo_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
claude_home="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
codex_home="${CODEX_HOME:-$HOME/.codex}"
prime_home="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
skill_dirs=("$claude_home/skills" "$codex_home/skills" "$prime_home/skills")
instruction_files=("$claude_home/CLAUDE.md" "$codex_home/AGENTS.md" "$prime_home/AGENTS.md")
global_instructions="$repo_dir/profiles/base/AGENTS.md"
global_mode="${AGENT_SETUP_GLOBAL:-auto}"
skills="${AGENT_SETUP_SKILLS:-multiagent redpen powerlaw grillme prove-it show-me-your-work wizard blast-radius}"

# Reject invalid settings before changing installed files.
case "$global_mode" in
  auto|0|1) ;;
  *) printf 'AGENT_SETUP_GLOBAL must be auto, 0, or 1.\n' >&2; exit 1 ;;
esac
for skill in $skills; do
  case "$skill" in
    *[!a-z0-9-]*|-*) printf 'Invalid skill name: %s\n' "$skill" >&2; exit 1 ;;
  esac
  if [[ ! -f "$skills_dir/$skill/SKILL.md" ]]; then
    printf 'Skill not found: %s\n' "$skill" >&2
    exit 1
  fi
done
if [[ "$global_mode" != 0 ]] && [[ ! -f "$global_instructions" || ! -s "$global_instructions" || ! -r "$global_instructions" ]]; then
  printf 'Shared instructions are missing, empty, or unreadable: %s\n' "$global_instructions" >&2
  exit 1
fi
if [[ "$global_mode" == auto ]]; then
  for file in "${instruction_files[@]}"; do
    if [[ -e "$file" || -L "$file" ]] && [[ ! -f "$file" || ! -s "$file" || ! -r "$file" ]]; then
      printf 'Existing instructions are empty, unreadable, invalid, or dangling: %s. Restore them or use AGENT_SETUP_GLOBAL=1 to replace them.\n' "$file" >&2
      exit 1
    fi
  done
fi

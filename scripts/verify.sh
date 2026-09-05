#!/usr/bin/env bash
set -euo pipefail
trap 'printf "Verification failed at line %s: %s\n" "$LINENO" "$BASH_COMMAND" >&2' ERR

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"
prime_home="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
prime_dir="$prime_home/skills"
global_instructions="$repo_dir/profiles/base/AGENTS.md"

skills="${AGENT_SETUP_SKILLS:-multiagent redpen powerlaw grillme prove-it show-me-your-work wizard blast-radius}"

for skill in $skills; do
  test -f "$skills_dir/$skill/SKILL.md"
  for runtime_dir in "$claude_dir" "$codex_dir" "$prime_dir"; do
    test -L "$runtime_dir/$skill"
    test "$(readlink "$runtime_dir/$skill")" = "$skills_dir/$skill"
    cmp -s "$runtime_dir/$skill/SKILL.md" "$skills_dir/$skill/SKILL.md"
  done
done

# Set AGENT_SETUP_GLOBAL=0 on machines that keep a private CLAUDE.md/AGENTS.md.
if [[ "${AGENT_SETUP_GLOBAL:-1}" == "1" ]]; then
  test "$(readlink "${CODEX_HOME:-$HOME/.codex}/AGENTS.md")" = "$global_instructions"
  test "$(readlink "$HOME/.claude/CLAUDE.md")" = "$global_instructions"
  test "$(readlink "$prime_home/AGENTS.md")" = "$global_instructions"
  cmp -s "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" "$global_instructions"
  cmp -s "$HOME/.claude/CLAUDE.md" "$global_instructions"
  cmp -s "$prime_home/AGENTS.md" "$global_instructions"
fi

printf 'Selected skill links verified for Claude Code, Codex, and Prime Agent (global instructions checked: %s).\n' "${AGENT_SETUP_GLOBAL:-1}"

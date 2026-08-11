#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"
prime_home="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
prime_dir="$prime_home/skills"
global_instructions="$repo_dir/profiles/base/AGENTS.md"

for skill in multi-agent redpen power-law grill-me; do
  test -f "$skills_dir/$skill/SKILL.md"
  for runtime_dir in "$claude_dir" "$codex_dir" "$prime_dir"; do
    test -L "$runtime_dir/$skill"
    test "$(readlink "$runtime_dir/$skill")" = "$skills_dir/$skill"
    cmp -s "$runtime_dir/$skill/SKILL.md" "$skills_dir/$skill/SKILL.md"
  done
done

test "$(readlink "${CODEX_HOME:-$HOME/.codex}/AGENTS.md")" = "$global_instructions"
test "$(readlink "$HOME/.claude/CLAUDE.md")" = "$global_instructions"
test "$(readlink "$prime_home/AGENTS.md")" = "$global_instructions"
cmp -s "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" "$global_instructions"
cmp -s "$HOME/.claude/CLAUDE.md" "$global_instructions"
cmp -s "$prime_home/AGENTS.md" "$global_instructions"

printf 'Claude Code, Codex, and Prime Agent use the shared skills and global instructions.\n'

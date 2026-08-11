#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"

for skill in multi-agent redpen power-law grill-me; do
  test -f "$skills_dir/$skill/SKILL.md"
  for runtime_dir in "$claude_dir" "$codex_dir"; do
    test -L "$runtime_dir/$skill"
    test "$(readlink "$runtime_dir/$skill")" = "$skills_dir/$skill"
    cmp -s "$runtime_dir/$skill/SKILL.md" "$skills_dir/$skill/SKILL.md"
  done
done

printf 'Claude Code and Codex use the shared agent-core source.\n'

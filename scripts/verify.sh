#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"

for skill in multi-agent redpen power-law grill-me; do
  test -f "$skills_dir/$skill/SKILL.md"
  test -L "$codex_dir/$skill"
  test "$(readlink "$codex_dir/$skill")" = "$skills_dir/$skill"
  cmp -s "$codex_dir/$skill/SKILL.md" "$skills_dir/$skill/SKILL.md"
done

if command -v claude >/dev/null 2>&1; then
  claude plugin list 2>/dev/null | grep -Fq 'agent-core@rohan-agent-setup'
fi

printf 'Claude Code and Codex use the shared agent-core source.\n'

#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"

mkdir -p "$codex_dir"

for skill in multi-agent redpen power-law grill-me; do
  source_path="$skills_dir/$skill"
  target_path="$codex_dir/$skill"

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    continue
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked Codex skill %s\n' "$skill"
done

if command -v claude >/dev/null 2>&1; then
  if ! claude plugin marketplace list 2>/dev/null | grep -Fq "$repo_dir"; then
    claude plugin marketplace add "$repo_dir"
  fi
  if ! claude plugin list 2>/dev/null | grep -Fq 'agent-core@rohan-agent-setup'; then
    claude plugin install agent-core@rohan-agent-setup
  fi
else
  printf 'Claude Code is not installed; skipped its plugin install.\n'
fi

"$repo_dir/scripts/verify.sh"

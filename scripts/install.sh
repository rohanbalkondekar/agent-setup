#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"

mkdir -p "$codex_dir" "$claude_dir"

link_skill() {
  target_dir=$1
  skill=$2
  source_path="$skills_dir/$skill"
  target_path="$target_dir/$skill"

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked %s\n' "$target_path"
}

for skill in multi-agent redpen power-law grill-me; do
  link_skill "$claude_dir" "$skill"
  link_skill "$codex_dir" "$skill"
done

"$repo_dir/scripts/verify.sh"

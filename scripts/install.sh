#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"
prime_home="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
prime_dir="$prime_home/skills"
global_instructions="$repo_dir/profiles/base/AGENTS.md"

mkdir -p "$codex_dir" "$claude_dir" "$prime_dir"

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
  link_skill "$prime_dir" "$skill"
done

link_global() {
  target_path=$1

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$global_instructions" ]]; then
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$global_instructions" "$target_path"
  printf 'Linked global instructions at %s\n' "$target_path"
}

link_global "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
link_global "$HOME/.claude/CLAUDE.md"
link_global "$prime_home/AGENTS.md"

"$repo_dir/scripts/verify.sh"

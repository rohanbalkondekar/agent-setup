#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

usage() {
  printf 'Usage: %s <personal|outsight|work> <target-directory>\n' "$0" >&2
  exit 2
}

test "$#" -eq 2 || usage
profile=$1
target_dir=$2
profile_file="$repo_dir/profiles/$profile/AGENTS.md"

case "$profile" in
  personal|outsight|work) ;;
  *) usage ;;
esac

test -f "$profile_file"
mkdir -p "$target_dir"

agents_file="$target_dir/AGENTS.md"
claude_file="$target_dir/CLAUDE.md"

if [[ ! -e "$agents_file" && ! -L "$agents_file" ]]; then
  ln -s "$profile_file" "$agents_file"
  printf 'Linked %s profile at %s\n' "$profile" "$agents_file"
else
  printf 'Preserved existing %s\n' "$agents_file"
fi

if [[ ! -e "$claude_file" && ! -L "$claude_file" ]]; then
  ln -s "$agents_file" "$claude_file"
  printf 'Linked Claude Code to %s\n' "$agents_file"
else
  printf 'Preserved existing %s\n' "$claude_file"
fi

test -s "$agents_file"
test -s "$claude_file"

#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s <instructions-file> <target-directory>\n' "$0" >&2
  exit 2
}

test "$#" -eq 2 || usage
profile_file=$1
target_dir=$2

if [[ ! -f "$profile_file" || ! -s "$profile_file" ]]; then
  printf 'Instructions must be a non-empty file: %s\n' "$profile_file" >&2
  exit 1
fi
# Absolute links work when the source was supplied relative to the caller.
profile_file="$(CDPATH= cd -- "$(dirname -- "$profile_file")" && pwd)/$(basename -- "$profile_file")"

mkdir -p "$target_dir"
target_dir="$(CDPATH= cd -- "$target_dir" && pwd)"

agents_file="$target_dir/AGENTS.md"
claude_file="$target_dir/CLAUDE.md"

# Diagnose unusable existing instructions before creating either link.
for file in "$agents_file" "$claude_file"; do
  if [[ -e "$file" || -L "$file" ]] && [[ ! -f "$file" || ! -s "$file" ]]; then
    printf 'Existing instructions are empty, invalid, or dangling: %s. Restore the file or repoint its link, then rerun.\n' "$file" >&2
    exit 1
  fi
done

if [[ ! -e "$agents_file" && ! -L "$agents_file" ]]; then
  ln -s "$profile_file" "$agents_file"
  printf 'Linked %s to %s\n' "$agents_file" "$profile_file"
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

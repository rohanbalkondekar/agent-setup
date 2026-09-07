#!/usr/bin/env bash
set -euo pipefail
set -f # Treat configured names literally, including wildcard characters.
trap 'printf "Verification failed at line %s: %s\n" "$LINENO" "$BASH_COMMAND" >&2' ERR

source "$(dirname -- "$0")/settings.sh"

for skill in $skills; do
  test -f "$skills_dir/$skill/SKILL.md"
  for runtime_dir in "${skill_dirs[@]}"; do
    test -L "$runtime_dir/$skill"
    test "$(readlink "$runtime_dir/$skill")" = "$skills_dir/$skill"
  done
done

if [[ "$global_mode" != 0 ]]; then
  for file in "${instruction_files[@]}"; do
    test -f "$file"
    test -s "$file"
    test -r "$file"
    if [[ "$global_mode" == 1 ]]; then
      test "$(readlink "$file")" = "$global_instructions"
    fi
  done
fi

printf 'Selected skill links verified for Claude Code, Codex, and Prime Agent (global instruction mode: %s).\n' "$global_mode"

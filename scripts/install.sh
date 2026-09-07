#!/usr/bin/env bash
set -euo pipefail
set -f # Treat configured names literally, including wildcard characters.

source "$(dirname -- "$0")/settings.sh"
mkdir -p "${skill_dirs[@]}"

link_file() {
  local source_path=$1 target_path=$2 backup_path
  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    return
  fi
  if [[ -e "$target_path" || -L "$target_path" ]]; then
    backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S).$$"
    mv "$target_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$target_path" "$backup_path"
  fi
  ln -s "$source_path" "$target_path"
  printf 'Linked %s\n' "$target_path"
}

for legacy in multi-agent power-law grill-me; do
  for dir in "${skill_dirs[@]}"; do
    if [[ -L "$dir/$legacy" ]]; then
      case "$(readlink "$dir/$legacy")" in
        "$skills_dir/"*)
          rm "$dir/$legacy"
          printf 'Removed legacy link %s\n' "$dir/$legacy" ;;
      esac
    fi
  done
done

for skill in $skills; do
  for dir in "${skill_dirs[@]}"; do
    link_file "$skills_dir/$skill" "$dir/$skill"
  done
done

# Preserve valid private instructions by default. Replacement is explicit.
if [[ "$global_mode" != 0 ]]; then
  for file in "${instruction_files[@]}"; do
    if [[ "$global_mode" == auto && -e "$file" ]]; then
      printf 'Preserved existing %s\n' "$file"
    else
      link_file "$global_instructions" "$file"
    fi
  done
fi

# Third-party plugins installed from their own marketplaces, not vendored here,
# so they keep updating from upstream. Best-effort: skip quietly if the CLI is
# missing or the plugin is already installed.
plugins="${AGENT_SETUP_PLUGINS-}"

for entry in $plugins; do
  marketplace="${entry%%=*}"
  plugin="${entry#*=}"
  if command -v claude >/dev/null 2>&1; then
    claude plugin marketplace add "$marketplace" >/dev/null 2>&1 || true
    claude plugin install "$plugin" >/dev/null 2>&1 || true
  fi
  if command -v codex >/dev/null 2>&1; then
    codex plugin marketplace add "$marketplace" >/dev/null 2>&1 || true
    codex plugin add "$plugin" >/dev/null 2>&1 || true
  fi
  printf 'Plugin %s: install attempted for available CLIs\n' "$plugin"
done

"$repo_dir/scripts/verify.sh"

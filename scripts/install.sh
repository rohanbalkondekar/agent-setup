#!/usr/bin/env bash
set -euo pipefail
set -f # Treat configured names literally, including wildcard characters.

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skills_dir="$repo_dir/plugins/core/skills"
codex_dir="${CODEX_HOME:-$HOME/.codex}/skills"
claude_dir="$HOME/.claude/skills"
prime_home="${PRIME_AGENT_CODING_AGENT_DIR:-$HOME/.prime/agent}"
prime_dir="$prime_home/skills"
global_instructions="$repo_dir/profiles/base/AGENTS.md"

skills="${AGENT_SETUP_SKILLS:-multiagent redpen powerlaw grillme prove-it show-me-your-work wizard blast-radius}"

# Validate the whole selection before changing any installed files.
for skill in $skills; do
  case "$skill" in
    *[!a-z0-9-]*|-*) printf 'Invalid skill name: %s\n' "$skill" >&2; exit 1 ;;
  esac
  if [[ ! -f "$skills_dir/$skill/SKILL.md" ]]; then
    printf 'Skill not found: %s\n' "$skill" >&2
    exit 1
  fi
done

mkdir -p "$codex_dir" "$claude_dir" "$prime_dir"

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
  for dir in "$claude_dir" "$codex_dir" "$prime_dir"; do
    if [[ -L "$dir/$legacy" ]]; then
      rm "$dir/$legacy"
      printf 'Removed legacy link %s\n' "$dir/$legacy"
    fi
  done
done

for skill in $skills; do
  for dir in "$claude_dir" "$codex_dir" "$prime_dir"; do
    link_file "$skills_dir/$skill" "$dir/$skill"
  done
done

# Set AGENT_SETUP_GLOBAL=0 on machines that keep a private CLAUDE.md/AGENTS.md
# instead of linking the shared base.
if [[ "${AGENT_SETUP_GLOBAL:-1}" == "1" ]]; then
  link_file "$global_instructions" "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
  link_file "$global_instructions" "$HOME/.claude/CLAUDE.md"
  link_file "$global_instructions" "$prime_home/AGENTS.md"
fi

# Third-party plugins installed from their own marketplaces, not vendored here,
# so they keep updating from upstream. Best-effort: skip quietly if the CLI is
# missing or the plugin is already installed.
plugins="${AGENT_SETUP_PLUGINS-DietrichGebert/ponytail=ponytail@ponytail}"

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

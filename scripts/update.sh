#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

if [[ -n "$(git -C "$repo_dir" status --porcelain)" ]]; then
  printf 'Update stopped: review and commit or stash local changes first.\n' >&2
  exit 1
fi

git -C "$repo_dir" pull --ff-only
"$repo_dir/scripts/install.sh"

printf 'Agent setup is current. Restart active agent sessions to reload instructions.\n'

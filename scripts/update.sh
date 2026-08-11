#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

git -C "$repo_dir" pull --ff-only
"$repo_dir/scripts/install.sh"

printf 'Agent setup is current. Restart active agent sessions to reload instructions.\n'

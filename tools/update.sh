#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

say() { printf '%s\n' "$*"; }

main() {
  if [[ ! -d "${REPO_ROOT}/.git" ]]; then
    say "[skip] not a git checkout: ${REPO_ROOT}"
    exit 0
  fi
  if ! command -v git >/dev/null 2>&1; then
    say "[skip] git not found"
    exit 0
  fi
  say "[git] fetch --all --prune"
  (cd "${REPO_ROOT}" && git fetch --all --prune)
  say "[git] pull --rebase --autostash"
  (cd "${REPO_ROOT}" && git pull --rebase --autostash)
  say "Done."
}

main "$@"

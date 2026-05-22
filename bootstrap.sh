#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [--help]

Install dotfiles by linking repository files into $HOME.

This wrapper delegates to tools/bootstrap.sh. Existing targets are backed up as
.bakN before links are created.
EOF
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
  "")
    ;;
  *)
    printf 'Unknown option: %s\n\n' "$1" >&2
    usage >&2
    exit 2
    ;;
esac

exec bash "${SCRIPT_DIR}/tools/bootstrap.sh"

#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
HOME_DIR="${HOME}"

say() { printf '%s\n' "$*"; }

usage() {
  cat <<'EOF'
Usage: ./tools/bootstrap.sh [--help]

Install dotfiles by linking repository files into $HOME.

Existing targets are backed up as .bakN before links are created. No config
files are copied.
EOF
}

backup_if_exists() {
  local dst="$1"
  if [[ -L "$dst" || -e "$dst" ]]; then
    local n=0
    local bak="${dst}.bak${n}"
    while [[ -e "$bak" || -L "$bak" ]]; do
      n=$((n+1))
      bak="${dst}.bak${n}"
    done
    say "[backup] $dst -> $bak"
    mv -- "$dst" "$bak"
  fi
}

link_item() {
  local src="$1"
  local dst="$2"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    say "[skip] missing in repo: ${src#${REPO_ROOT}/}"
    return 0
  fi

  mkdir -p -- "$(dirname -- "$dst")"

  if [[ -L "$dst" ]]; then
    local cur
    cur="$(readlink -- "$dst" || true)"
    if [[ "$cur" == "$src" ]]; then
      say "[skip] already linked: $dst"
      return 0
    fi
  fi

  backup_if_exists "$dst"
  ln -s -- "$src" "$dst"
  say "[link] $dst -> $src"
}

install_home_links() {
  link_item "${REPO_ROOT}/.vimrc"           "${HOME_DIR}/.vimrc"
  link_item "${REPO_ROOT}/.gvimrc"          "${HOME_DIR}/.gvimrc"
  link_item "${REPO_ROOT}/.gitconfig"       "${HOME_DIR}/.gitconfig"
  link_item "${REPO_ROOT}/.gitignore"       "${HOME_DIR}/.gitignore"
  link_item "${REPO_ROOT}/.tigrc"           "${HOME_DIR}/.tigrc"
  link_item "${REPO_ROOT}/.tmux.conf"       "${HOME_DIR}/.tmux.conf"
  link_item "${REPO_ROOT}/.tmux-theme.conf" "${HOME_DIR}/.tmux-theme.conf"
  link_item "${REPO_ROOT}/.vim"             "${HOME_DIR}/.vim"
}

install_xdg_config() {
  local cfg_dir="${REPO_ROOT}/config"
  if [[ -d "$cfg_dir" ]]; then
    mkdir -p -- "${HOME_DIR}/.config"
    shopt -s nullglob
    for child in "${cfg_dir}"/*; do
      local name
      name="$(basename -- "$child")"
      link_item "$child" "${HOME_DIR}/.config/${name}"
    done
    shopt -u nullglob
  fi
}

main() {
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

  say "[info] repo: ${REPO_ROOT}"
  say "[info] home: ${HOME_DIR}"
  install_home_links
  install_xdg_config
  say "Done."
}

main "$@"

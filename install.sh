#!/usr/bin/env bash
set -e

# 获取仓库根目录的绝对路径（若通过 curl 运行则可能不是仓库目录）
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
IS_WSL=0

if [[ "${OS}" == Linux* ]]; then
    if [[ -r /proc/sys/kernel/osrelease ]] && grep -qi microsoft /proc/sys/kernel/osrelease; then
        IS_WSL=1
    elif [[ -r /proc/version ]] && grep -qi microsoft /proc/version; then
        IS_WSL=1
    fi
fi

echo "Detected OS: ${OS}"
if [[ "${IS_WSL}" -eq 1 ]]; then
    echo "Detected environment: WSL"
fi

if [[ ! -f "${REPO_ROOT}/tools/bootstrap.sh" ]]; then
    if command -v git >/dev/null 2>&1; then
        TARGET_DIR="${HOME}/dotfiles"
        echo "Repo not found at ${REPO_ROOT}, cloning into ${TARGET_DIR}..."
        if [[ ! -d "${TARGET_DIR}/.git" ]]; then
            git clone https://github.com/killua525/dotfiles.git "${TARGET_DIR}"
        fi
        REPO_ROOT="${TARGET_DIR}"
    else
        echo "Error: git not found. Please install git or clone the repo manually."
        exit 1
    fi
fi

case "${OS}" in
    Linux*|Darwin*)
        # macOS / Linux / WSL 环境
        bash "${REPO_ROOT}/tools/bootstrap.sh" "$@"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        # Windows (Git Bash) 环境
        if command -v powershell.exe >/dev/null 2>&1; then
            echo "Running Windows setup script..."
            # 将 POSIX 路径转换为 Windows 路径，以便 PowerShell 识别
            if command -v cygpath >/dev/null 2>&1; then
                WIN_REPO_ROOT=$(cygpath -w "${REPO_ROOT}")
            else
                WIN_REPO_ROOT="${REPO_ROOT}"
            fi
            powershell.exe -ExecutionPolicy Bypass -File "${REPO_ROOT}/tools/windows/setup.ps1" -RepoDir "${WIN_REPO_ROOT}"
        else
            echo "Error: powershell.exe not found. Please install PowerShell."
            exit 1
        fi
        ;;
    *)
        echo "Unsupported OS: ${OS}. Please run setup scripts manually."
        exit 1
        ;;
esac
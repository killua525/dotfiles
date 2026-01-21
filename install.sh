#!/usr/bin/env bash
set -e

# 获取仓库根目录的绝对路径
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

echo "Detected OS: ${OS}"

case "${OS}" in
    Linux*|Darwin*)
        # macOS / Linux 环境
        bash "${REPO_ROOT}/bootstrap.sh" "$@"
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
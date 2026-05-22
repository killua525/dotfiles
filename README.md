# My Dotfiles

Personal development environment configurations for macOS, Linux, WSL2, and
Windows.

## Features

- Cross-platform setup for macOS, Linux, WSL2, and Windows.
- Vim, Neovim, MacVim, and gVim runtime configuration and plugins.
- Git, tig, and tmux configuration.
- Selected XDG config files, including `kube-ps1`.

## Quick install

The top-level `install.sh` detects the platform and delegates to the matching
setup script.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/killua525/dotfiles/master/install.sh)"
```

## Manual install

The current macOS/Linux/WSL2 installer links files from this repository into
your home directory and backs up existing targets as `.bakN` before replacing
them.

```bash
git clone https://github.com/killua525/dotfiles.git ~/dotfiles
cd ~/dotfiles
./tools/bootstrap.sh
```

To update an existing checkout:

```bash
cd ~/dotfiles
./tools/update.sh
```

## Structure

- `~/.dotfiles` or `~/dotfiles`: the repository checkout.
- `install.sh`: platform dispatcher for macOS, Linux, WSL2, and Windows Git Bash.
- `tools/`: installation and update scripts.
- `tools/windows/`: Windows Vim/gVim entry files and PowerShell setup script.
- `config/`: XDG configuration files linked into `~/.config`.
- `config/nvim/init.vim`: Neovim entry point that reuses the shared Vim config.
- `.vim/`: Vim runtime configuration.
- `.vimrc` / `.gvimrc`: terminal Vim and GUI Vim entry points.

See [CROSS_PLATFORM.md](CROSS_PLATFORM.md) for full setup details.

## Legacy installer

The top-level `bootstrap.sh` is the older rsync-based installer. Prefer
`tools/bootstrap.sh` for new macOS/Linux/WSL2 setups because it creates
symlinks instead of copying files into `$HOME`.

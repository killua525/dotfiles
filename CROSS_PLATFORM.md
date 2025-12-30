# Cross-platform bootstrap (macOS / Linux / Windows)

Repo notes:
* `.vim/` is **Vim runtime/config directory** (unrelated to tig).
* tig uses `.tigrc` in your HOME.

This repo provides cross-platform bootstrap scripts:

* macOS/Linux: `tools/bootstrap.sh` (install/link) + `tools/update.sh` (git update)
* Windows (gVim): `tools/windows/setup.ps1` + `tools/windows/_vimrc` + `tools/windows/_gvimrc`

## What will be installed (macOS/Linux)

Symlinks into `$HOME` (only if the source exists in repo root):

* `.gitconfig`         -> `~/.gitconfig`
* `.gitignore`         -> `~/.gitignore`
* `.tigrc`             -> `~/.tigrc`
* `.tmux.conf`         -> `~/.tmux.conf`
* `.tmux-theme.conf`   -> `~/.tmux-theme.conf`
* `.vim`               -> `~/.vim`

If a `config/` directory exists in repo root:

* `config/<name>`      -> `~/.config/<name>`

## What will be installed (Windows + gVim)

* Repo `.vim` directory -> `%USERPROFILE%\vimfiles` (link if possible; otherwise copy)
* `tools/windows/_vimrc`  -> `%USERPROFILE%\_vimrc`
* `tools/windows/_gvimrc` -> `%USERPROFILE%\_gvimrc`
* `.gitconfig` -> `%USERPROFILE%\.gitconfig` (Git for Windows reads it)
* `.gitignore` -> `%USERPROFILE%\.gitignore`
* `.tigrc`     -> `%USERPROFILE%\.tigrc` (useful if you run tig under MSYS2/Git Bash)

## Usage

### macOS/Linux

```bash
git clone https://github.com/killua525/dotfiles.git ~/dotfiles
cd ~/dotfiles
./tools/update.sh
./tools/bootstrap.sh


# Cross-platform bootstrap

Repo notes:

* `.vim/` is the shared Vim runtime/config directory.
* `.vimrc`, `.gvimrc`, and `config/nvim/init.vim` are entry points for Vim,
  MacVim/gVim, and Neovim.
* tig uses `.tigrc` in your home directory.
* WSL2 uses the Linux setup path.
* The top-level `bootstrap.sh` is the older rsync-based installer. Prefer
  `tools/bootstrap.sh` for new macOS/Linux/WSL2 setups.

This repo provides cross-platform bootstrap scripts:

* macOS/Linux/WSL2: `tools/bootstrap.sh` (install/link) + `tools/update.sh` (git update)
* Windows (gVim): `tools/windows/setup.ps1` + `tools/windows/_vimrc` + `tools/windows/_gvimrc`
* Git Bash dispatcher: `install.sh`

## What will be installed (macOS/Linux/WSL2)

`tools/bootstrap.sh` creates symlinks into `$HOME` and backs up existing
targets as `.bakN` before replacing them.

Home-directory links:

* `.vimrc`            -> `~/.vimrc`
* `.gvimrc`           -> `~/.gvimrc`
* `.gitconfig`         -> `~/.gitconfig`
* `.gitignore`         -> `~/.gitignore`
* `.tigrc`             -> `~/.tigrc`
* `.tmux.conf`         -> `~/.tmux.conf`
* `.tmux-theme.conf`   -> `~/.tmux-theme.conf`
* `.vim/`              -> `~/.vim`

XDG config links:

* `config/*`           -> `~/.config/*`

This includes `config/nvim/init.vim`, so Neovim loads the same shared config
through `~/.config/nvim/init.vim`.

Shell startup files such as `.bash_profile`, `.aliases`, `.exports`, and
`.functions` are kept in the repository but are not linked by
`tools/bootstrap.sh`.

## What will be installed (Windows + gVim)

`tools/windows/setup.ps1` updates the checkout, then links files where possible
and falls back to copying when Windows does not allow link creation.

* Repo `.vim` directory -> `%USERPROFILE%\vimfiles`
* `tools/windows/_vimrc`  -> `%USERPROFILE%\_vimrc`
* `tools/windows/_gvimrc` -> `%USERPROFILE%\_gvimrc`
* `config\nvim` -> `%LOCALAPPDATA%\nvim`
* `.gitconfig` -> `%USERPROFILE%\.gitconfig` (Git for Windows reads it)
* `.gitignore` -> `%USERPROFILE%\.gitignore`
* `.tigrc`     -> `%USERPROFILE%\.tigrc` (useful if you run tig under MSYS2/Git Bash)

## Usage

### macOS/Linux/WSL2

```bash
git clone https://github.com/killua525/dotfiles.git ~/dotfiles
cd ~/dotfiles
./tools/update.sh
./tools/bootstrap.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/killua525/dotfiles.git $HOME\dotfiles
cd $HOME\dotfiles
powershell -ExecutionPolicy Bypass -File tools\windows\setup.ps1
```

### Git Bash dispatcher

```bash
./install.sh
```

## Update only

```bash
./tools/update.sh
```

## WSL2 notes

Run the Linux setup inside your WSL2 distribution. If you also want
Windows-native Vim/GVim settings, run the Windows setup script from a Windows
shell.

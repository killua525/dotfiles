
# My Dotfiles

My personal development environment configurations for macOS, Linux (including WSL2), and Windows.

![image](httpshttps://user-images.githubusercontent.com/19486826/152653219-b515e4f7-3b6b-4375-802c-471249e0573e.png)

## Features

- **Cross-Platform**: Works seamlessly on macOS, Linux (including WSL2), and Windows (via Git Bash).
- **Vim**: A powerful, customized Vim setup with YouCompleteMe for C++ and more.
- **Git & Tig**: Optimized Git configuration and Tig for repository browsing.
- **Shell**: Includes `kube-ps1` for clear Kubernetes context display in the prompt.

## Quick Install

Run the following command in your terminal. It will automatically clone the repository to `~/dotfiles` and start the setup process.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/killua525/dotfiles/master/install.sh)"
```

## Structure

- `~/.dotfiles`: The home for this repository.
- `tools/`: Contains all installation and management scripts.
- `config/`: Holds modular configurations for tools like `kube-ps1`.
- `tools/`: Contains platform-specific helper tools (e.g., for Windows).
- `gitconfig`, `gitignore`, `tigrc`, `tmux.conf`, `tmux-theme.conf`: Top-level configuration files.
- `.vim/`: All Vim-related configurations and plugins.

## WSL2

WSL2 is treated as Linux. Run the Linux setup inside your WSL2 distro:

```bash
git clone https://github.com/killua525/dotfiles.git ~/dotfiles
cd ~/dotfiles
./tools/update.sh
./tools/bootstrap.sh
```

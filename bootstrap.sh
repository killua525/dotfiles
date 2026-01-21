#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		--exclude "brew.sh" \
		--exclude "config" \
		--exclude ".vim" \  # Exclude .vim from general rsync, it will be symlinked
		-avh --no-perms . ~;

	# Link .vim directory to ~/.vim for plugins and other runtime files
	if [ -d ".vim" ]; then
		echo "Linking ~/.vim -> ${PWD}/.vim"
		rm -rf ~/.vim # Remove existing directory or symlink
		ln -s "${PWD}/.vim" ~/.vim
	fi

	# 同步 config 目录到 ~/.config (如果存在)
	if [ -d "config" ]; then
		mkdir -p ~/.config
		rsync -avh --no-perms config/ ~/.config/
	fi
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

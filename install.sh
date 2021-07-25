#!/bin/bash
# =====================================
# dotkula Install Script (install.sh)
# Author: Aubhro Sengupta (lorddarkula)
# Email: hello@aubhro.com
# Website: https://aubhro.me
# =====================================
# Options: --bash, --dev, --term

# Path Variables
# --------------

# Argument passed in
INSTALL_TYPE="$1"
# Path to dotkula
REPO_DIR=$(pwd)
# Path to .config
CONFIG_DIR="$HOME/.config"

# Paths to dotfile locations
BASHRC="$HOME/.bashrc"
BASH_PROFILE="$HOME/.bash_profile"
INPUTRC="$HOME/.inputrc"
VIMRC="$HOME/.vimrc"
TMUX_CONF="$HOME/.tmux.conf"

# Helper Functions
# ----------------

# Links configuration file to proper location
# Argumens:
# 	$1 - path of symlink to create
# 	$2 - path of file in git repo
create_link() {
	if [ -f "$1" ]; then
		echo "File $1 exists"
		echo "Moving $1 to $1.old"
		mv "$1" "$1.old"
	fi
	ln "$2" "$1"
}

install_bash() {
	create_link "$HOME/.bash_profile" "$REPO_DIR/bash/.bash_profile"
	create_link "$HOME/.bashrc" "$REPO_DIR/bash/.bashrc"
	create_link "$HOME/.inputrc" "$REPO_DIR/bash/.inputrc"
}

install_vim() {
	# install vim
	create_link "$HOME/.vimrc" "$REPO_DIR/vim/.vimrc"

	# install neovim
	mkdir -p "$CONFIG_DIR/nvim"
	create_link "$CONFIG_DIR/nvim/init.vim" "$REPO_DIR/nvim/init.vim"
}

install_tmux() {
	create_link "$HOME/.tmux.conf" "$REPO_DIR/tmux/.tmux.conf"
}

install_alacritty() {
	mkdir -p "$CONFIG_DIR/alacritty"
	create_link "$CONFIG_DIR/alacritty/alacritty.yml" "$REPO_DIR/alacritty/alacritty.yml"
}

install_zathura() {
	mkdir -p "$CONFIG_DIR/zathura"
	create_link "$CONFIG_DIR/zathura/zathurarc" "$REPO_DIR/zathura/zathurarc"
}

install_ranger() {
	mkdir -p "$CONFIG_DIR/ranger"
	create_link "$CONFIG_DIR/ranger/rc.conf" "$REPO_DIR/ranger/rc.conf"
	create_link "$CONFIG_DIR/ranger/rifle.conf" "$REPO_DIR/ranger/rifle.conf"
	create_link "$CONFIG_DIR/ranger/scope.sh" "$REPO_DIR/ranger/scope.sh"
}

# Installs config files needed for ssh workflow
if [ $INSTALL_TYPE = "--ssh" ]; then
	install_bash
	install_vim
	install_tmux
fi

if [ $INSTALL_TYPE = "--all" ]; then
	install_bash
	install_tmux
	install_vim
fi


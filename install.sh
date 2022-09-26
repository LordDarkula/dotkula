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
	echo "Bash config files installed"
}

install_zsh() {
	create_link "$HOME/.zshrc" "$REPO_DIR/zsh/.zshrc"
	create_link "$HOME/.zprofile" "$REPO_DIR/zsh/.zprofile"
	echo "Zsh config files installed"
}

install_vim() {
	create_link "$HOME/.vimrc" "$REPO_DIR/vim/.vimrc"
	echo "Vim config installed"
}

install_nvim() {
	# install neovim
	mkdir -p "$CONFIG_DIR/nvim"
	create_link "$CONFIG_DIR/nvim/init.vim" "$REPO_DIR/nvim/init.vim"

	echo "NeoVim config installed"
}

install_tmux() {
	create_link "$HOME/.tmux.conf" "$REPO_DIR/tmux/.tmux.conf"
	echo "Tmux conf installed"
}

install_alacritty() {
	mkdir -p "$CONFIG_DIR/alacritty"
	create_link "$CONFIG_DIR/alacritty/alacritty.yml" "$REPO_DIR/alacritty/alacritty.yml"
	echo "Alacritty yml installed"
}

install_zathura() {
	mkdir -p "$CONFIG_DIR/zathura"
	create_link "$CONFIG_DIR/zathura/zathurarc" "$REPO_DIR/zathura/zathurarc"
	echo "Zathura rc installed"
}

install_ranger() {
	mkdir -p "$CONFIG_DIR/ranger"
	create_link "$CONFIG_DIR/ranger/rc.conf" "$REPO_DIR/ranger/rc.conf"
	create_link "$CONFIG_DIR/ranger/rifle.conf" "$REPO_DIR/ranger/rifle.conf"
	create_link "$CONFIG_DIR/ranger/scope.sh" "$REPO_DIR/ranger/scope.sh"
	echo "Ranger config installed"
}

# Installs config files needed for ssh workflow
if [ $INSTALL_TYPE = "ssh" ]; then
	install_bash
	install_vim
	install_tmux
fi

# Installs config files for desktop
if [ $INSTALL_TYPE = "all" ]; then
	install_bash
	install_tmux
	install_vim
	install_nvim
	install_alacritty
	install_zathura
fi

# Install configs individually
if [ $INSTALL_TYPE = "bash" ]; then
	install_bash
fi

if [ $INSTALL_TYPE = "vim" ]; then
	install_vim
fi

if [ $INSTALL_TYPE = "nvim" ]; then
	install_nvim
fi

if [ $INSTALL_TYPE = "tmux" ]; then
	install_tmux
fi

if [ $INSTALL_TYPE = "zsh" ]; then
	install_zsh
fi

if [ $INSTALL_TYPE = "alacritty" ]; then
	install_alacritty
fi

if [ $INSTALL_TYPE = "zathura" ]; then
	install_zathura
fi


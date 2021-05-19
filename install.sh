#!/bin/bash
# =====================================
# dotkula Install Script (install.sh)
# Author: Aubhro Sengupta (lorddarkula)
# Email: hello@aubhro.com
# Website: https://aubhro.me
# =====================================
# Options: --bash, --dev, --term

INSTALL_TYPE="$1"
REPO_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

# Paths to dotfile locations
BASHRC="$HOME/.bashrc"
BASH_PROFILE="$HOME/.bash_profile"
INPUTRC="$HOME/.inputrc"
VIMRC="$HOME/.vimrc"
TMUX_CONF="$HOME/.tmux.conf"

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

install_zathura() {
	mkdir -p "$CONFIG_DIR/zathura"
	create_link "$CONFIG_DIR/zathura/zathurarc" "$REPO_DIR/zathura/zathurarc"
}

install_alacritty() {
	mkdir -p "$CONFIG_DIR/alacritty"
	create_link "$CONFIG_DIR/alacritty/alacritty.yml" "$REPO_DIR/alacritty/alacritty.yml"
}

install_ranger() {
	mkdir -p "$CONFIG_DIR/ranger"
	create_link "$CONFIG_DIR/ranger/rc.conf" "$REPO_DIR/ranger/rc.conf"
	create_link "$CONFIG_DIR/ranger/rifle.conf" "$REPO_DIR/ranger/rifle.conf"
	create_link "$CONFIG_DIR/ranger/scope.sh" "$REPO_DIR/ranger/scope.sh"
}

# Installs ranger and alacritty configuration files
RANGER_DIR="$HOME/.config/ranger"
ALACRITTY_DIR="$HOME/.config/alacritty"
if [ $INSTALL_TYPE = "--term" ]; then
	mkdir -p "$RANGER_DIR"
	if [ -f "$RANGER_DIR/rc.conf" ]; then
		echo "rc.conf exists"
		echo "Moving rc.conf to rc.conf.old"
		mv "$RANGER_DIR/rc.conf" "$RANGER_DIR/rc.conf.old"
	fi
	if [ -f "$RANGER_DIR/rifle.conf" ]; then
		echo "rifle.conf exists"
		echo "Moving rifle.conf to rifle.conf.old"
		mv "$RANGER_DIR/rifle.conf" "$RANGER_DIR/rifle.conf.old"
	fi
	if [ -f "$RANGER_DIR/scope.sh" ]; then
		echo "scope.sh exists"
		echo "Moving scope.sh to scope.sh.old"
		mv "$RANGER_DIR/scope.sh" "$RANGER_DIR/scope.sh.old"
	fi
	ln "$PROJECT_DIR/ranger/rc.conf"	"$RANGER_DIR/rc.conf"
	ln "$PROJECT_DIR/ranger/rifle.conf"	"$RANGER_DIR/rifle.conf"
	ln "$PROJECT_DIR/ranger/scope.sh"	"$RANGER_DIR/scope.sh"

	mkdir -p "$ALACRITTY_DIR"
	if [ -f "$ALACRITTY_YML" ]; then
		echo "alacritty.yml exists"
		echo "Moving alacritty.yml to alacritty.yml.old"
		mv "$ALACRITTY_DIR/alacritty.yml" "$ALACRITTY_DIR/alacritty.yml.old"
	fi
	ln "$PROJECT_DIR/alacritty/alacritty.yml" "$ALACRITTY_DIR/alacritty.yml"
fi


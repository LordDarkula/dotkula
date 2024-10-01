# =====================================
# Bash Configuration
# Author: Aubhro Sengupta (lorddarkula)
# Email: hello@aubhro.com
# Website: https://aubhro.me
# =====================================


# Basic Options
# -------------

# add color
if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
  force_color_prompt=yes
elif [[ "$OSTYPE" = *"darwin"* ]]; then
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
fi

# SSH Keys
if [ -d "$HOME/.ssh" ]; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
  ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
  ssh-add ~/.ssh/id_rsa_gatech > /dev/null 2>&1
fi

# set default text editor to vim
export EDITOR=/usr/bin/vim
# enable vi mode in bash
set -o vi

# Prompt
# ------

# git branch display
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# timer display
function timer_start {
  timer=${timer:-$SECONDS}
}
function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}
trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

if [[ $- == *i* ]]; then

  # primary prompt
  PS1=""
  PS1+="\[$(tput bold)\]";	# bolds prompt
  PS1+="\[$(tput setaf 202)\]"
  PS1+="\[\u\] "	# user
  PS1+="\[$(tput setaf 208)\]"
  PS1+="\[\h\] "	# host
  PS1+="\[$(tput setaf 214)\]"
  PS1+="\[(\s \v)\n\]"	# shell and version
  PS1+="\[$(tput setaf 165)\]"
  PS1+='[last: ${timer_show}s] '	# prev command exec time
  PS1+="\[$(tput setaf 171)\]"
  PS1+="\[\w/\]" #	current working directory
  PS1+="\[$(tput setaf 177)\]"
  PS1+="\[\$(parse_git_branch)\]" #	current git branch
  PS1+="\[$(tput sgr0)\]"
  PS1+="\n\[$(tput bold)\]λ\[$(tput sgr0)\] "
  export PS1

  # secondary prompt
  export PS2="\[$(tput bold)\](continue typing) $\[$(tput sgr0)\] "
fi


# Paths
# -----

# system
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

# miniconda
if [ -d "$HOME/miniconda" ]; then
  export PATH="$HOME/miniconda/bin:$PATH"
fi

# GOPATH
export GOPATH="$HOME/Workspaces/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"

# jenv
if [ -d "$HOME/.jenv" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
fi


# rustup
if [ -d "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# tcl-tk
if [ -d "/usr/local/opt/tcl-tk" ]; then
  export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"
  export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"
  export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

# icu4c
if [ -d "/usr/local/opt/icu4c/bin" ]; then
  export PATH="/usr/local/opt/icu4c/bin:$PATH"
  export PATH="/usr/local/opt/icu4c/sbin:$PATH"
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"
fi

# CUDA Toolkit
if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
  export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
  export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64
fi

# Shims
if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if which rbenv >  /dev/null 2>&1;  then
  eval "$(rbenv init -)"
fi
if which jenv > /dev/null 2>&1; then
  eval "$(jenv init -)"
fi

# Environment Variables and Aliases
# ---------------------------------

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

alias c='clear'
alias u='upgrade'
alias la='ls -la'
alias mkdir='mkdir -pv'
alias r='ranger'
alias cp='cp -iv'
alias mv='mv -iv'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'
alias ll='ls -FGlAhp'
alias less='less -FSRXc'
alias refresh='exec $SHELL'

# cd modifiers
# Go back 1 directory level
alias cd..='cd ../'
# Go back 2 directory levels
alias cd...='cd ../../'
# Go back 3 directory levels
alias cd....='cd ../../../'



# Functions
# ---------

# Reassign ls to ls -a for additional information about files
ls() {
	if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
		/bin/ls -a --color=auto "$@"
	elif [[ "$OSTYPE" = *"darwin"* ]]; then
		/bin/ls -a "$@"
	fi
}

# Reassign cd to display new working directory after switching
cd() {
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		builtin cd "$@"; /bin/ls --color=auto
	elif [[ "$OSTYPE" =~ "darwin" ]]; then
		builtin cd "$@"; /bin/ls
	fi
}

# Upgrade package managers
upgrade() {
  if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
    echo "Updating apt..."
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    echo "Updating snaps..."
    sudo snap refresh
    sudo apt full-upgrade
  elif [[ "$OSTYPE" =~ "darwin" ]]; then
    echo "Updating homebrew..."
    brew update
    brew upgrade
  fi
}

#   File and process management
#   ----------------------------------------------------------------------------

# Zip recursively
zipf () {
    zip -r "$1".zip "$1" ;
}

# Extract most packages with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Move a file to the trash
trash () {
    if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
        command mv "$@" $HOME/.local/share/Trash
    else
        command mv "$@" ~/.Trash
    fi

}

# List all active processes
myps() {
    ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ;
}

#   Networking
#   ----------------------------------------------------------------------------

# Disply local ip
localip() {
    if [[ "$OSTYPE" = *"linux-gnu"* ]]; then
        ipString="$(hostname -I)"
        ipArray=($ipString)
        echo $ipArray
    elif [[ "$OSTYPE" = *"darwin"* ]]; then
        ipString="$(ifconfig | grep "inet " | grep -v 127.0.0.1)"
        ipArray=($ipString)
        echo ${ipArray[1]}
    fi
}

# Display Public facing IP Address
publicip() {
    curl ifconfig.me
}

# Display useful host related informaton
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    # echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo "The network is up"
    else
        echo "The network is down"
    fi
}

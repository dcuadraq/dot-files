# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# set bash to Vi mode
set -o vi

# sets nvim as editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export DOTFILESDIR="$HOME/workspaces/dot-files"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Git autocomplete
source ~/git-completion.bash
# For homebrew
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
# . $(brew --prefix)/etc/bash_completion
# fi

# #####################
# BASH HISTORY
# #####################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=40000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# #####################
# BASH HISTORY END
# #####################


# #####################
# BASH ALIASES
# #####################
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "$DOTFILESDIR/.bash_aliases" ]; then
  source "$DOTFILESDIR/.bash_aliases"
fi


# #####################
# BASH FUNCTIONS
# #####################
if [ -f "$DOTFILESDIR/.functions" ]; then
  source "$DOTFILESDIR/.functions"
fi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# #####################
# BASH PROMPT
# #####################

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# #####################
# BASH PROMPT END
# #####################

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# #####################
# BASH PATH
# #####################
# Ruby
## rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
#
# #####################
# BASH PATH END
# #####################

# nvm
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

# Git Branch
source $DOTFILESDIR/git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\n$ '

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
 local git_status="$(git status 2> /dev/null)"

 if [[ ! $git_status =~ "working directory clean" ]]; then
   echo -e $COLOR_RED
 elif [[ $git_status =~ "Your branch is ahead of" ]]; then
   echo -e $COLOR_YELLOW
 elif [[ $git_status =~ "nothing to commit" ]]; then
   echo -e $COLOR_GREEN
 else
   echo -e $COLOR_OCHRE
 fi
}

function git_branch {
 local git_status="$(git status 2> /dev/null)"
 local on_branch="On branch ([^${IFS}]*)"
 local on_commit="HEAD detached at ([^${IFS}]*)"

 if [[ $git_status =~ $on_branch ]]; then
   local branch=${BASH_REMATCH[1]}
   echo "($branch)"
 elif [[ $git_status =~ $on_commit ]]; then
   local commit=${BASH_REMATCH[1]}
   echo "($commit)"
 fi
}

function prompt_for_user {
  if [[ "$(id -u)" == "0" ]]; then
    local prompt="#"
  else
    local prompt="$"
  fi
  echo "$prompt"
}

# Bash prompt
# cuadra@t14sG6: ~/workspaces/dot-files (master)
# 21:00:41 $
# export prompt_if_sudo='`[ $(id -u) == "0" ] && echo "#" || echo ">"` '
export PS1="\[\e[01;32m\]\u\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[01;31m\]\h\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\$(git_color)\]\$(git_branch)\[\033[0m\]\n\[\$(date +%H:%M:%S)\] \[\$(prompt_for_user)\] "
export CLICOLOR=1

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
# export PATH="$(brew --prefix qt@5.5)/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# zoxide
eval "$(zoxide init bash)"

# asdf
# . /opt/asdf-vm/asdf.sh
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. <(asdf completion bash)

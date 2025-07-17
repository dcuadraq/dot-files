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
HISTSIZE=-1
HISTFILESIZE=80000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


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

# #####################
# BASH PROMPT
# #####################
if [ -f "$DOTFILESDIR/.bash_prompt" ]; then
  source "$DOTFILESDIR/.bash_prompt"
fi
# #####################
# END BASH PROMPT
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

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# set bash to Vi mode
set -o vi

# sets nvim as editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# All terminal sessions share the same history instead of overwritting
# shopt -s histappend # TODO not working

# Homebrew autocomplete for git
source ~/git-completion.bash
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias trim='sudo fstrim -v /'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# My functions
function rails_pid() {
  # kill - 9 PID
  lsof -wni tcp:3000
}

# Git Branch
source ~/.git-prompt.sh
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

export PS1="\[\e[01;32m\]\h\[\e[0m\]\[\e[01;37m\]@\[\e[0m\]\[\e[01;31m\]\u\[\e[0m\]\[\e[01;37m\]:\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\$(git_color)\]\$(git_branch)\[\033[0m\]\n$ "
export CLICOLOR=1

# Aliases
alias refresh='source ~/.bash_profile'

## Rails dev aliases
alias be='bundle exec'
alias tbe='time bundle exec'
alias br='bin/rails'
alias brt='bin/rails test'
alias brc='bin/rails console'
alias brs='bin/rails server'

## Git alias
alias gs='git status'
alias glog='git log --oneline --graph --decorate --date=relative --all'
alias gd='git diff'
alias gf='git fetch origin master'
alias gfm='git fetch origin master:master'
alias gc='git checkout -'
alias gpush='git push origin HEAD'
alias gpushf='git push origin HEAD --force-with-lease'
alias gpull='git pull origin HEAD'
alias gfiles='git diff-tree --no-commit-id --name-only -r'
alias gmine='git log --since "1 week ago" --until "tomorrow" --author="David Cuadra"'
alias gdm='git diff --name-only master'
alias gundolast='git reset HEAD~'
alias gconflictfiles='git diff --name-only --diff-filter=U'
# git hash at the end
alias gfiles="git diff-tree --no-commit-id --name-only -r"
alias gauthors="git log --format='%aN' | sort -u"
### v Compares branches append master..branch at the end
alias glcb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "

# commits that modified a file
alias gcf='git log -- ' # PATH


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# tmux
function tmux_start {
  TMUX_DIRNAME=${1:-$(pwd)}
  if test "`dirname $1`" = "."; then
    if test "$1" = "."; then
      TMUX_DIRNAME=$(pwd)
    else
      TMUX_DIRNAME=$(pwd)/$1
    fi
  fi

  TMUX_APP=$(basename $TMUX_DIRNAME)
  tmux has-session -t $TMUX_APP 2>/dev/null
  if [ "$?" -eq 1 ] ; then
    echo "No Session found.  Creating and configuring."
    pushd $TMUX_DIRNAME
    tmux new-session -d -s $TMUX_APP
    popd
  else
    echo "Session found.  Connecting."
  fi
  tmux attach-session -t $TMUX_APP
}

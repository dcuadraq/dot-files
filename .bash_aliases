#!/bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='exa -la'
alias la='ls -A'
alias l='exa -a'

alias trim='sudo fstrim -v /'

# Handy Aliases
alias refresh='source ~/.bash_profile'
alias list_commands='compgen -c'
alias list_functions='compgen -A function'
alias rgf='rg --files | rg'

## Rails dev aliases
alias be='bundle exec'
alias tbe='time bundle exec'
alias br='bin/rails'
alias brt='bin/rails test'
alias brc='bin/rails console'
alias brs='bin/rails server'
alias nv='nvim +GFiles'
alias ctags_gen='ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=tmp . $(bundle list --paths)'

## Git alias
alias g='git'
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Overrides
alias cat="bat -p"
alias zz="z -"
alias cd="z"

alias file_space_usage="du -hsc *"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

##### Custom Mods #####
#
# custom aliases
alias emacs='emacs -nw'
alias untar='tar -zxvf'
alias wget='wget -c'
alias ping='ping -c 4'
alias l='ls -AlhF --color=auto'
alias c='clear'
alias mv='mv -v'
alias rm='rm -vi'
alias cp='cp -v'
alias d='du -sh'
alias grep='grep --color=auto -n'
alias vi='vim'
alias t='tree'

alias tn='tmux -2 new -s'
alias ta='tmux -2 a -t'
alias tl='tmux -2 ls'

alias sc='scrot ~/Pictures/screenshots/%Y-%m-%d-%T.png'

alias docker-clean-up='sudo docker rm $(sudo docker ps -a -f status=exited -q)
&& sudo docker rmi $(sudo docker images -f "dangling=true" -q)'

# enable bash-auto-complete
source /etc/profile.d/bash_completion.sh

# enable bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Single_line_Minimalist
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# set go paths
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/goworkspace

# show git status
# COLOR_RED="\033[0;31m"
# COLOR_YELLOW="\033[0;33m"
# COLOR_GREEN="\033[0;32m"
# COLOR_OCHRE="\033[0;38;5;95m"
# COLOR_BLUE="\033[0;34m"
# COLOR_WHITE="\033[0;37m"
# COLOR_RESET="\033[0;0m"
# 
# function git_color {
#     local git_status="$(git status 2> /dev/null)"
# 
#     if [[ ! $git_status =~ "working directory clean" ]]; then
#         echo -e $COLOR_RED
#     elif [[ $git_status =~ "Your branch is ahead of" ]]; then
#         echo -e $COLOR_YELLOW
#     elif [[ $git_status =~ "nothing to commit" ]]; then
#         echo -e $COLOR_GREEN
#     else
#         echo -e $COLOR_OCHRE
#     fi
# }
# 
# function git_branch {
#     local git_status="$(git status 2> /dev/null)"
#     local on_branch="On branch ([^${IFS}]*)"
#     local on_commit="HEAD detached at ({^${IFS}]*)"
# 
#     if [[ $git_status =~ $on_branch ]]; then
#         local branch=${BASH_REMATCH[1]}
#         echo  "($branch)"
#     elif [[ $git_status =~ $on_commit ]]; then
#         local commit=${BASH_REMATCH[1]}
#         echo "($commit)"
#     fi
# }
# 
# PS1="\[$COLOR_WHITE\]\n[\W]"
# PS1+="\[\$(git_color)\]"
# PS1+="\$(git_branch)"
# PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
# export PS1

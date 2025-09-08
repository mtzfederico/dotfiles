# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# https://askubuntu.com/questions/372849/what-does-debian-chrootdebian-chroot-do-in-my-terminal-prompt
# https://unix.stackexchange.com/questions/3171/what-is-debian-chroot-in-bashrc
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    # Ubuntu default:	
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # Custom, details below
    # prev one
    # PS1='${debian_chroot:+($debian_chroot)}\[\e[0m\e[38;5;39m\]\u\[\e[0;37m\]@\[\e[0m\]\[\e[38;5;39m\]\h\[\e[0m\] \[\e[38;5;11m\]\d \[\e[38;5;10m\]\D{%r} \[\e[38;5;208m\]\w\n\[\e[m\] \$ '
    if [ -z "$debian_chroot" ]; then
        # when debian_chroot is not defined
        # https://askubuntu.com/questions/372849/what-does-debian-chrootdebian-chroot-do-in-my-terminal-prompt
        PS1='\[\e[0;37m\][\[\[\e[0m\e[38;5;39m\]\u\[\e[0;37m\]@\[\e[38;5;39m\]\h\[\e[0;37m\]] \[\e[38;5;11m\]\d \[\e[38;5;10m\]\D{%r} \[\e[38;5;208m\]\w\[\e[0m\] \[\e[38;5;39m\]$(__git_ps1 "(%s)")\[\e[0m\]\n \$ '
        ## PS1='\[\e[0;37m\][\[\[\e[0m\e[38;5;39m\]\u\[\e[0;37m\]@\[\e[38;5;39m\]\h\[\e[0;37m\]] \[\e[38;5;11m\]\d \[\e[38;5;10m\]\D{%r} \[\e[38;5;208m\]\w\[\e[0m\]\n \$ '
    else 
    PS1='${debian_chroot:+($debian_chroot)} \[\e[0;37m\][\[\[\e[0m\e[38;5;39m\]\u\[\e[0;37m\]@\[\e[38;5;39m\]\h\[\e[0;37m\]] \[\e[38;5;11m\]\d \[\e[38;5;10m\]\D{%r} \[\e[38;5;208m\]\w\[\e[0m\] \[\e[38;5;39m\]$(__git_ps1 "(%s)")\[\e[0m\]\n \$ '
    ## PS1='${debian_chroot:+($debian_chroot)} \[\e[0;37m\][\[\[\e[0m\e[38;5;39m\]\u\[\e[0;37m\]@\[\e[38;5;39m\]\h\[\e[0;37m\]] \[\e[38;5;11m\]\d \[\e[38;5;10m\]\D{%r} \[\e[38;5;208m\]\w\[\e[0m\] \n \$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \d \D{%r} \w $(__git_ps1 "(%s) ")\$ '
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
    alias zgrep='zgrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi


#custom things

## Look at https://www.ibm.com/developerworks/linux/library/l-tip-prompt/
## from a comment in https://opensource.com/article/19/9/linux-terminal-colors
## export PS1="\[\e[0m\e[38;5;39m\]\u@\h \[\e[38;5;11m\]\d \[\e[38;5;10m\]\@ \[\e[38;5;208m\]\w\n\[\e[m\] $ " 

##test 
# export PS1="\[\e[0m\e[38;5;39m\]\u@\h \[\e[38;5;11m\]\d \[\e[38;5;10m\]\@ \[\e[38;5;208m\]\w\n\[\e[m\] \$ " 

## https://github.com/nvbn/thefuck
## Run 'fuck' to fix the previous command that you typed
if command -v thefuck &> /dev/null; then
	eval $(thefuck --alias)
	# You can use whatever you want as an alias, like for Mondays:
	eval $(thefuck --alias FUCK)
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME=$HOME/.virtualenvs
	export PROJECT_HOME=$HOME/projects
	source /usr/local/bin/virtualenvwrapper.sh
fi


## https://github.com/keybase/keybase-issues/issues/2798
## https://unix.stackexchange.com/questions/257061/gentoo-linux-gpg-encrypts-properly-a-file-passed-through-parameter-but-throws-i/257065#257065
export GPG_TTY=$(tty)

# Add go to the path
export PATH=$PATH:/usr/local/go/bin

# Add go/bin, the default GOPATH, to the path.
# This is where go install puts binaries
##if [ -d $HOME/go/bin ]; then
##    export PATH=$PATH:$HOME/go/bin
##fi

## Notes on hugo:
##  When installed from source, it is installed in the GOTPATH: https://gohugo.io/installation/linux/
##  Downloaded binary is in /usr/local/sbin in the PATH: https://www.brycewray.com/posts/2022/10/how-i-install-hugo/
## /usr/local/sbin is part of the PATH by default. check /etc/profile

# 
if [ -d "/root/.acme.sh/acme.sh.env" ]; then
    . "/root/.acme.sh/acme.sh.env"
    ## PATH="$HOME/.local/bin:$PATH"
fi

#
if [ -d "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

export MAIL=~/Maildir

# Print disk usage on login
# https://unix.stackexchange.com/questions/218613/using-df-h-i-need-to-create-an-bash-script-that-displays-anything-about-60-ut
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
df -hlP  | awk 'int($5)>60{printf "\033[0;31mWarning:\033[0m Partition "$1" only has "$4" free.\nRun df -h to get more details.\n"}'



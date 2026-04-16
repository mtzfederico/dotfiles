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

## Set the width of a tab to 4 spaces
# https://unix.stackexchange.com/questions/32829/change-tab-size-of-cat-command
# https://man.archlinux.org/man/tabs.1.en
tabs -4

if ! command -v __git_ps1 &>/dev/null; then
    # Debian/Ubuntu
    if [ -f "/usr/lib/git-core/git-sh-prompt" ]; then
        . "/usr/lib/git-core/git-sh-prompt"
    # macOS Xcode Command Line Tools
    elif [ -f "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh" ]; then
        . "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
    # macOS Homebrew (Apple Silicon)
    elif [ -f "/opt/homebrew/etc/bash_completion.d/git-prompt.sh" ]; then
        . "/opt/homebrew/etc/bash_completion.d/git-prompt.sh"
    # macOS Homebrew (Intel)
    elif [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
        . "/usr/local/etc/bash_completion.d/git-prompt.sh"
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

# https://jef.works/blog/2017/08/13/5-useful-bash-aliases-and-functions/

compress() {
    if [ $# -ne 1 ]; then
        echo "Bad parameters. Only supply item to compress.\nTo compress a dir use compressDir <dir>";
    fi
    xz --verbose --keep -9 $1
}

decompress() {
    if [ $# -ne 1 ]; then
        echo "Bad parameters. Only supply item to decompress.\nTo decompress a dir use decompressDir <dir>.";
    fi
    xz --decompress $1
}

xzlist() { xz --list $1; }

compressDir() {
    if [ $# -ne 1 ]; then
        echo "Bad parameters. Only supply directory to compress.\nTo compress a file use compress <file>";
    fi
    tar --verbose --create --xz -f $1.tar.xz $1;
}

decompressDir() {
    if [ $# -ne 1 ]; then
        echo "Bad parameters. Only supply directory to decompress.";
    fi
    tar --verbose --extract -f $1;
}
tarlist() { tar --list -f $1; }

# create a folder and cd into it
mkcd() { mkdir $1 ; cd $1; }

alias cd..='cd ..'

alias nginxlogs='cd /var/log/nginx'
alias nginxconf='cd /etc/nginx'

alias hugostart='hugo server --bind=192.168.53.53 --baseURL=http://192.168.53.53 --port=1313'
alias runserver='gunicorn --bind 0.0.0.0:9080 wsgi:app'

alias webdir='cd /var/www/'

alias myip='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short'
alias myip4='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -4'
alias myip6='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -6'

alias dnsip='dig TXT o-o.myaddr.l.google.com +short'

# Add an if here to change the command in different systems
alias temp='vcgencmd measure_temp'

# Make shred replace the files with zeros by default. https://www.geeksforgeeks.org/shred-command-in-linux-with-examples/
alias shred='shred -zu'

# To load the git cheat sheet
gitcheat() {
curl https://cheat.sh/git
echo -e "\n" # for a newline
}

# dinopass.com API for strong password
alias dpass='curl -w "\n" https://www.dinopass.com/password/strong'

# To check the ports that are listening
alias checkports='sudo lsof -i -P -n | grep LISTEN || echo "run sudo apt install lsof"'
alias checkallports='sudo lsof -i -P -n || echo "run sudo apt install lsof"'

# To check the active outgoing connections
# https://unix.stackexchange.com/questions/56453/how-can-i-monitor-all-outgoing-requests-connections-from-my-machine
alias checkconnections='netstat -nputw'

rnginx() {
sudo nginx -t && sudo systemctl restart nginx 
}

function http(){
    curl http://httpcode.info/$1;
}

alias mtr='mtr --show-ips --aslookup --report-wide'

# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

checkRebootRequired() {
if [ -f /var/run/reboot-required ]; then
  echo -e "${RED}***reboot required***${NC}\n${BLUE}Packages that require reboot:${NC}"
  cat /var/run/reboot-required.pkgs
fi
}

# command to update the system
updatesys() { echo -e "${CYAN}Running sudo apt update${NC}" && sudo apt update && echo -e "${CYAN}Running sudo apt upgrade${NC}" && sudo apt upgrade && echo -e "${CYAN}Running sudo apt autoremove${NC}" && sudo apt autoremove && checkRebootRequired; }

dotfiles() {
    local BOLD='\033[1m'
    local YELLOW='\033[1;33m'
    local GREEN='\033[0;32m'
    # local CYAN='\033[0;36m'
    # local NC='\033[0m'

    echo -e "${BOLD}${CYAN}=== Dotfiles — Available Commands ===${NC}\n"

    echo -e "${YELLOW}${BOLD} Navigation${NC}"
    echo -e "  ${GREEN}mkcd${NC} <dir>              Create a directory and cd into it"
    echo -e "  ${GREEN}cd..${NC}                    Alias for cd .."
    echo -e "  ${GREEN}webdir${NC}                  cd to /var/www/"
    echo -e "  ${GREEN}nginxlogs${NC}               cd to /var/log/nginx"
    echo -e "  ${GREEN}nginxconf${NC}               cd to /etc/nginx"
    echo ""

    echo -e "${YELLOW}${BOLD} Compression${NC}"
    echo -e "  ${GREEN}compress${NC} <file>         Compress a file with xz (-9, keeps original)"
    echo -e "  ${GREEN}decompress${NC} <file>       Decompress an xz file"
    echo -e "  ${GREEN}xzlist${NC} <file>           List information about an xz file"
    echo -e "  ${GREEN}compressDir${NC} <dir>       Compress a directory to <dir>.tar.xz"
    echo -e "  ${GREEN}decompressDir${NC} <file>    Extract a tar archive"
    echo -e "  ${GREEN}tarlist${NC} <file>          List contents of a tar archive"
    echo ""

    echo -e "${YELLOW}${BOLD} Networking${NC}"
    echo -e "  ${GREEN}myip${NC}                    Get your public IP address"
    echo -e "  ${GREEN}myip4${NC}                   Get your public IPv4 address"
    echo -e "  ${GREEN}myip6${NC}                   Get your public IPv6 address"
    echo -e "  ${GREEN}checkports${NC}              Show listening ports (requires lsof)"
    echo -e "  ${GREEN}checkallports${NC}           Show all open ports (requires lsof)"
    echo -e "  ${GREEN}checkconnections${NC}        Show active outgoing connections"
    echo -e "  ${GREEN}mtr${NC} <host>              Traceroute with IPs and AS lookup"
    echo -e "  ${GREEN}http${NC} <code>             Look up an HTTP status code"
    echo ""

    echo -e "${YELLOW}${BOLD} System${NC}"
    echo -e "  ${GREEN}updatesys${NC}               apt update + upgrade + autoremove"
    echo -e "  ${GREEN}checkRebootRequired${NC}     Check if a reboot is pending"
    echo -e "  ${GREEN}temp${NC}                    Check CPU temperature (Raspberry Pi)"
    echo -e "  ${GREEN}shred${NC} <file>            Securely delete a file (zeros + unlink)"
    echo ""

    echo -e "${YELLOW}${BOLD} Web Servers${NC}"
    echo -e "  ${GREEN}rnginx${NC}                  Test nginx config and restart"
    echo -e "  ${GREEN}hugostart${NC}               Start Hugo dev server on 192.168.53.53"
    echo -e "  ${GREEN}runserver${NC}               Start gunicorn on port 9080"
    echo ""

    echo -e "${YELLOW}${BOLD} Utilities${NC}"
    echo -e "  ${GREEN}gitcheat${NC}                Fetch the git cheat sheet from cheat.sh"
    echo -e "  ${GREEN}dpass${NC}                   Generate a strong password via dinopass.com"
    echo -e "  ${GREEN}dotfiles${NC}                Show this help message"
    echo ""

    echo -e "${YELLOW}${BOLD} Other stuff${NC}"
    echo -e "  ${GREEN}declare -f <function>${NC}   Print the definition of function"
    echo -e "  ${GREEN}type <command>${NC}          Prints the type of command and it's definition"
    echo ""
}

# Print disk usage on login
# https://unix.stackexchange.com/questions/218613/using-df-h-i-need-to-create-an-bash-script-that-displays-anything-about-60-ut
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
df -hP  | awk 'int($5)>60{printf "\033[0;31mWarning:\033[0m Partition "$1" only has "$4" free.\nRun df -h to get more details.\n"}'



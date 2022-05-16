# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# https://jef.works/blog/2017/08/13/5-useful-bash-aliases-and-functions/

# create .tar.gz 
targz() { tar -zcvf $1.tar.gz $1; }
# extra .tar.gz
untargz() { tar -zxvf $1; }

# create a folder and cd into it
mkcd() { mkdir $1 ; cd $1; }

alias nginxlogs='cd /var/log/nginx'
alias nginxconf='cd /etc/nginx'

alias runserver='gunicorn --bind 0.0.0.0:9080 wsgi:app'

alias webdir='cd /var/www/'

alias myip='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short'

# Add an if here to change the command in different systems
alias temp='/opt/vc/bin/vcgencmd measure_temp'

# Make shred replace the files with zeros by default. https://www.geeksforgeeks.org/shred-command-in-linux-with-examples/
alias shred='shred -zu'

# To load the git cheat sheet
gitcheat() {
curl https://cheat.sh/git
}

# To check the ports that are listening
alias checkports='sudo lsof -i -P -n | grep LISTEN'

# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# command to update the system
updatesys() { echo -e "${BLUE}Running sudo apt update${NC}" && sudo apt update && echo -e "${BLUE}Running sudo apt upgrade${NC}" && sudo apt upgrade && echo -e "${BLUE}Running sudo apt autoremove${NC}" && sudo apt autoremove; }

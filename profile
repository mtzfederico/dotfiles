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
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

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
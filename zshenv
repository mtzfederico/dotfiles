
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:/sbin/:$PATH"

alias myip_dig='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short'
alias myip4_dig='myip_dig -4'
alias myip6_dig='myip_dig -6'

alias myip='drill -Q @ns1.google.com TXT o-o.myaddr.l.google.com'
alias myip4='drill -Q -4 @ns1.google.com TXT o-o.myaddr.l.google.com'
alias myip6='drill -Q -6 @ns1.google.com TXT o-o.myaddr.l.google.com'

# Check if the cargo env file exists
if [[ -e "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

alias get_idf='. $HOME/esp/esp-idf/export.sh'

# To load the git cheat sheet
gitcheat() {
curl https://cheat.sh/git
}

# To check the ports that are listening
alias checkports='sudo lsof -i -P -n | grep LISTEN || echo "run sudo apt install lsof"'

alias checkallports='sudo lsof -i -P -n || echo "run sudo apt install lsof"'

# For macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Flutter SDK path
    export PATH="/Users/FedeMtz/SDKS/flutter/bin:$PATH"
 fi
 
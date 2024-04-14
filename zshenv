# source "$HOME/.cargo/env"

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:/sbin/:$PATH"

alias myip='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short'
alias myip4='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -4'
alias myip6='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -6'
. "$HOME/.cargo/env"

alias get_idf='. $HOME/esp/esp-idf/export.sh'

# To load the git cheat sheet
gitcheat() {
curl https://cheat.sh/git
}

# To check the ports that are listening
alias checkports='sudo lsof -i -P -n | grep LISTEN || echo "run sudo apt install lsof"'

alias checkallports='sudo lsof -i -P -n || echo "run sudo apt install lsof"'

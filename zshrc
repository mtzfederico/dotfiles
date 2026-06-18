## zshrc
# https://medium.com/pareture/simplest-zsh-prompt-configs-for-git-branch-name-3d01602a6f33
# https://gist.github.com/reinvanoyen/05bcfe95ca9cb5041a4eafd29309ff29

# Find and set branch name var if in git repository.
function git_branch_name() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    # the leading space is important. It is not in the actual prompt so that when there is no branch, there is no extra space.
    echo ' %F{39}('$branch')%f'
  fi
}

# Capture exit code before prompt renders
_last_exit_code=0
precmd() {
  _last_exit_code=$?
}

# Show non zero exit codes
_exit_code_prompt() {
  [[ $_last_exit_code -ne 0 ]] && print -Pn "%F{196}($_last_exit_code)%f "
}

# Clear the exit code from the prompt
alias cle='_exit_code_prompt_str=""'

# Enable substitution in the prompt.
setopt prompt_subst

# Sample prompt from url
# prompt='%2/ $(git_branch_name) > '

#export PROMPT="%10F%m%f:%11F%1~%f \$ "

# %n shows the username
# %m shows the hostname
# In %D{%a %b %d %r} the values are:
#   %a is abbreviated weekday acording to current locale
#   %b is abbreviated month according to current locale
#   %d is day of month (01..31)
#   %r is time in 12-hour AM/PM format
# %0~ is the current working directory, with ~ for home
# %# is # for root and % for normal user

# | Bash            | Meaning    | Zsh equivalent |
# | --------------- | ---------- | -------------- |
# | `\e[38;5;10m`   | green      | `%F{10}`       |
# | `\e[38;5;11m`   | yellow     | `%F{11}`       |
# | `\e[0;37m`      | light gray | `%F{249}`       |
# | `\e[38;5;39m`   | blue/cyan  | `%F{39}`       |
# | `\e[38;5;208m`  | orange     | `%F{208}`      |
# | `\e[0m`         | reset      | `%f`           |

if [[ "$(uname -s)" == "Darwin" ]]; then
  # For macOS
  # export PROMPT='%F{10}%n%f%F{15}@%f%F{10}%m%f %F{51}%D{%a %b %d %r}%f %F{227}%0~%f$(git_branch_name) %# '
  export PROMPT='%F{10}%n%f%F{15}@%f%F{10}%m%f %F{51}%D{%a %b %d %r}%f %F{227}%0~%f$(git_branch_name) $(_exit_code_prompt)%# '
  # prints why MacOS won't go to sleep
  # https://gist.github.com/tternes/4689521
  # 
  alias whynosleep=pmset -g assertions
else
  # For other operating systems
  export PROMPT='%F{249}[%F{39}%n%F{15}@%F{39}%m%F{249}] %F{11}%D{%a %b %d} %F{10}%D{%r} %F{208}%0~%f$(git_branch_name)
 $(_exit_code_prompt)%# '
 fi

## Links
## https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# https://sureshjoshi.com/development/zsh-prompts-that-dont-suck#references
# https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
# https://unix.stackexchange.com/questions/331341/how-to-set-dd-mm-yy-for-command-prompt-in-zsh
# https://linux.die.net/man/3/strftime
# https://old.reddit.com/r/zsh/comments/sfktv2/suggest_a_fast_convenient_zsh_prompt/
# man zshmisc


# PROMPT="%F{36}%n%B%F{102}@%b%F{14}%m%b %F{11}$(date +"%a %b %d") %F{10}$(date +"%r") %F{172}%~%f %b%# "
# PROMPT="%F{39}%n%F{7}@%b%F{39}%m %F{11}$(date +"%a %b %d") %F{10}$(date +"%r") %F{172}%~%f 
# %# "

#if [[ "$(uname -s)" == 'Darwin' ]]; then
#  darwin_icon=" "
#fi

#PROMPT="%F{39}%n%F{7}@%b%F{39}%m %F{11}$(date +"%a %b %d") %F{10}$(date +"%r") $(echo $darwin_icon)%F{172}%~%f
# %# " 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias myip_dig='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short'
alias myip4_dig='myip_dig -4'
alias myip6_dig='myip_dig -6'

alias myip='drill -Q @ns1.google.com TXT o-o.myaddr.l.google.com'
alias myip4='drill -Q -4 @ns1.google.com TXT o-o.myaddr.l.google.com'
alias myip6='drill -Q -6 @ns1.google.com TXT o-o.myaddr.l.google.com'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

# To load the git cheat sheet
gitcheat() {
  curl https://cheat.sh/git
}

# Page doesn't exist anymore
# http(){
#     curl http://httpcode.info/$1;
# }

exitcodes() {
  print -P "
  %F{227}Common Shell Exit Codes%f

  %F{39}Code  Meaning%f
  %F{249}────  ───────────────────────────────────────%f
  %F{208}0%f     Success
  %F{208}1%f     Catchall for general errors
  %F{208}2%f     Misuse of shell builtins (according to Bash documentation)
  %F{208}126%f   Command invoked cannot execute
  %F{208}127%f   Command not found
  %F{208}128%f   Invalid exit argument
  %F{208}130%f   Script terminated by Ctrl+C (SIGINT)
  %F{208}137%f   Process killed (SIGKILL, e.g. OOM killer)
  %F{208}139%f   Segmentation fault (SIGSEGV)
  %F{208}141%f   Broken pipe (SIGPIPE)
  %F{208}143%f   Process terminated (SIGTERM)

  %F{249}128+N means the process was killed by signal N%f
  %F{249}Run 'kill -l' to see all signal numbers in order, starting at 1 (index = the signal number)%f

  %F{51}https://tldp.org/LDP/abs/html/exitcodes.html%f
  "
}

# To check the ports that are listening
alias checkports='sudo lsof -i -P -n | grep LISTEN || echo "run sudo apt install lsof"'

alias checkallports='sudo lsof -i -P -n || echo "run sudo apt install lsof"'

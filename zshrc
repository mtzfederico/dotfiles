#export PROMPT="%10F%m%f:%11F%1~%f \$ "

export PROMPT='%F{10}%n%f%F{15}@%f%F{10}%m%f %F{51}%D{%a %b %d %r}%f %F{227}%0~%f %# '

## Links
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

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
    echo ' %F{39}(git '$branch')%f'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Sample prompt from url
# prompt='%2/ $(git_branch_name) > '

#export PROMPT="%10F%m%f:%11F%1~%f \$ "

export PROMPT='%F{10}%n%f%F{15}@%f%F{10}%m%f %F{51}%D{%a %b %d %r}%f %F{227}%0~%f$(git_branch_name) %# '

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH" ## from brew install mysql-client

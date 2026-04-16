## zshenv

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:/sbin/:$PATH"

# Check if the cargo env file exists
if [[ -e "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

# For macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Flutter SDK path
    export PATH="/Users/FedeMtz/SDKS/flutter/bin:$PATH"
 fi
 
 if [[ -e "/opt/homebrew/opt/mysql-client/bin" ]]; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH" ## from brew install mysql-client
fi

if [[ -e "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
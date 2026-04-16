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

# Add go to the path
if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

# Add go/bin, the default GOPATH, to the path.
# This is where go install puts binaries
##if [ -d $HOME/go/bin ]; then
##    export PATH=$PATH:$HOME/go/bin
##fi


## Notes on hugo:
##  When installed from source, it is installed in the GOTPATH: https://gohugo.io/installation/linux/
##  Downloaded binary is in /usr/local/sbin in the PATH: https://www.brycewray.com/posts/2022/10/how-i-install-hugo/
## /usr/local/sbin is part of the PATH by default. check /etc/profile

export MAIL=~/Maildir

# 
if [ -f "/root/.acme.sh/acme.sh.env" ]; then
    . "/root/.acme.sh/acme.sh.env"
    ## PATH="$HOME/.local/bin:$PATH"
fi

#
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
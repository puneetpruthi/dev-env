# Self created Login BASH_PROFILE

# Set Alias
alias vi=vim

# Set Paths / Environment
PS1="[$LOGNAME@`uname -n`]\$PWD$ "

if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

# Set Alias
alias vi=vim

# Limit the path length shown on prompt
PROMPT_DIRTRIM=4

# Prompt formatting  (with color)
# Currently, the prompt looks like:
# [username@hostname $PWD]
typeset +x PS1="[\[\e[0;31m\]\u\[\e[m\]@\[\e[0;32m\]\h\[\e[m\]\[\e[0;34m\] \w\[\e[00m\]]$ "

# old prompt formatting
# PS1="${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\] \[\033[00;36m\]\w\[\033[00m\] \$ " 
 
 # Set title
set XTERM_TITLE='\[\e]0;\W@\u@\H\a\]'
 
# Setting environment
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
#export PROMPT_COMMAND="history -a"

# Dunno why I had this. Commenting it for the moment
#printf "\033]0;`uname -n`\007"

# Set xterm title
PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}\007"'

umask 0022

EDITOR=vim

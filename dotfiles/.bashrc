PATH=.:$PATH

# Source my shared config
# TODO 20200508: It seems that some important stuff is in .zshrc and not .shrc
# like setting PATH?
. ~/.shrc

export HISTFILESIZE=50000
export HISTSIZE=50000
export history_control=ignoredups

# Set the shell prompt.  See the bash man page for a description 
# of special characters.
if [ ! "$LOGIN_SHELL" ]; then
   PS1="\[\e[32m\]\h:\w\\[\e[0m\]$ "
fi

# For source control commit messages.
export EDITOR="vim"

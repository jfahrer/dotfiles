export EDITOR=vim

. ~/.aliases

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

eval "$(rbenv init -)"

export WS=$HOME/workspace
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CDPATH=.:$HOME/workspace:$HOME

if [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

. ~/.bash_it_profile
. ~/.custom_functions
. ~/.docker_helpers

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

PATH=~/.bin:./bin:$PATH
export PATH

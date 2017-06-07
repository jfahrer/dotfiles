export EDITOR=vim

. ~/.aliases

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

eval "$(rbenv init -)"
(docker-machine ls | grep default > /dev/null) && eval $(docker-machine env)

export WS=$HOME/workspace
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CDPATH=.:$HOME/workspace:$HOME

# prompt
export PS1="\e[32m[\t]\e[0m \u@\h\e[33m [\w]\e[0m \n> "

if [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

. ~/bash_it_profile
PATH=./bin:~/.bin:$PATH
export PATH

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

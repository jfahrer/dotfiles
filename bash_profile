export EDITOR=vim

. ~/.aliases
if [ -f ~/.aliases.local ]; then
  . ~/.aliases.local
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ ! -z $(which rbenv) ]; then
  eval "$(rbenv init -)"
fi

if [ -e /usr/local/opt/nvm/nvm.sh ]; then
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"
fi

if [ ! -z $(which thefuck) ]; then
  eval $(thefuck --alias f)
fi

export WS=$HOME/workspace
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CDPATH=.:$HOME/workspace:$HOME

if [ ! -z $(which brew) ] && [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

. ~/.bash_it_profile
. ~/.custom_functions
. ~/.docker_helpers

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

PATH=~/.bin:./bin:$PATH
export PATH

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

if [ -f ./.env ]; then
  . ./.env
fi

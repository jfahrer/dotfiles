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

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  export FZF_DEFAULT_COMMAND='ag --skip-vcs-ignores --path-to-ignore ~/.agignore -l --nocolor -g ""'
  bind "$(bind -s | grep __fzf_cd__ | sed 's/\\ec/\\C-g/')"
  bind "$(bind -s | grep __fzf_select | sed 's/\\C-t/\\C-n/')"
  bind -x '"\C-p": vim $(fzf);'
  bind '"\C-t": transpose-chars'
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
  export $(grep -v '^#' .env | xargs -0)
fi

_source_if_exists() {
  if [ -f $1 ]; then
    . $1
  fi
}

if [ -f "/opt/homebrew/bin/brew" ] && [ -z "$HOMEBREW_PRESENT" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_PRESENT=true
fi

export EDITOR=nvim
export BASH_SILENCE_DEPRECATION_WARNING=1
export WS=$HOME/workspace
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE="h:history"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

_source_if_exists ~/.bash_env.local
_source_if_exists ~/.bashrc
_source_if_exists ~/.aliases
_source_if_exists ~/.aliases_local
_source_if_exists ~/.asdf.bash

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  # Old setting using `ag` instead of `rg`
  # export FZF_DEFAULT_COMMAND='ag --skip-vcs-ignores --path-to-ignore ~/.agignore -l --nocolor -g ""'
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
  export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up,ctrl-a:select-all,ctrl-d:deselect-all'
  bind "$(bind -s | grep __fzf_cd__ | sed 's/\\ec/\\C-g/')"
  bind "$(bind -s | grep __fzf_select | sed 's/\\C-t/\\C-n/')"
  bind -x '"\C-p": $(fzf | ifne xargs echo vim);'
fi

bind '"\C-t": transpose-chars'

if [ ! -z $(which brew) ] && [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

_source_if_exists ~/.bash_it_profile
_source_if_exists ~/.custom_functions
_source_if_exists ~/.docker_helpers
_source_if_exists ~/.config/op/plugins.sh
_source_if_exists ~/.iterm2_shell_integration.bash
_source_if_exists ~/.coursier.bash

export GOPATH=$HOME/go

# For some projects it is useful to keep a seperate bash history file
# So if one exists in the local directory, we use it
PROJECT_HIST_FILE=$(pwd)/.bash_history
if [ -f $PROJECT_HIST_FILE ] && [ -n "$TMUX" ]; then
  export HISTFILE=$PROJECT_HIST_FILE
fi

_source_if_exists ~/.bash_profile.local

# For some projects it can be helpful to set env vars.
# This behavior is restricted to TMUX sessions
if [ -n "$TMUX" ]; then
  _source_if_exists .bash_env.local
fi

if [[ ! "$PATH" == *$HOME/go/bin* ]]; then
  export PATH=$HOME/go/bin:$PATH
fi
if [[ ! "$PATH" == *$HOME/bin* ]]; then
  export PATH=$HOME/bin:$PATH
fi
if [[ ! "$PATH" == *./bin* ]]; then
  export PATH=./bin:$PATH
fi

export CDPATH=.:$WS:$HOME

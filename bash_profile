_source_if_exists() {
  if [ -f $1 ]; then
    . $1
  fi
}

if [ -f "/opt/homebrew/bin/brew" ] && [ -z "$HOMEBREW_PRESENT" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_PRESENT=true
fi

# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

export EDITOR=nvim
export BASH_SILENCE_DEPRECATION_WARNING=1
export WS=$HOME/workspace
export CDPATH=.:$WS:$HOME
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE="h:history"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# For some projects it is useful to keep a seperate bash history file
# So if one exists in the local directory, we use it
PROJECT_HIST_FILE=$(pwd)/.bash_history
if [ -f $PROJECT_HIST_FILE ] && [ -n "$TMUX" ]; then
  export HISTFILE=$PROJECT_HIST_FILE
fi

_source_if_exists ~/.bash_env.local
_source_if_exists ~/.bashrc
_source_if_exists ~/.aliases
_source_if_exists ~/.aliases_local
_source_if_exists ~/.asdf.bash
_source_if_exists ~/.fzf.bash

if [ ! -z $(which brew) ] && [ -f $(brew --prefix)/etc/bash_completion  ]; then
  . $(brew --prefix)/etc/bash_completion
fi

_source_if_exists ~/.bash_it_profile
_source_if_exists ~/.custom_functions
_source_if_exists ~/.docker_helpers
_source_if_exists ~/.config/op/plugins.sh
_source_if_exists ~/.iterm2_shell_integration.bash
_source_if_exists ~/.coursier.bash

# Add binding to transpose chars - needs to happen after loading fzf.bash
bind '"\C-t": transpose-chars'

export GOPATH=$HOME/go

# Source local overwrites
_source_if_exists ~/.bash_profile.local

# For some projects it can be helpful to set env vars.
# This behavior is restricted to TMUX sessions
if [ -n "$TMUX" ]; then
  _source_if_exists .bash_env.local
fi

# Ensure PATH is set correctly
## Make sure GOPATH is included
if [[ ! "$PATH" == *$GOPATH/bin* ]]; then
  export PATH=$GOPATH/bin:$PATH
fi

## Ensure ./bin and $HOME/bin are in the beginning of PATH
## We first remove ./bin and $HOME/bin from PATH since 
## /etc/profile might eval `/usr/libexec/path_helper -s` and 
## effectively move my home dirs to the bottom of the list
## when starting a new tmux session.
## This currently relies on the fact that neither directory
## will be at the very end of the list
case ":$PATH:" in
  *":./bin:"*) PATH=${PATH//\.\/bin:/} ;;
esac
case ":$PATH:" in
  *":$HOME/bin:"*) PATH=${PATH//$HOME\/bin:/} ;;
esac
## Now prepend ./bin and $HOME/bin
export PATH=$HOME/bin:$PATH
export PATH=./bin:$PATH

export EDITOR=vim

. ~/.aliases
if [ -f ~/.aliases.local ]; then
  . ~/.aliases.local
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ ! -z $(which asdf) ]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
fi

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
  export FZF_DEFAULT_COMMAND='ag --skip-vcs-ignores --path-to-ignore ~/.agignore -l --nocolor -g ""'
  export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up,ctrl-a:select-all,ctrl-d:deselect-all'
  bind "$(bind -s | grep __fzf_cd__ | sed 's/\\ec/\\C-g/')"
  bind "$(bind -s | grep __fzf_select | sed 's/\\C-t/\\C-n/')"
  bind -x '"\C-p": $(fzf | ifne xargs echo vim);'
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

# For some projects it is useful to keep a seperate bash history file
# So if one exists in the local directory, we use it
PROJECT_HIST_FILE=$(pwd)/.bash_history
if [ -f $PROJECT_HIST_FILE ] && [ -n "$TMUX" ]; then
  export HISTFILE=$PROJECT_HIST_FILE
fi
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE="h:history"

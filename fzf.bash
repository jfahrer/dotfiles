# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/opt/fzf/bin* ]]; then
  export PATH="$PATH:$(brew --prefix)/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.bash" 2>/dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up,ctrl-a:select-all,ctrl-d:deselect-all'
bind "$(bind -s | grep __fzf_cd__ | sed 's/\\ec/\\C-g/')"
bind "$(bind -s | grep __fzf_select | sed 's/\\C-t/\\C-n/')"
bind -x '"\C-p": $(fzf | xargs -r echo nvim);'

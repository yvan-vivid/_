# Setup fzf
# ---------
if [[ ! "$PATH" == *$p_fzf/bin* ]]; then
  export PATH="$PATH:$p_fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$p_fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$p_fzf/shell/key-bindings.zsh"

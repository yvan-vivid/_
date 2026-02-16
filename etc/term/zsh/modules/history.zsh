# =============================================================================
# Yvan Vivid - Zsh History Configuration
# =============================================================================

# History file location
histpath="$XDG_STATE_HOME/zsh/history"
histname="history-$session_id"

# Create history directory
mkdir -p "$histpath"

# History settings
export HISTFILE="$histpath/$histname"
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export SAVEHIST=10000

# vim: ft=zsh et fenc=utf-8 sts=4 sw=4 ts=8 tw=80

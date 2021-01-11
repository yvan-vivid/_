# =============================================================================
# Yvan Vivid - dotfiles - Zsh RC
# =============================================================================

emulate zsh

# =============================================================================
# History Options
# =============================================================================
# {{{

typeset -g HISTFILE
HISTFILE="$ZSH_STATE/history"

typeset -gi HISTSIZE SAVEHIST
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

setopt NO_BANG_HIST
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY

# Other options
setopt RM_STAR_WAIT
setopt LONG_LIST_JOBS

# }}}
# =============================================================================
# Environment Options
# =============================================================================
# {{{

setopt ALWAYS_TO_END
setopt C_BASES
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt MULTIOS
setopt NO_BG_NICE
setopt NO_CHECK_JOBS
setopt NO_HUP
setopt NOTIFY
setopt VI

# }}}
# =============================================================================
# Directory Options
# =============================================================================
# {{{

setopt AUTO_CD
setopt AUTO_PARAM_SLASH
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NO_CLOBBER
setopt PUSHD_TO_HOME
setopt PUSHD_SILENT

# }}}
# =============================================================================
# vim: et fenc=utf-8 ft=zsh sts=4 sw=4 ts=8 tw=80 fdm=marker

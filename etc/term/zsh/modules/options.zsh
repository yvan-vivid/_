# =============================================================================
# Yvan Vivid - Zsh Options
# =============================================================================

# History Options
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS

# Completion Options
setopt ALWAYS_TO_END
setopt C_BASES
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB

# Job Control
setopt LONG_LIST_JOBS
setopt NO_BG_NICE
setopt NO_CHECK_JOBS
setopt NO_HUP
setopt NOTIFY

# Misc Options
setopt INTERACTIVE_COMMENTS
setopt MULTIOS

# Directory Options
setopt PUSHD_SILENT        # Don't print pushd stack
setopt PUSHD_TO_HOME       # pushd with no args goes to ~

# File Operations
setopt GLOB_DOTS           # Include dotfiles in globs
setopt NO_CLOBBER          # Don't overwrite files with >
setopt RM_STAR_WAIT        # Wait 10s before rm *

# vim: ft=zsh et fenc=utf-8 sts=4 sw=4 ts=8 tw=80

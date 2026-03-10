# =============================================================================
# Yvan Vivid - Zsh Tool Initializations
# =============================================================================

# Zoxide - smart cd
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Keychain - SSH agent
if command -v keychain &> /dev/null; then
  eval "$(keychain --eval --quiet --noask)"
fi

# Path
path=(
  "$DOT_ROOT/bin"
  $path
)

# vim: ft=zsh et fenc=utf-8 sts=4 sw=4 ts=8 tw=80

# =============================================================================
# Yvan Vivid - dotfiles - Zsh RC
# =============================================================================

function rezshrc() {
  local z_rc=$z_dot_zsh/core/dot.zshrc
  source $z_rc
  echo "reloaded zsh from $z_rc"
}

function reload-aliases() {
  local z_aliases=$z_dot_zsh/settings/aliases.zsh
  source $z_aliases
  echo "reloaded aliases from $z_aliases"
}

function reload-aliases() {
  local z_functions=$z_dot_zsh/functions/functions.zsh
  source $z_functions
  echo "reloaded functions from $z_functions"
}

function dot-broken() {
  ls -d ~/.*(-@) 2> /dev/null
  if [[ $? -eq 0 ]]; then; echo "Broken"
  else; echo "Links Clear"
  fi
}

# vim: set et fenc=utf-8 ft=zsh sts=4 sw=4 ts=8 tw=80 fdm=marker :

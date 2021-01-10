# shellcheck shell=/usr/bin/zsh
# =============================================================================
# Yvan Vivid - dotfiles - Zinit Setup
# =============================================================================
# TODO: Fix explicit reference

_direnv_hook() {
  trap -- '' SIGINT;
  eval "$("/nix/store/0y1yv2vd57d9432y9yndvjqazbc3bm93-direnv-2.22.0/bin/direnv" export zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions=( _direnv_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z ${chpwd_functions[(r)_direnv_hook]} ]]; then
  chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
fi

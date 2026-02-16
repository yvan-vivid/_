# =============================================================================
# Yvan Vivid - Zsh Functions
# =============================================================================

function source-if() {
  [[ -r "$1" ]] && source "$1" 
}

function source-it() {
  source-if "$1" || echo "Cannot load source [$1]" >&2
}

function timestamp() {
  date +%s%N
}

function source-rc() {
  source-it "$HOME/.zshrc"
}

function yazi-moving() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin pushd -- "$cwd" > /dev/null
  rm -f -- "$tmp"
}

# vim: ft=zsh et fenc=utf-8 sts=4 sw=4 ts=8 tw=80

# =============================================================================
# Yvan Vivid - dotfiles - Zsh RC
# =============================================================================

path=(
    $z_home/_distros_/rust/cargo/bin
    /snap/bin
    /usr/local/{bin,sbin}
    $z_home/_/bin
    $z_home/.local/bin
    $path
)

cdpath=(
    $z_home
    $cdpath
)

# =============================================================================
# vim: set et fenc=utf-8 ft=zsh sts=4 sw=4 ts=8 tw=80 fdm=marker :

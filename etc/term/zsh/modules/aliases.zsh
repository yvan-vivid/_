# =============================================================================
# Yvan Vivid - Zsh Aliases
# =============================================================================

# Modern replacements
alias ls="eza --icons=always"
alias tree="eza --tree --icons=always"
alias ll="eza --long --icons=always"
alias cat="bat"
alias du="dua -x"
alias xdu="dua interactive"
alias df="duf -hide special -hide-mp /nix/store,/boot/efi"

# Safety aliases
alias cp="nocorrect \cp -vi"
alias mv="nocorrect \mv -vi"
alias rm="nocorrect \rm -vI"

# Git aliases
alias git-origin='git config --get remote.origin.url'

# vim: ft=zsh et fenc=utf-8 sts=4 sw=4 ts=8 tw=80

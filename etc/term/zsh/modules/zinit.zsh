# shellcheck shell=/usr/bin/zsh
# =============================================================================
# Yvan Vivid - dotfiles - Zinit Setup
# =============================================================================

source "${ZINIT[BIN_DIR]}/zinit.zsh"

# =============================================================================
# zinit plugins
# =============================================================================

zinit ice wait atload"_zsh_autosuggest_start" lucid
zinit load zsh-users/zsh-autosuggestions

zinit ice wait blockf atpull'zinit creinstall -q .' lucid
zinit load zsh-users/zsh-completions

zinit ice wait atinit"zicompinit; zicdreplay" lucid
zinit load zdharma/fast-syntax-highlighting

zinit ice wait"1" lucid
zinit load zdharma/zui

zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cra*]} ]]' lucid
zinit load zdharma/zinit-crasis

zinit ice wait"2" lucid
zinit load voronkovich/gitignore.plugin.zsh

zinit ice depth=1 lucid
zinit light romkatv/powerlevel10k

# =============================================================================
# vim: et fenc=utf-8 ft=zsh sts=2 sw=2 ts=2 tw=80

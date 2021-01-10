# =============================================================================
# Yvan Vivid - dotfiles - Zsh RC
# =============================================================================

# Aliases for core utils (non-cumulative aliases, resetting refs)
alias cp="nocorrect \\cp -vi"
alias mv="nocorrect \\mv -vi"
alias rm="nocorrect \\rm -vI"
alias ln="\\ln --no-dereference --interactive --verbose"
alias mkdir="nocorrect \\mkdir"
alias ls="\\ls --group-directories-first --color -F -h"
alias df="\\df -h"
alias du="\\du --human-readable --max-depth=1 --total"
alias grep="\\grep -n --color"
alias pgrep="pgrep -l"
alias ip="ip --color"

# ls derivatives
alias ls-syms="ls -dl *(D@)"
alias ls-dot-syms="ls -dl .*(@)"
alias ls-dot-dirs="ls -dl .*(/)"
alias ls-dot-files="ls -dl .*(.)"

# mv derivatives
alias mv-no-clob="nocorrect mv -n"
alias mv-enum="nocorrect mv --backup=numbered"
alias mv-update="nocorrect mv -u"

# other aliases
alias dff='df -T -x squashfs -x tmpfs -x devtmpfs'
alias ht="htop -u $(whoami)"
alias du-local="du --one-file-system"
alias tree='tree -C -I .git --dirsfirst'

# rsync aliases
alias rsync-chowning="rsync -rltpvgo --chown=hexxiiiz:hexxiiiz --progress"
alias rsync-simple="rsync -av --progress"

# git aliases
alias git-origin='git config --get remote.origin.url'

# Tmux related aliases and variants
alias manside="tmux splitw -h -l 100 man"
alias lesside="tmux splitw -h -l 100 less"
alias nvimvs="tmux splitw -h nvim"

# vim: et fenc=utf-8 ft=zsh sts=4 sw=4 ts=8 tw=80

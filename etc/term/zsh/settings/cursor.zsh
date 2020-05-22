# =============================================================================
# Yvan Vivid - dotfiles - Zsh RC
# =============================================================================
# Zsh hooks for switching cursor to match vim mode

# xterm type cursor escapes
cursor_block_xterm='\e[1 q'
cursor_beam_xterm='\e[5 q'

# linux terminal type cursor escapes
cursor_block_linux='\e[?7c'
cursor_beam_linux='\e[?2c'

# using termcap to set appropriate cursor escape codes
if [[ $TERM == linux ]]; then
  cursor_insert='\e[?2c'
  cursor_command='\e[?7c'
else
  cursor_insert='\e[5 q'
  cursor_command='\e[1 q'
fi

# set appropriate cursor
function zle-line-init zle-keymap-select zle-line-finish {
    case $1 in
        ('block')
            echo -ne "$cursor_command"
            return
            ;;
        ('beam')
            echo -ne "$cursor_insert"
            return
            ;;
    esac

    case ${KEYMAP} in
        (vicmd)
            echo -ne "$cursor_command"
            return
            ;;
        (viins|main)
            echo -ne "$cursor_insert"
            return
            ;;
        ('')
            echo -ne "$cursor_insert"
            return
            ;;
    esac
}

# bind zle hooks
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

bindkey -v

# vim: set et fenc=utf-8 ft=zsh sts=4 sw=4 ts=8 tw=80 fdm=marker :

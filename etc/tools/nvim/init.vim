" Yvan Vivid - NEO/VIM RC
if &compatible
  set nocompatible
endif

" ================ Paths ====================
let config_path = expand(getenv("DOT_ETC")) . "/tools/nvim"
let state_path = expand(getenv("DOT_STATE")) . "/nvim"
let plugins_path = state_path . "/plugins"

let g:python3_host_prog = "/home/hexxiiiz/.nix-profile/bin/python3"
let g:python_host_prog = "/home/hexxiiiz/.nix-profile/bin/python"

" ================ Cache/backup ====================

let &directory = state_path . "/swap//"
let &backupdir = state_path . "/backup//"
let &spellfile = state_path . "/spell/en.utf-8.add"

set backup

call init#options#load()

" ================ Plugins ====================

call init#plugins#declare(plugins_path)


let g:tokyonight_style = "night"

colorscheme catppuccin

let g:lightline = {'colorscheme': 'catppuccin'}

" ================ Lsp settings ========================

lua require('init.tree_sitter')
lua require('init.lsp')


syntax on

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

nnoremap <silent> <leader>f za
nnoremap <silent> <leader><tab> <cmd>lua vim.lsp.buf.code_action()<CR>


autocmd FileType markdown set foldexpr=NestedMarkdownFolds()


runtime! defx.vim
runtime! grammarous.vim

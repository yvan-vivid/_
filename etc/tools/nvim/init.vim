" Yvan Vivid - NEO/VIM RC
if &compatible
  set nocompatible
endif

" ================ Paths ====================

let config_path = expand(getenv("DOT_ETC")) . "/tools/nvim"
let state_path = expand(getenv("DOT_STATE")) . "/nvim"
let plugins_path = state_path . "/plugins"

" for netrw history
let g:netrw_home = state_path


"let detected_pypath = system("which python")
"if detected_pypath != ""
"  let g:python3_host_prog = detected_pypath
"endif

" ================ Cache/backup ====================

let &directory = state_path . "/swap//"
let &backupdir = state_path . "/backup//"
let &spellfile = state_path . "/spell/en.utf-8.add"

set backup

" ================ General Config ====================

set hidden
set number
set showcmd
set showmode
set visualbell
set autoread
set backspace=indent,eol,start
set history=1000
set laststatus=2
set showtabline=0

" set colorcolumn=87

set background=dark

" ================ Searching ====================

set ignorecase smartcase
set incsearch
set hlsearch
set nowrapscan

set foldmethod=indent
set foldnestmax=8
set foldenable

" ================ Plugins ====================

call plug#begin(plugins_path)

" environment
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/denite.nvim'

" filebrowser
Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'ryanoasis/vim-devicons'
  
" langs
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'masukomi/vim-markdown-folding'
Plug 'LnL7/vim-nix'
Plug 'vmchale/dhall-vim'
Plug 'cespare/vim-toml'
Plug 'evanleck/vim-svelte'
Plug 'rhysd/vim-grammarous'
Plug 'ron89/thesaurus_query.vim'
Plug 'kevinoid/vim-jsonc'
Plug 'vim-scripts/bash-support.vim'
Plug 'vim-scripts/bats.vim'


" other tools
Plug 'godlygeek/tabular'
Plug 't9md/vim-choosewin'
Plug 'chrisbra/Recover.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colab
Plug 'floobits/floobits-neovim'

call plug#end()

" ============ Other Options ==============

let g:svelte_preprocessors = ['typescript', 'scss']

" ============ Lightline Options ==============

let g:choosewin_overlay_enable = 1
let g:lightline = { 'colorscheme' : 'molokai' }

" ============ Vim Markdown Options ==============

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" ============ Lightline Options ==============

colorscheme molokai_dark

" ================ Indentation ======================

set autoindent smartindent smarttab
set nolist wrap linebreak breakindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
set virtualedit=block

" ================ Scrolling ========================

set scrolloff=1 sidescrolloff=5 sidescroll=1

" ================ Custom Settings ========================
"for fpath in split(globpath($DOT_VIM.'/settings', '*.vim'), '\n')
""	exe 'source' fpath
"endfor

syntax on
let mapleader="\<Space>"

nnoremap <silent> <leader>f za
nnoremap <silent> <leader>t zt

augroup rc_extras 
  au BufNewFile,BufRead *.jazz set filetype=javascript
  au BufNewFile,BufRead *.es set filetype=javascript
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.zsh* set filetype=zsh
  au BufNewFile,BufRead *.zprofile set filetype=zsh
  au BufNewFile,BufRead *.zlog* set filetype=zsh
  au BufNewFile,BufRead *.tsx set filetype=typescript.jsx
augroup END

autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

set statusline^=%{coc#status()}

runtime! defx.vim
runtime! grammarous.vim

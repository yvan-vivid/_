" Yvan Vivid - NEO/VIM RC
set nocompatible

" ================ Paths ====================

let state_path = expand(getenv("DOT_STATE")) . "/nvim"
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

set conceallevel=0
set colorcolumn=87

" ================ Searching ====================

set ignorecase smartcase
set incsearch
set hlsearch
set nowrapscan

" ================ Plugins ====================

"call plug#begin('~/.vim/plugged')

"Plug 'ryanoasis/vim-devicons'
"Plug 'junegunn/vim-easy-align'
"Plug 'scrooloose/nerdtree' 
"Plug 'itchyny/lightline.vim'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --all' }
"Plug 'christoomey/vim-tmux-navigator'
"Plug 'tpope/vim-surround'
"Plug 'mattn/emmet-vim'
"Plug 'keith/tmux.vim'
"Plug 'godlygeek/tabular'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"Plug 'epdtry/neovim-coq'
"Plug 'othree/html5.vim'
"Plug 'tpope/vim-haml'
"Plug 'trefis/coquille'
"Plug 'lervag/vimtex'
"Plug 'hdima/python-syntax'
"Plug 'tpope/vim-obsession'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'tmux-plugins/vim-tmux'
"Plug 'vim-syntastic/syntastic'

"call plug#end()

autocmd BufNewFile,BufRead dot.tmux.conf setfiletype tmux

" ================ Indentation ======================

set autoindent smartindent smarttab
set nolist wrap linebreak breakindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
set virtualedit=block

filetype plugin on
filetype indent on

fu CodingIndents()
	set nowrap list listchars=tab:\|\ 
	set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
endfu

fu LatexIndents()
	set wrap list linebreak listchars=tab:\|\ 
	set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
endfu

fu WritingIndents()
	set nolist wrap linebreak
endfu


" ================ Folds ============================

set foldmethod=indent
set foldnestmax=8
set foldenable

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=1 sidescrolloff=5 sidescroll=1

" ================ Custom Settings ========================
"for fpath in split(globpath($DOT_VIM.'/settings', '*.vim'), '\n')
""	exe 'source' fpath
"endfor

syntax on
let mapleader="\<Space>"

"nnoremap <silent> <leader>d :bp\|bd #<CR>
"nnoremap <silent> <leader>vvj 80i_<ESC>o<ESC>:read !vivid-time today<CR><ESC>IDate <ESC>2o<ESC>

nnoremap <silent> <leader>f za
nnoremap <silent> <leader>t zt

nmap <silent> <C-h> <C-w> l
nmap <silent> <C-j> <C-w> j
nmap <silent> <C-k> <C-w> k
nmap <silent> <C-l> <C-w> l

augroup rc_extras 
  au BufNewFile,BufRead *.jazz set filetype=javascript
  au BufNewFile,BufRead *.es set filetype=javascript
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.zsh* set filetype=zsh
  au BufNewFile,BufRead *.zprofile set filetype=zsh
  au BufNewFile,BufRead *.zlog* set filetype=zsh
augroup END

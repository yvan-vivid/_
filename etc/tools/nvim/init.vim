" Yvan Vivid - NEO/VIM RC
if &compatible
  set nocompatible
endif

" ================ Paths ====================

let config_path = expand(getenv("DOT_ETC")) . "/tools/nvim"
let state_path = expand(getenv("DOT_STATE")) . "/nvim"
let plugins_path = state_path . "/plugins"
let dein_path = plugins_path . "/repos/github.com/Shougo/dein.vim"

exe 'set rtp+=' . dein_path

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

"let g:dein#auto_recache = 1

if dein#load_state(plugins_path)
  call dein#begin(plugins_path)
  call dein#add(dein_path)
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('itchyny/lightline.vim')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('godlygeek/tabular')
  "call dein#add('plasticboy/vim-markdown', { 'depends': 'tabular' })
  call dein#add('neoclide/coc.nvim', {'merged': 0, 'rev': 'release'})
  call dein#add('rhysd/vim-grammarous')
  call dein#add('ron89/thesaurus_query.vim')
  call dein#add('masukomi/vim-markdown-folding')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/defx.nvim')
  call dein#add('kristijanhusak/defx-git')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('t9md/vim-choosewin')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('LnL7/vim-nix')
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" ============ Lightline Options ==============

let g:choosewin_overlay_enable = 1
let g:lightline = { 'colorscheme' : 'molokai' }

" ============ Vim Markdown Options ==============

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" ============ Coc Options ==============

let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'right': {
\      'position': 'right',
\   },
\   'left': {
\      'position': 'right',
\   }
\ }

" ============ Lightline Options ==============

colorscheme molokai_dark

" ================ Indentation ======================

set autoindent smartindent smarttab
set nolist wrap linebreak breakindent
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
set virtualedit=block

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

nnoremap <silent> <leader>f za
nnoremap <silent> <leader>t zt

augroup rc_extras 
  au BufNewFile,BufRead *.jazz set filetype=javascript
  au BufNewFile,BufRead *.es set filetype=javascript
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead *.zsh* set filetype=zsh
  au BufNewFile,BufRead *.zprofile set filetype=zsh
  au BufNewFile,BufRead *.zlog* set filetype=zsh
augroup END

autocmd FileType markdown set foldexpr=NestedMarkdownFolds()

runtime! defx.vim
runtime! grammarous.vim

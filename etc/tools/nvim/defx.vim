augroup vimrc_defx
  autocmd!
  autocmd FileType defx call s:defx_init()
  "autocmd VimEnter * call s:setup_defx()
augroup END

nnoremap <silent><Leader>b :call <sid>defx_inv()<CR>
nnoremap <silent><Leader>B :call <sid>defx_inv_fixed()<CR>

let g:yv#browser_width = 40

let options = {
\ 'columns': 'indent:git:icons:filename:type',
\ 'winwidth': g:yv#browser_width,
\ 'split': 'vertical',
\ 'direction': 'botright',
\ 'show_ignored_files': 0,
\ 'buffer_name': 'defx',
\ 'toggle': 1,
\ 'resume': 1
\ }

let marks = { 'readonly_icon': '', 'selected_icon': '' }
let icons = { 'directory_icon': '▶', 'opened_icon': '▼', 'root_icon': ' ' }

let g:defx_git#indicators = {
\ 'Modified'  : '•',
\ 'Staged'    : '✚',
\ 'Untracked' : 'ᵁ',
\ 'Renamed'   : '≫',
\ 'Unmerged'  : '≠',
\ 'Ignored'   : 'ⁱ',
\ 'Deleted'   : '✖',
\ 'Unknown'   : '⁇'
\ }

call defx#custom#option('_', options)
call defx#custom#column('mark', marks)
call defx#custom#column('icon', icons)
call defx#custom#column('filename', { 'max_width': -90  })

function! s:defx_inv() abort
  Defx -split=floating -winrow=0 -wincol=`&columns - g:yv#browser_width` -winheight=`&lines`
endfunction

function! s:defx_init()
  echom "loading defx actions"
  setl nonumber
  setl norelativenumber
  setl listchars=
  setl nofoldenable
  setl foldmethod=manual

  " disable this mappings
  nnoremap <silent><buffer> <3-LeftMouse> <Nop>
  nnoremap <silent><buffer> <4-LeftMouse> <Nop>
  nnoremap <silent><buffer> <LeftMouse> <LeftMouse><Home>

  silent! nunmap <buffer> <Space>
  silent! nunmap <buffer> <C-l>
  silent! nunmap <buffer> <C-j>
  silent! nunmap <buffer> E
  silent! nunmap <buffer> gr
  silent! nunmap <buffer> gf
  silent! nunmap <buffer> -
  silent! nunmap <buffer> s

  " Define mappings
  nnoremap <silent><buffer><expr> y defx#do_action('copy')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> d defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> h defx#do_action('call', 'DefxSmartH')
  nnoremap <silent><buffer><expr> l defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> <Cr> defx#do_action('call', 'DefxSmartDrop')
  nnoremap <silent><buffer><expr> x defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> yy defx#do_action('call', 'DefxYarkPath')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <C-r> defx#do_action('redraw')
endfunction

function! DefxSmartDrop(_)
  if defx#is_directory()
    call defx#call_action('open_directory')
  else
    call s:defx_open_file()
  endif 
endfunction

function! DefxSmartL(_)
  if defx#is_directory()
    call defx#call_action('open_tree')
    normal! j
  else
    call s:defx_open_file()
  endif
endfunction

function! s:defx_open_file()
  let filepath = defx#get_candidate()['action__path']
  if tabpagewinnr(tabpagenr(), '$') >= 3
    ChooseWin
  else
    exec 'wincmd w'
  endif
  exec 'e' filepath
  Defx
endfunction

function! DefxSmartH(_)
  " if cursor line is first line, or in empty dir
  if line('.') ==# 1 || line('$') ==# 1
    return defx#call_action('cd', ['..'])
  endif

  " candidate is opend tree?
  if defx#is_opened_tree()
    return defx#call_action('close_tree')
  endif

  " parent is root?
  let s:candidate = defx#get_candidate()
  let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
  let sep = '/'
  if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
    return defx#call_action('cd', ['..'])
  endif

  " move to parent.
  call defx#call_action('search', s:parent)

  " if you want close_tree immediately, enable below line.
  call defx#call_action('close_tree')
endfunction

function! DefxYarkPath(_) abort
  let candidate = defx#get_candidate()
  let @+ = candidate['action__path']
  echo 'yanked: ' . @+
endfunction

function! s:trim_right(str, trim)
  return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction

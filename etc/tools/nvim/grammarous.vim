let g:grammarous#languagetool_cmd = 'languagetool-commandline'
let g:grammarous#disabled_rules = {
\ '*' : ['PROFANITY'],
\ 'markdown' : [
\   'MULTIPLICATION_SIGN', 'EN_QUOTES',
\   'IN_THE_MOMENT', 'IN_THIS_MOMENT', 'ADVERB_WORD_ORDER',
\   'NUMEROUS_DIFFERENT', 'PROFANITY'
\ ],
\ }
let g:tq_openoffice_en_file = state_path . "/language/thesaurus/th_en_US_new"
let g:tq_enabled_backends = [ "openoffice_en" ]
let g:tq_language = [ 'en' ]

nmap <leader>ll <Plug>(grammarous-open-info-window)
nmap <leader>ln <Plug>(grammarous-move-to-next-error)
nmap <leader>lp <Plug>(grammarous-move-to-previous-error)

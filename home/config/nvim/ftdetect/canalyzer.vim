let s:fencs = ''
let s:ffs = ''

function! s:canalyzer_pre()
    let s:fencs = &g:fencs
    let s:ff = &g:ffs
    set fencs=cp1252
    set ffs=dos
    setlocal ft=c
endfunction

function! s:canalyzer_post()
    let &g:fencs = s:fencs
    let &g:ffs = s:ffs
endfunction

au BufNewFile *.can,*.cin setlocal ft=c fenc=cp1252 ff=dos
au BufRead *.can,*.cin call s:canalyzer_pre()
au BufReadPost *.can,*.cin call s:canalyzer_post()

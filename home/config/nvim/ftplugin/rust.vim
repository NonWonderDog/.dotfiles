set colorcolumn=100
setlocal foldmethod=expr
setlocal foldexpr=GetRustFold(v:lnum)
setlocal foldlevel=0

function! GetRustFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)

    if getline(a:lnum) =~? '^\s*///.*$'
        return '1'
    endif

    if getline(a:lnum) =~? '^\s*//!.*$'
        return '1'
    endif

    return '0'
endfunction

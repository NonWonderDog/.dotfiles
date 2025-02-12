let s:fencs = ''
let s:ffs = ''

function! s:enc_detect()
    if !exists('b:detected')
        if v:cmdarg !~ '++enc'
            " do detection
            let b:detected = 1
            let line = readfile(expand('%:p'), '', 1)
            let enc = matchlist(line, '\/\*@!Encoding:\(.\{-}\)\*\/')
            if enc != []
                let enc = enc[1]
            endif
            if enc == '1252'
                let enc = 'cp1252'
            elseif enc == '65001'
                let enc = 'utf-8'
            elseif enc == 'ASCII'
                let enc = 'latin1'
            else
                let enc = ''
            endif
            if enc != "" && enc !=? &fenc
                if exists('&autochdir') && &autochdir
                    " Other autocmds may have changed the window's working directory;
                    " when 'autochdir' is set, the :edit will reset that, so
                    " temporarily disable the setting.
                    let old_autochdir = &autochdir
                    set noautochdir
		endif
                try
                    exec 'edit ++enc='.enc.' ++bad=keep'
                finally
                    if exists('old_autochdir')
                        let &autochdir = old_autochdir
                    endif
                endtry
            endif
        endif
    else
        unlet b:detected
    endif
endfunction

au BufRead *.can,*.cin call s:enc_detect() | setlocal ft=c

au BufNewFile *.can,*.cin setlocal ft=c fenc=cp1252 ff=dos
au BufNewFile *.can 0r ~/.config/nvim/skeleton/skeleton.can
au BufNewFile *.cin 0r ~/.config/nvim/skeleton/skeleton.cin

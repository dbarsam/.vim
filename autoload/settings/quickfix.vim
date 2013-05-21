" ===================================================================
"                  QuickFix Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/quickfix.vim
" Purpose:        Custom QuickFix commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Toggle's Vim QuickFix Window for QuickFix and Location List messages
"   l -> location list
"   c -> quickfix list
"
" See http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
" ============
function! settings#quickfix#ToggleList(bufname, prefix)

    redir =>buflist
    silent! ls
    redir END

    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:prefix.'close')
            return
        endif
    endfor

    if a:prefix == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif

    let winnr = winnr()
    exec(a:prefix.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction

" ===================================================================
" End
" ===================================================================

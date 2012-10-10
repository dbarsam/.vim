" ===================================================================
"                  Tags Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/tags.vim
" Purpose:        Custom tag commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Open Tag with Gui Options
" default - open tag as normal
" tab     - open tag in a new tab
" vsplit  - open tag in a new vsplit
" ============
func! settings#tags#TagGUIJump(method) abort
    if a:method == "default"
        exe "tjump ".expand("<cword>")
    elseif a:method == "tab"
        tab split
        exe "tjump ".expand("<cword>")
    elseif a:method == "vsplit"
        vsp
        exe "tjump ".expand("<cword>")
    endif
endfunc

" ===================================================================
" End
" ===================================================================

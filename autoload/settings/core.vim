" ===================================================================
"                  Core Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/core.vim
" Purpose:        Custom core commands the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
 
" ============
" Launches another instance of Vim with the profile report
" ============
function! settings#core#StartupProfile() abort
    if has("startuptime") && has("gui")
        let fname =  "VimStartupProfile_".strftime("%Y%m%d_%H%M").".txt"  
        if isdirectory($TEMP)
            let fname = fnameescape($TEMP . "/". l:fname)
        else
            let fname = fnameescape($HOME . "/". l:fname)
        endif
        exe "!start gvim --startuptime ".l:fname. " ". l:fname
    endif
endfunction

" ============
" Edits the Current Colorscheme file
" ============
function! settings#core#EditColorscheme() abort
    if !exists("g:syntax_on")
        echomsg "Cannot Edit Colorscheme: Syntax coloring is not enable."
    elseif !exists("g:colors_name")
        echomsg "Cannot Edit Colorscheme: Syntax coloring has no color scheme file."
    else
        let colors_file = split(globpath(&rtp, "colors/".g:colors_name.".vim"), '\n')[0]
        if filereadable(l:colors_file)
            if has($VIMFILES) && strridx(l:colors_file, $VIMFILES) != -1
                exe 'confirm edit ' . l:colors_file
            else
                exe 'confirm view ' . l:colors_file
            endif
        endif
    endif
endfunction

" ===================================================================
" End
" ===================================================================

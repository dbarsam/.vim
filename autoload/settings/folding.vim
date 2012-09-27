" ===================================================================
"                 Folding Autoload Fucntions for VIM
" ===================================================================
" File:           autoload/settings/folding.vim
" Purpose:        Folding commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
 
" ============
" Increase the Size of the Folding Column
" ============
func! settings#folding#AdjustFoldingColumnSize(increment) abort
   call settings#folding#SetColumnFoldingSize(&fdc + a:increment)
endfunc

" ============
" Set the Size of the Folding Column
" ============
func! settings#folding#SetColumnFoldingSize(value) abort
   set fdc = a:value
   redraw
   echomsg "Current Folding Column: ". &fdc
endfunc

" ============
" Toggle Folding in the Buffer
" ============
function! settings#folding#ToggleFolding(...) abort
    let l:enable = a:0 == 0 ? !exists("b:local_folding") || (b:local_folding == 0) : a:1

    if l:enable
        exec "normal! zM" 
        let b:local_folding = 1 
    else 
        exec "normal! zR" 
        let b:local_folding = 0 
    endif
endf

" ===================================================================
" End
" ===================================================================

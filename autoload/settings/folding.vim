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
" Set the Size of the Folding Column via Prompt
" ============
func! settings#folding#SetColumnFoldingSizePrompt() abort
    let newsize = str2nr(inputdialog("Enter a Folding Column Size...", &fdc))
    if l:newsize != 0
        call settings#folding#SetColumnFoldingSize(newsize)
    endif
endfun

" ============
" Set the Size of the Folding Column
" ============
func! settings#folding#SetColumnFoldingSize(value) abort
   set fdc = a:value
   redraw
   echomsg "Current Folding Column: ". &fdc
endfunc

" ============
" Set the Folding Method
" ============
function! settings#folding#SetFoldingMethod(name) abort
   set fdm = a:name
   redraw
   echomsg "Current Folding Method ". &fdm
endfunc

" ============
" Set the Folding Method via Prompt
" ============
function! settings#folding#SetFoldingMethodPrompt() abort
    let list = ['Select a Folding Method',
                \ '1. Manual',
                \ '2. Indent',
                \ '3. Expr',
                \ '4. Syntax',
                \ '5. Diff',
                \ '6. Marker']
    let choice = inputlist(l:list)
    if choice != 0
        call settings#folding#SetFoldingMethod(strpart(tolower(l:list[l:choice]), 3))
    endif
endfunction

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

" ===================================================================
"                      Folding Commands for VIM
" ===================================================================
" File:           settings/folding.vim
" Purpose:        Folding commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_folding_plugin')  || !has("folding")
   finish 
endif 
let g:loaded_settings_folding_plugin = 1

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
com! -bar -nargs=? ToggleFolding             call settings#folding#ToggleFolding(<f-args>)

com! -bar -nargs=1 FoldingMethod             set fdm=<args>
com! -bar -nargs=1 FoldingColumnWidth        call settings#folding#SetColumnFoldingSize(<f-args>)
com! -bar -nargs=1 FoldingColumnWidthAdjust  call settings#folding#AdjustFoldingColumnSize(<f-args>)

" ============
" Plugin Mapping
" ============
" Folding Navigation
nnoremap <Plug>FoldPrev                 zk
nnoremap <Plug>FoldNext                 zj

" Folding Toggling
nnoremap <Plug>FoldingToggleFolds       zi
nnoremap <Plug>FoldingOpenAtCursor      zv
nnoremap <Plug>FoldingOpenAtCursorOnly  zMzx
nnoremap <Plug>FoldingClose             zm
nnoremap <Plug>FoldingCloseAll          zM
nnoremap <Plug>FoldingOpen              zr
nnoremap <Plug>FoldingOpenAll           zR

" Folding Creation
vnoremap <Plug>FoldingCreate            zf
nnoremap <Plug>FoldingDelete            zd
nnoremap <Plug>FoldingDeleteAll         zD

" Folding Method
nnoremap <Plug>FoldingMethodManual      :FoldingMethod manual<CR>
nnoremap <Plug>FoldingMethodIndent      :FoldingMethod indent<CR>
nnoremap <Plug>FoldingMethodExpression  :FoldingMethod expr<CR>
nnoremap <Plug>FoldingMethodSyntax      :FoldingMethod syntax<CR>
nnoremap <Plug>FoldingMethodDiff        :FoldingMethod diff<CR>
nnoremap <Plug>FoldingMethodMarker      :FoldingMethod marker<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

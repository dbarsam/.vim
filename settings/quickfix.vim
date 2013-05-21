" ===================================================================
"                        QuickFix Commands for VIM
" ===================================================================
" File:           settings/quickfix.vim
" Purpose:        Custom quickfix commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_quickfix_plugin')
   finish 
endif 
let g:loaded_settings_quickfix_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
" QuickFix Navigation Commands
command! -bar          QFOpen             copen
command! -bar          QFClose            cclose
command! -bar -nargs=? QFGoToNext         <args>cnext
command! -bar -nargs=? QFGoToPrev         <args>cprev
 
" QuickFix Window Commands
com! -bar -nargs=0 ToggleQuickFixList     call settings#quickfix#ToggleList("Quickfix List", 'c')
com! -bar -nargs=0 ToggleLocationList     call settings#quickfix#ToggleList("Location List", 'l')

" ============
" Plugin Mapping
" ============
" Quick Edit and Reload Commands
nnoremap <Plug>QuickFixClose              :QFClose<CR>
nnoremap <Plug>QuickFixOpen               :QFOpen<CR>

nnoremap <Plug>QuickFixGoToNext           :QFGoToNext<CR>
nnoremap <Plug>QuickFixGoToPrev           :QFGoToPrev<CR>

nnoremap <Plug>QuickFixToggleQuickFixList :ToggleQuickFixList<CR>
nnoremap <Plug>QuickFixToggleLocationList :ToggleLocationList<CR>

" ============
" Auto Commands for AutoUpdate
" ============" 
augroup QuickFixMode
    au!
    autocmd BufReadPost quickfix           map <buffer> q <Plug>QuickFixClose
augroup END

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

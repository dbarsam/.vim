" ===================================================================
"                      KeepCase Settings for VIM
" ===================================================================
" File:           settings/keepcase.vim
" Purpose:        Custom settings for the KeepCase plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_keepcase_plugin')
   finish 
endif 
let g:loaded_settings_keepcase_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
command! -nargs=1 -range S <line1>,<line2>SubstituteCase <args>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

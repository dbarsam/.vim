" ===================================================================
"                      ShowMarks Settings for VIM
" ===================================================================
" File:           settings/showmarks.vim
" Purpose:        Custom settings for the ShowMarks plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_showmarks_plugin')
   finish 
endif 
let g:loaded_settings_showmarks_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:showmarks_auto_toggle = 0
let g:showmarks_ignore_type = "hpr"

" ============
" Syntax Highlighting
" ============
" For marks a-z
hi link ShowMarksHLl  SignColumn  
" For marks A-Z
hi link ShowMarksHLu  SignColumn
" For all other marks
hi link ShowMarksHLo  SignColumn
" For multiple marks on the same line.
hi link ShowMarksHLm  SignColumn

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

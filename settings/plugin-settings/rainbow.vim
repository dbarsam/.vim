" ===================================================================
"                      Rainbow Settings for VIM
" ===================================================================
" File:           settings/rainbow.vim
" Purpose:        Custom settings for the Rainbow plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_rainbow_plugin')
   finish 
endif 
let g:loaded_settings_rainbow_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Settings
" ============
let g:rainbow_filetype_matchpairs = {
            \ '*'    : [['(', ')'], ['\[', '\]'], ['{', '}'], ['<', '>']]
            \}

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

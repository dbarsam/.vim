" ===================================================================
"                      LargeFile Settings for VIM
" ===================================================================
" File:           settings/largefile.vim
" Purpose:        Custom settings for the LargeFile plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_largefile_plugin')
   finish 
endif 
let g:loaded_settings_largefile_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
" Threshold (in MB) to turn on LargeFile processing
let g:LargeFile = 100

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

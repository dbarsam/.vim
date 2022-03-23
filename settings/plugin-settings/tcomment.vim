" ===================================================================
"                      TComment Settings for VIM
" ===================================================================
" File:           settings/tcomment.vim
" Purpose:        Custom settings for the TComment plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_tcomment_plugin')
   finish 
endif 
let g:loaded_settings_tcomment_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" Replace 'g' with our mapleader
let g:tcomment_opleader1 = g:mapleader . "c"

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

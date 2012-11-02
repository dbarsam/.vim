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
let g:tcommentMapLeaderOp1 = g:mapleader . "c"
let g:tcommentMapLeaderOp2 = g:mapleader . "C"

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

" ===================================================================
"                      TailBundle Settings for VIM
" ===================================================================
" File:           settings/tailbundle.vim
" Purpose:        Custom settings for the TailBundle plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_tailbundle_plugin')
   finish 
endif 
let g:loaded_settings_tailbundle_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:Tail_Height = 10
let g:Tail_Center_Win = 0

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

" ===================================================================
"                      BufKill Settings for VIM
" ===================================================================
" File:           settings/bufkill.vim
" Purpose:        Custom settings for the BufKill plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_bufkill_plugin')
   finish 
endif 
let g:loaded_settings_bufkill_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:BufKillCreateMappings = 0

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

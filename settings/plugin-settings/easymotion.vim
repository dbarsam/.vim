" ===================================================================
"                      EasyMotion Settings for VIM
" ===================================================================
" File:           settings/easymotion.vim
" Purpose:        Custom settings for the EasyMotion plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_easymotion_plugin')
   finish 
endif 
let g:loaded_settings_easymotion_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:EasyMotion_leader_key = '<Leader>g'

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

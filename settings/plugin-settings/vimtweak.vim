" ===================================================================
"                     VimTweak Settings for VIM
" ===================================================================
" File:           settings/vimtweaks.vim
" Purpose:        Custom settings for the vimtweak plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_vimtweak_plugin')
   finish 
endif 
let g:loaded_settings_vimtweak_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:vimtweak_focus_transparency_gained_value = 0
let g:vimtweak_focus_transparency_lost_value = 0
let g:vimtweak_focus_transparency = 0

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

" ===================================================================
"                      ZoomWin Settings for VIM
" ===================================================================
" File:           settings/zoomwin.vim
" Purpose:        Custom settings for the ZoomWin plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_zoomwin_plugin')
   finish 
endif 
let g:loaded_settings_zoomwin_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Mapping
" ============
nmap <leader>wo <Plug>ZoomWin

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

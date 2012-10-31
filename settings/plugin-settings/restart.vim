" ===================================================================
"                      Restart Settings for VIM
" ===================================================================
" File:           settings/restart.vim
" Purpose:        Custom settings for the Restart plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_restart_plugin')
   finish 
endif 
let g:loaded_settings_restart_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Menu Configuration
" ============
amenu 10.690 &File.-SEPRESTART-         <Nop>
amenu 10.691 &File.Restart\.\.\.        :Restart<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

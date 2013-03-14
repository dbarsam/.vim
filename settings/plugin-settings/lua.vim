" ===================================================================
"                      Lua Settings for VIM
" ===================================================================
" File:           settings/lua.vim
" Purpose:        Custom settings for the Lua plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_lua_plugin')
   finish 
endif 
let g:loaded_settings_lua_plugin = 1 

" ============
" Plugin Requirements
" ============
" Plugin is only valid if the following programs are installed:
if !executable("luac")
    finish
endif

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

let g:lua_compiler_name = 'luac'

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

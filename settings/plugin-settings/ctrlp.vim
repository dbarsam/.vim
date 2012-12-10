" ===================================================================
"                      CtrlP Settings for VIM
" ===================================================================
" File:           settings/ctrlp.vim
" Purpose:        Custom settings for the CtrlP plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_ctrlp_plugin')
   finish 
endif 
let g:loaded_settings_ctrlp_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }

let g:ctrlpMapLeaderOp2 = g:mapleader . "C"
let g:ctrlp_cache_dir = '$VIMFILES/.ctrlp'

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

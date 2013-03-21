" ===================================================================
"                ViM DosIni File Type Plugin for VIM
" ===================================================================
" File:           after/ftplugin/dosini.vim
" Purpose:        Additional settings for ViM's DosIni ftplugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
" Based On:       http://vim.wikia.com/wiki/Dosini_files
" ===================================================================
if exists("b:did_ftplugin_after")
    finish
endif
let b:did_ftplugin_after = 1

" ============
" Disable Compatibility Options
" ============
let s:cpo_save=&cpo
set cpo&vim

" ============
" Plugin Settings
" ============
" Folding Sections By Syntax - see after/syntax/dosini.vim
setlocal foldlevel=20       " Open all folds on start-up
setlocal foldmethod=syntax

" ============
" Restore Compatibility Options
" ============
let &cpo = s:cpo_save
unlet s:cpo_save

" ===================================================================
" End
" ===================================================================

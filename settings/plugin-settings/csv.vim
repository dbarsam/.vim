" ===================================================================
"                      CSV Settings for VIM
" ===================================================================
" File:           settings/csv.vim
" Purpose:        Custom settings for the CSV plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_csv_plugin')
   finish 
endif 
let g:loaded_settings_csv_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:CSVCreateMappings = 0
let g:csv_nl = 0

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

" ===================================================================
"                      BufExplorer Settings for VIM
" ===================================================================
" File:           settings/bufexplorer.vim
" Purpose:        Custom settings for the BufExplorer plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_bufexplorer_plugin')
   finish 
endif 
let g:loaded_settings_bufexplorer_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:bufExplorerDefaultHelp = 1           " Show default help?
let g:bufExplorerDetailedHelp = 0          " Show detailed help?
let g:bufExplorerFindActive = 1            " When selecting an active buffer, take you to the window where it is active?
let g:bufExplorerReverseSort = 0           " sort reverse?
let g:bufExplorerShowDirectories = 1       " (Dir's are added by commands like ':e .')
let g:bufExplorerShowRelativePath = 0      " Show listings with relative or absolute paths?
let g:bufExplorerShowUnlisted = 1          " Show unlisted buffers?
let g:bufExplorerSortBy = "mru"            " Sorting methods are in s:sort_by:
let g:bufExplorerSplitOutPathName = 1      " Split out path and file name?
let g:bufExplorerSplitRight = &splitright  " Should vertical splits be on the right or left of current window?
let g:bufExplorerSplitBelow = &splitbelow  " Should horizontal splits be below or above current window?

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

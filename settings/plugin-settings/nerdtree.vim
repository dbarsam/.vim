" ===================================================================
"                      NERDTree Settings for VIM
" ===================================================================
" File:           settings/nerdtree.vim
" Purpose:        Custom settings for the NERDTree plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_nerdtree_plugin')
   finish 
endif 
let g:loaded_settings_nerdtree_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Settings
" ============
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=[]
if exists("$VIMFILES")
    let g:NERDTreeBookmarksDirectory=expand('$VIMFILES/.nerdtree')
    if !isdirectory(g:NERDTreeBookmarksDirectory) && exists("*mkdir")
        call mkdir(g:NERDTreeBookmarksDirectory)
    endif
    let g:NERDTreeBookmarksFile=g:NERDTreeBookmarksDirectory . '/bookmarks.txt'
endif


" ============
" Plugin Mapping
" ============
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

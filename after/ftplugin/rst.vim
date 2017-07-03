" ===================================================================
"              Git Commit File Settings for ViM Files
" ===================================================================
" File:           after/ftplugin/rst.vim
" Purpose:        Additional settings for ViM's restructuredtext ftplugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists("b:did_ftplugin_after")
    finish
endif
let b:did_ftplugin_after = 1

" Enable Spell Checking
setlocal spell

" ===============
" Plugin Mappings
" ===============
nnoremap <buffer> <leader>h1 ^yypv$r#yykP
nnoremap <buffer> <leader>h2 ^yypv$r*yykP
nnoremap <buffer> <leader>h3 ^yypv$r=
nnoremap <buffer> <leader>h4 ^yypv$r-
nnoremap <buffer> <leader>h5 ^yypv$r^
nnoremap <buffer> <leader>h6 ^yypv$r"

" ===================================================================
" End
" ===================================================================


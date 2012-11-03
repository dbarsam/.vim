" ===================================================================
"                       FileType File for VIM
" ===================================================================
" File:           filetype.vim
" Purpose:        Custom Filetypes for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
"
if exists("did_load_filetypes")
    finish
endif

" Vim support file to detect file types
augroup filetypedetect
    au! BufRead,BufNewFile *.mold	setfiletype cs
augroup END

" ===================================================================
" End
" ===================================================================
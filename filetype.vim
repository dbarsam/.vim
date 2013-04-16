" ===================================================================
"                       FileType File for VIM
" ===================================================================
" File:           filetype.vim
" Purpose:        Custom Filetypes for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

if exists("did_load_filetypes")
    finish
endif

" Vim support file to detect file types
augroup filetypedetect
    au! BufRead,BufNewFile *.as         setfiletype actionscript    
    au! BufRead,BufNewFile *.mxml       setfiletype mxml
    au! BufRead,BufNewFile *.mold       setfiletype cs
    au! BufRead,BufNewFile *.build      setfiletype xml
    au! BufRead,BufNewFile *.u3i        setfiletype xml
    au! BufRead,BufNewFile *.hta        setfiletype wsh
    au! BufRead,BufNewFile *.dspkg      setfiletype dosini
    au! BufRead,BufNewFile *.jsx        setfiletype javascript
    au! BufRead,BufNewFile *.wiki       setfiletype confluencewiki    
    au! BufRead,BufNewFile *.sharpmake  setfiletype cs    
augroup END

" ===================================================================
" End
" ===================================================================

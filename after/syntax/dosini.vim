" ===================================================================
"                ViM DosIni Syntax Plugin for VIM
" ===================================================================
" File:           after/syntax/dosini.vim
" Purpose:        Additional settings for ViM's DosIni Syntax
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
" Based On:       http://vim.wikia.com/wiki/Dosini_files
" ===================================================================
if exists("b:did_syntax_after")
    finish
endif
let b:did_syntax_after = 1

" ============
" Disable Compatibility Options
" ============
let s:cpo_save=&cpo
set cpo&vim

" ============
" Plugin Syntax
" ============
" Modify existing for synta groups for Heredoc highlighting
syn match  dosiniComment        "^;.*$\|^#.*$"
syn match  dosiniLabel          "^\s\+ ="

" Handle heredoc syntax in the dosini syntax. (Taken from syntax/perl.ini (:%s/perl/dosini/g))
if exists("dosini_string_as_statement")
  HiLink dosiniStringStartEnd   dosiniStatement
else
  HiLink dosiniStringStartEnd   dosiniString
endif
HiLink dosiniHereDoc dosiniString

syn region dosiniHereDoc matchgroup=dosiniStringStartEnd start=+<<\z(\I\i*\)+      end=+^\z1$+ contains=@dosiniInterpDQ
syn region dosiniHereDoc matchgroup=dosiniStringStartEnd start=+<<\s*"\z(.\{-}\)"+ end=+^\z1$+ contains=@dosiniInterpDQ
syn region dosiniHereDoc matchgroup=dosiniStringStartEnd start=+<<\s*'\z(.\{-}\)'+ end=+^\z1$+ contains=@dosiniInterpSQ
syn region dosiniHereDoc matchgroup=dosiniStringStartEnd start=+<<\s*""+           end=+^$+    contains=@dosiniInterpDQ,dosiniNotEmptyLine
syn region dosiniHereDoc matchgroup=dosiniStringStartEnd start=+<<\s*''+

" Update Section Syntax for Folding
syn region dosiniSection 
            \ start="^\[" 
            \ end="\(\n\+\[\)\@=" 
            \ contains=dosiniLabel,dosiniHeader,dosiniComment
            \ keepend
            \ fold

" ============
" Restore Compatibility Options
" ============
let &cpo = s:cpo_save
unlet s:cpo_save

" ===================================================================
" End
" ===================================================================

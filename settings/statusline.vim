" ===================================================================
"         ViM StatusLine, Title, and Ruler Commands for VIM
" ===================================================================
" File:           settings/statusline.vim
" Purpose:        Vim statusline commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_statusline_plugin')
   finish 
endif 
let g:loaded_settings_statusline_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
" Status Lines
let g:StatusLines = {}
let g:StatusLines['default']  = ""
let g:StatusLines['default'] .= "[%3.3n"                                " buffer number
let g:StatusLines['default'] .= "%H%M%R%W]"                             " flags
let g:StatusLines['default'] .= "\ %t"                                  " file name
let g:StatusLines['default'] .= "\ %<"                                  " truncate marker
let g:StatusLines['default'] .= "%="                                    " right align marker
let g:StatusLines['default'] .= "(%3l,%3c%V)"                           " line & column
let g:StatusLines['default'] .= "\ [%{settings#statusline#FileType()}," " custom filetype
let g:StatusLines['default'] .= "%{&fileencoding},"                     " file encoding
let g:StatusLines['default'] .= "%{&fileformat},"                       " file format
let g:StatusLines['default'] .= "%L]"                                   " number of lines
let g:StatusLines['default'] .= "\ %3.p%%"                              " percentage of buffer

" Ruler Formats
let g:RulerFormats            = {}
let g:RulerFormats['default'] = ""

" Title Strings
let g:TitleStrings            = {}
let g:TitleStrings['default']  = ""
let g:TitleStrings['default'] .= "%t"                                   " file name
let g:TitleStrings['default'] .= "%(\ %M%)"                             " flags 
let g:TitleStrings['default'] .= "%(\ (%<%{expand(\"%:~:p:h\")})%)"     " full path and filename

let g:TitleStrings['network']  = ""
let g:TitleStrings['network'] .= "%{$USERNAME}@%{$USERDOMAIN}:\ "     " user@domain
let g:TitleStrings['network'] .= g:TitleStrings['default']

" ============
" Plugin Commands
" ============
com! -nargs=1 EnableTitle           call settings#statusline#EnableTitleString(<f-args>)
com! -nargs=1 EnableRuler           call settings#statusline#EnableRuler(<f-args>)
com! -nargs=1 EnableStatusLine      call settings#statusline#EnableStatusLine(<f-args>)

" ============
" AutoGroup Settings
" ============
augroup StatuslineGroup
    au!
    " Update the Current Window when we enter it.
    auto BufWinEnter *              call settings#statusline#UpdateWindow()
augroup END

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================


" ===================================================================
"                      TagBar Settings for VIM
" ===================================================================
" File:           settings/tagbar.vim
" Purpose:        Custom settings for the TagBar plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_tagbar_plugin')
   finish 
endif 
let g:loaded_settings_tagbar_plugin = 1 

" ============
" Plugin Requirements
" ============
" Plugin is only valid if the following programs are installed:
if !executable("ctags")
    finish
endif

runtime settings/statusline.vim

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

let g:tagbar_width = 50
let g:tagbar_usearrows = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" ============
" Plugin Mapping
" ============
map <leader>tb :TagbarToggle<CR>

" ============
" Status Line and Title String
" ============
if exists("g:StatusLines")
    let g:StatusLines['tagbar']  = ""
    let g:StatusLines['tagbar'] .= '[%3.3n'                                " buffer number
    let g:StatusLines['tagbar'] .= '%H%M%R%W]'                             " flags
    let g:StatusLines['tagbar'] .= ' '
    let g:StatusLines['tagbar'] .= '%t'                                    " file name
    let g:StatusLines['tagbar'] .= ' '
    let g:StatusLines['tagbar'] .= '%<'                                    " truncate marker
    let g:StatusLines['tagbar'] .= "[%{tagbar#currenttag('%s','')}]"       " TagBar Plugin TagName
    let g:StatusLines['tagbar'] .= '%='                                    " right align marker
    let g:StatusLines['tagbar'] .= '(%3l,%3c%V)'                           " line & column
    let g:StatusLines['tagbar'] .= ' '
    let g:StatusLines['tagbar'] .= '[%{settings#statusline#FileType()},'   " custom filetype
    let g:StatusLines['tagbar'] .= '%{&fileencoding},'                     " file encoding
    let g:StatusLines['tagbar'] .= '%{&fileformat},'                       " file format
    let g:StatusLines['tagbar'] .= '%L]'                                   " number of lines
    let g:StatusLines['tagbar'] .= ' '
    let g:StatusLines['tagbar'] .= '%3.p%%'                                " percentage of buffer
endif

if exists("g:TitleStrings")
    let g:TitleStrings['tagbar']  =""
    let g:TitleStrings['tagbar'] .='%t'                               " file name
    let g:TitleStrings['tagbar'] .='%(\ %M%)'                         " flags
    let g:TitleStrings['tagbar'] .=' '
    let g:TitleStrings['tagbar'] .="%{tagbar#currenttag('%s','')}"    " TagBar Plugin TagName
    let g:TitleStrings['tagbar'] .='%(\ (%<%{expand(\"%:~:p:h\")})%)' " full path and filename
endif

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

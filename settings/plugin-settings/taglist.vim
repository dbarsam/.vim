" ===================================================================
"                      TagList Settings for VIM
" ===================================================================
" File:           settings/taglist.vim
" Purpose:        Custom settings for the TagList plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_taglist_plugin')
   finish 
endif 
let g:loaded_settings_taglist_plugin = 1 

" ============
" Plugin Requirements
" ============
" Plugin is only valid if the following programs are installed:
" (The plugin with complain quite verbosely, otherwise)
if !executable("ctags")
    let g:loaded_taglist = "no"
    finish
endif

runtime settings/statusline.vim

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:Tlist_WinWidth = 50
let g:Tlist_Show_Menu = 0               " Show the TagList Menu
let g:Tlist_Show_One_File = 0           " Show one file in the TagList Menu
let g:Tlist_Close_On_Select = 1         " Close on Select

" ============
" Plugin Mapping
" ============
map <leader>t :TlistToggle<CR>

" ============
" Status Line and Title String
" ============
if exists("g:StatusLines")
    let g:StatusLines['taglist']  = ""
    let g:StatusLines['taglist'] .= '[%3.3n'                                " buffer number
    let g:StatusLines['taglist'] .= '%H%M%R%W]'                             " flags
    let g:StatusLines['taglist'] .= ' '
    let g:StatusLines['taglist'] .= '%t'                                    " file name
    let g:StatusLines['taglist'] .= ' '
    let g:StatusLines['taglist'] .= '%<'                                    " truncate marker
    let g:StatusLines['taglist'] .='(%{Tlist_Get_Tagname_By_Line()})'       " TagList Plugin TagName
    let g:StatusLines['taglist'] .= '%='                                    " right align marker
    let g:StatusLines['taglist'] .= '(%3l,%3c%V)'                           " line & column
    let g:StatusLines['taglist'] .= ' '
    let g:StatusLines['taglist'] .= '[%{settings#statusline#FileType()},'   " custom filetype
    let g:StatusLines['taglist'] .= '%{&fileencoding},'                     " file encoding
    let g:StatusLines['taglist'] .= '%{&fileformat},'                       " file format
    let g:StatusLines['taglist'] .= '%L]'                                   " number of lines
    let g:StatusLines['taglist'] .= ' '
    let g:StatusLines['taglist'] .= '%3.p%%'                                " percentage of buffer
endif

if exists("g:TitleStrings")
    let g:TitleStrings['taglist']  =""
    let g:TitleStrings['taglist'] .='%t'                               " file name
    let g:TitleStrings['taglist'] .='%(\ %M%)'                         " flags
    let g:TitleStrings['taglist'] .=' '
    let g:TitleStrings['taglist'] .='%{Tlist_Get_Tagname_By_Line()}'   " TagList Plugin TagName
    let g:TitleStrings['taglist'] .='%(\ (%<%{expand(\"%:~:p:h\")})%)' " full path and filename
endif

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 

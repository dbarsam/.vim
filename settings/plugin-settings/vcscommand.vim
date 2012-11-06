" ===================================================================
"                    VCSCommand Settings for VIM
" ===================================================================
" File:           settings/vcscommand.vim
" Purpose:        Custom settings for the VCSCommand plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_vcscommand_plugin')
   finish 
endif 
let g:loaded_settings_vcscommand_plugin = 1 

" ============
"  Plugin Requirements
" ============
" Plugin is only valid if the following programs are installed:
if !(executable("git") || executable("svn") || executable("svk") || executable("vcs") || executable("bzr") ||  executable("hg"))
    let VCSCommandDisableAll = 1
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
let VCSCommandMapPrefix    = "<leader>vcs"
let VCSCommandMenuRoot     = "&File.VCS"
let VCSCommandMenuPriority = "10.455"

" Enable this for VCSCommandGetStatusLine to be usefule
let VCSCommandEnableBufferSetup = 0

" ============
" Status Line and Title String
" ============

if exists("g:StatusLines")
    let g:StatusLines['vcs']  = ""
    let g:StatusLines['vcs'] .= '[%3.3n'                              " buffer number
    let g:StatusLines['vcs'] .= '%H%M%R%W]'                           " flags
    let g:StatusLines['vcs'] .= ' '
    let g:StatusLines['vcs'] .= '%t'                                  " file name
    let g:StatusLines['vcs'] .= ' '
    let g:StatusLines['vcs'] .= '%<'                                  " truncate marker
    let g:StatusLines['vcs'] .= '%='                                  " right align marker
    let g:StatusLines['vcs'] .= '(%3l,%3c%V)'                         " line & column
    let g:StatusLines['vcs'] .= '%{VCSCommandGetStatusLine()}'
    let g:StatusLines['vcs'] .= ' '
    let g:StatusLines['vcs'] .= '[%{settings#statusline#FileType()},' " custom filetype
    let g:StatusLines['vcs'] .= '%{&fileencoding},'                   " file encoding
    let g:StatusLines['vcs'] .= '%{&fileformat},'                     " file format
    let g:StatusLines['vcs'] .= '%L]'                                 " number of lines
    let g:StatusLines['vcs'] .= ' '
    let g:StatusLines['vcs'] .= '%3.p%%'                              " percentage of buffer
endif

if exists("g:TitleStrings")
    let g:TitleStrings['vcs']  = ""
    let g:TitleStrings['vcs'] .='%t'                                  " file name
    let g:TitleStrings['vcs'] .='%(\ %M%)'                            " flags
    let g:TitleStrings['vcs'] .=' '
    let g:TitleStrings['vcs'] .='%{VCSCommandGetStatusLine()}'
    let g:TitleStrings['vcs'] .='%(\ (%<%{expand(\"%:~:p:h\")})%)'    " full path and filename
endif

" ============
" Menu Configuration
" ============
" Adjust our Menus to Accomodate the VCS Menus
an 10.450 &File.-SEP_SCM-	<Nop>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

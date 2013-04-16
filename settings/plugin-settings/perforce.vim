" ===================================================================
"                      Perforce Settings for VIM
" ===================================================================
" File:           settings/perforce.vim
" Purpose:        Custom settings for the Perforce plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_perforce_plugin')
   finish 
endif 
let g:loaded_settings_perforce_plugin = 1 

" ============
"  Plugin Requirements
" ============
" Plugin is only valid if the p4 is installed:
if !executable("p4")
    let loaded_perforce = 1
    let loaded_perforcemenu = 1
    let no_perforce_maps = 1    
    finish
endif

runtime settings/statusline.vim

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Functions
" ============
function! s:P4QueryInfo(...)
    let l:output = system("p4 set")
    if (a:0 == 0)
        return matchstr(l:output, 'P4PORT=\zs\S*\ze\s(set)') . " " . matchstr(l:output, 'P4CLIENT=\zs\S*\ze\s(set)') . " " . matchstr(l:output, 'P4USER=\zs\S*\ze\s(set)')
    else
        return matchstr(l:output,  a:1.'=\zs\S*\ze\s(set)')
    endif
endfunction

" ============
" Plugin Data
" ============
" Settings local to the machine, usually consisting of the following lines:
"   let g:p4Presets = '<port> <client> <user>, <port> <client> <user>, etc"
"   let g:p4DefaultPreset = 0
let $VIMP4=expand($VIMFILES."/.perforce/p4presets.txt")

if filereadable($VIMP4)
    let s:p4PresetData = readfile($VIMP4)
    let g:p4Presets = s:p4PresetData[0]
    let g:p4DefaultPreset = str2nr(s:p4PresetData[1])
    unlet s:p4PresetData
else
    if exists("$P4PORT") && exists("$P4CLIENT") && exists("P4USER")
        let g:p4Presets = $P4PORT." ".$P4CLIENT." ".$P4USER
        let g:p4DefaultPreset = 0
    else
        let g:p4Presets = <SID>P4QueryInfo()
        let g:p4DefaultPreset = 0
    endif

    if !empty(g:p4Presets)
        let s:p4dir = fnamemodify(expand($VIMP4), ':p:h')
        if !isdirectory(s:p4dir)
            call mkdir(s:p4dir)
        endif
        call writefile([g:p4Presets, g:p4DefaultPreset], $VIMP4)
    endif
endif

" Plugin Settings
let g:p4UseGUIDialogs = 1               " Use GUI Prompts when available
let g:p4PromptToCheckout = 1            " Prompt when editing a controlled files
let g:p4CheckOutDefault = 2             " Default to 'No' on checkout prompts

" Menu Configuration
let g:p4EnableMenu = 1
let g:p4UseExpandedMenu = 1
let g:p4EnablePopupMenu = 1
let g:p4UseExpandedPopupMenu = 0

" ============
" Menu Configuration
" ============
" Adjust our Menus to Accomodate the VCS Menus
an 10.450 &File.-SEP_SCM-   <Nop>
let g:p4MenuRoot = "10.455 &File."      " The Parent Menu for Menubar Perforce Menu

an 1.57 PopUp.-SEP_SCM-     <Nop>
let g:p4PopupMenuRoot = "1.56 PopUp."   " The Parent Menu for Popup Perforce Menu

" ============
" Status Line and Title String
" ============
if exists("g:StatusLines")
    let g:StatusLines['perforce']  = ""
    let g:StatusLines['perforce'] .= '[%3.3n'                              " buffer number
    let g:StatusLines['perforce'] .= '%H%M%R%W]'                           " flags
    let g:StatusLines['perforce'] .= ' '
    let g:StatusLines['perforce'] .= '%t'                                  " file name
    let g:StatusLines['perforce'] .= ' '
    let g:StatusLines['perforce'] .= '%<'                                  " truncate marker
    let g:StatusLines['perforce'] .= '%='                                  " right align marker
    let g:StatusLines['perforce'] .= '(%3l,%3c%V)'                         " line & column
    let g:StatusLines['perforce'] .=' %{perforce#RulerStatus()}'           " Perforce Plugin status line
    let g:StatusLines['perforce'] .= ' '
    let g:StatusLines['perforce'] .= '[%{settings#statusline#FileType()},' " custom filetype
    let g:StatusLines['perforce'] .= '%{&fileencoding},'                   " file encoding
    let g:StatusLines['perforce'] .= '%{&fileformat},'                     " file format
    let g:StatusLines['perforce'] .= '%L]'                                 " number of lines
    let g:StatusLines['perforce'] .= ' '
    let g:StatusLines['perforce'] .= '%3.p%%'                              " percentage of buffer
endif

if exists("g:TitleStrings")
    let g:TitleStrings['perforce']  = ""
    let g:TitleStrings['perforce'] .='%t'                                  " file name
    let g:TitleStrings['perforce'] .='%(\ %M%)'                            " flags
    let g:TitleStrings['perforce'] .=' '
    let g:TitleStrings['perforce'] .='%{perforce#RulerStatus()}'           " Perforce Plugin status linee
    let g:TitleStrings['perforce'] .='%(\ (%<%{expand(\"%:~:p:h\")})%)'    " full path and filename
endif

" ============
" Auto Command Group
" ============
augroup PerforceAuxGroup
    au!
    " Additional Perforce Plugin Vim Utilities
    auto VimEnter * runtime perforce/perforceutils.vim
    auto VimEnter * runtime perforce/perforcemenu.vim
augroup END

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

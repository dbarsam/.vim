" ===================================================================
"                ViM Option Autoload Function for VIM
" ===================================================================
" File:           autoload/settings/core.vim
" Purpose:        Vim Option commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Toggle the Indenting Modes
" ============
func! settings#options#ToggleIndentModes() abort
   if (&cin && !(&ai || &si))
      set noai nosi nocin
      echo "Auto Indent: None"
   elseif (!(&ai || &cin || &si))
      set ai nosi nocin
      echo "Auto Indent: Normal"
   elseif (&si && !(&cin || &ai))
      set noai nosi cin
      echo "Auto Indent: C-Style"
   else
      set noai si nocin
      echo "Auto Indent: Smart"
   endif
endf

" ============
" Toggle Search Highlighting
" ============
func! settings#options#ToggleSearchHighlighting() abort
   set hls!
   echo "Search Highlight: " . strpart("OffOn", 3 * &hlsearch, 3)
endf

" ============
" Toggle Searching Modes
" ============
func! settings#options#ToggleCaseSensitiveSearching() abort   
   if (&scs && !&ic)
      set noic noscs
      echo "Case Sensitive Searching: On"
   elseif !(&scs || &ic)
      set ic noscs
      echo "Case Sensitive Searching: Off"
   else
      set noic scs
      echo "Case Sensitive Searching: Smart Case"
   endif
endf

" ============
" Toggle Text Wrapping
" ============
func! settings#options#ToggleTextWrap() abort
    set wrap!
    echo "Text Wrap: " . strpart("OffOn", 3 *&wrap, 3)
endf

" ============
" Toggle Reveal Characters
" ============
func! settings#options#ToggleRevealCharacters() abort
   set list!
   echo "Reveal Characters: " . strpart("OffOn", 3 *&list, 3)
endf

" ============
" Toggle Line Numbering
" ============
func! settings#options#ToggleLineNumbering() abort
   set nu!
   echo "Line Numbering: " . strpart("OffOn", 3 *&nu, 3)
endf

" ============
" Toggle Expanded Tabbing
" ============
func! settings#options#ToggleExpandTabbing() abort
   set expandtab!
   echo "Expanded Tabbing: <TAB> maps to <" . strpart("TABSPC", 3 *&expandtab, 3) .">"
endf

" ============
" Toggle Text Margins
" ============
func! settings#options#ToggleTextMargins() abort
    let l:TextWidths = {
                \ 'None':        0,
                \ 'Default':    79,
                \ 'Landscape': 130
                \ }

    let keys   = keys(g:TextWidths)
    let values = values(g:TextWidths)

    let i = index(values, &tw)
    if i == -1
        let l:TextWidth = 'None'
    else
        let l:TextWidth = keys[ (l:i + 1) % len(g:TextWidths) ] 
    endif

    let &tw = l:TextWidths[l:TextWidth]
    echomsg "Text Width Margin: ". l:TextWidth . " (". g:TextWidths[l:TextWidth] .")"
endf

" ============
" Toggle Spell Checking
" ============
func! settings#options#ToggleSpellChecking() abort
   set spell!
   echo "Spell Checking (".&spelllang."): " . strpart("OffOn", 3 *&spell, 3)
endf

" ============
" Toggle Cursor Column & Line Marking
" ============
func! settings#options#ToggleCursorColumnLine() abort
   set cuc! cul!
   echo "Cursor Column & Line: " . strpart("OffOn", 3 *&cuc, 3)
endf

" ============
" Toggle UI Option
" ============
fun! settings#options#ToggleGUIOption(option)
    " If a:option is already set in guioptions, then we want to remove it
    if match(&guioptions, "\\C" . a:option) > -1
        exec "set go-=" . a:option
    else
        exec "set go+=" . a:option
    endif
endfun

" ============
" Search Path Dialog
" ============
fun! settings#options#ShowSearchPathDialog()
    let n = inputdialog("Enter search path for files.\nSeparate directory names with a comma.", substitute(&path, '\\ ', ' ', 'g'))
    if n != ""
        let &path = substitute(n, ' ', '\\ ', 'g')
    endif
endfun

" ============
" Tags Dialog
" ============
fun! settings#options#ShowTagsDialog()
    let n = inputdialog("Enter names of tag files.\nSeparate the names with a comma.", substitute(&tags, '\\ ', ' ', 'g'))
    if n != ""
        let &tags = substitute(n, ' ', '\\ ', 'g')
    endif
endfun

" ============
" Text Width Dialog
" ============
fun! settings#options#ShowTextWidthDialog()
    let n = inputdialog("Enter new text width (0 to disable formatting): ", &tw)
    if n != ""
        " remove leading zeros to avoid it being used as an octal number
        let &tw = substitute(n, "^0*", "", "")
    endif
endfun

" ============
" File Format Dialog
" ============
fun! settings#options#ShowFileFormatDialog()
    if &ff == "dos"
        let def = 2
    elseif &ff == "mac"
        let def = 3
    else
        let def = 1
    endif
    let n = confirm("Select format for writing the file", "&Unix\n&Dos\n&Mac\n&Cancel", l:def, "Question")
    if n == 1
        set ff=unix
    elseif n == 2
        set ff=dos
    elseif n == 3
        set ff=mac
    endif
endfun    

" ===================================================================
" End
" ===================================================================

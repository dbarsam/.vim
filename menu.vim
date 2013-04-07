" ===================================================================
"                            Menu for VIM
" ===================================================================
" File:           menu.vim
" Purpose:        Scripts and functions based on Menus in the system
"                 menu.vim file for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_menu_plugin')
   finish 
endif 
let g:loaded_settings_menu_plugin = 1

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ===================================================================
" General Functions
" ===================================================================
" Special visual mode version of the amenu command
function! s:VMenu(...) abort
    exe 'amenu   '.join(a:000)
    if a:0 == 3
        exe 'vunmenu '.a:2
    elseif a:0 == 4
        exe 'vunmenu '.a:3
    endif
   exe 'vmenu '.join(a:000)
endfunction
com! -nargs=+ VMenu call <SID>VMenu(<q-args>)

" Work around the default behaviour of the amenu command...
function! s:Amenu(...) abort
    let args = join(a:000)
    exe 'nmenu '.l:args
    exe 'omenu '.l:args
    exe 'vmenu '.l:args
    exe 'imenu '.l:args
    exe 'cmenu '.l:args
endfunction
com! -nargs=+ Amenu call <SID>Amenu(<q-args>)


" ===================================================================
" Help Menu
" ===================================================================

" ============
" Internal Functions
" ============
fun! s:Helpfind()
    if !exists("g:menutrans_help_dialog")
        let g:menutrans_help_dialog = "Enter a command or word to find help on:\n\nPrepend i_ for Input mode commands (e.g.: i_CTRL-X)\nPrepend c_ for command-line editing commands (e.g.: c_<Del>)\nPrepend ' for an option name (e.g.: 'shiftwidth')"
    endif
    let h = inputdialog(g:menutrans_help_dialog)
    if h != ""
        let v:errmsg = ""
        silent! exe "help " . h
        if v:errmsg != ""
            echo v:errmsg
        endif
    endif
endfun

" ============
" Menu Commands
" ============
an 9999.10 &Help.&Overview<Tab><F1>             :help<CR>
an 9999.20 &Help.&User\ Manual                  :help usr_toc<CR>
an 9999.30 &Help.&How-to\ links                 :help how-to<CR>
an <silent> 9999.40 &Help.&Find\.\.\.           :call <SID>Helpfind()<CR>
an 9999.45 &Help.-sep1-                         <Nop>
an 9999.50 &Help.&Credits                       :help credits<CR>
an 9999.60 &Help.Co&pying                       :help copying<CR>
an 9999.70 &Help.&Sponsor/Register              :help sponsor<CR>
an 9999.70 &Help.O&rphans                       :help kcc<CR>
an 9999.75 &Help.-sep2-                         <Nop>
an 9999.80 &Help.&Version                       :version<CR>
an 9999.90 &Help.&About                         :intro<CR>

" ===================================================================
" File Menu
" ===================================================================

" ============
" Internal Functions
" ============

" The File.Recent Files submenu
function! s:FileMenuRecentFiles() abort
    if exists("v:oldfiles") && !empty(v:oldfiles)
        silent! aunmenu File.&Recent\ Files\.\.\.
        " Exclude some directories from our list
        let exdirs = [
                    \fnamemodify(&helpfile, ":p:h:gs?\\?/?")
                    \]
        let i = 1
        let j = 1
        for file in v:oldfiles
            if index(exdirs, fnamemodify(file, ":p:h:gs?\\?/?")) == -1
                exe 'am 10.600 &File.&Recent\ Files\.\.\..&' . j.'\ '. escape(fnamemodify(file, ':p'), ' \\.') . ' :EditRecentFile ' . i . '<CR>'
                let j += 1
                if j == 10
                    break
                endif
            endif
            let i += 1
        endfor
        if j > 1
            amenu 10.600 &File.&Recent\ Files\.\.\..-SEP1-            <Nop>
            amenu 10.600 &File.&Recent\ Files\.\.\..More\ Files\.\.\. <Plug>CoreBrowseRecentFiles
        endif
    endif
endfunction

" Basic Operations
amenu <silent> 10.300 &File.&New<Tab>:e                             <Plug>SystemFileNew
amenu <silent> 10.310 &File.&Open\.\.\.<Tab>:sp                     <Plug>SystemFileOpen
amenu <silent> 10.330 &File.&Close<Tab>:close                       <Plug>SystemFileClose
amenu <silent> 10.335 &File.-SEP1-                                  <Nop>
amenu <silent> 10.340 &File.Open\ Tab\.\.\.<Tab>:tabnew             <Plug>TabNew
amenu <silent> 10.350 &File.Close\ Tab<Tab>:tabclose                <Plug>TabClose
amenu <silent> 10.355 &File.-SEP2-                                  <Nop>
amenu <silent> 10.360 &File.&Save<Tab>:w                            <Plug>SystemFileSave
amenu <silent> 10.370 &File.Save\ &As\.\.\.<Tab>:sav                <Plug>SystemFileSaveAs

" Copy functions
if has("win32") && exists("$DESKTOP")
    amenu <silent> 10.380 &File.Save\ &To\ Desktop	            	<Plug>SystemFileSaveToDesktop
endif
amenu <silent> 10.390 &File.Save\ &As\ Backup		            	<Plug>SaveCopyAsBackup

" Split Operations
amenu <silent> 10.400 &File.-SEP3-                                  <Nop>
amenu <silent> 10.410 &File.Sp&lit-Open\.\.\.<Tab>:sp               <Plug>SystemFileSplitOpen
amenu <silent> 10.420 &File.Split\ &Diff\ with\.\.\.<Tab>:diffs     <Plug>DiffSplit
amenu <silent> 10.430 &File.Split\ Patched\ &By\.\.\.<Tab>:diffp    <Plug>DiffPatch

" Printer Operations
amenu <silent> 10.500 &File.-SEP4-                                  <Nop>
VMenu <silent> 10.500 &File.&Print\.\.\. <Plug>SystemFilePrint

" 'Find In System' Operations
if has("win32")
    amenu 10.550 &File.-SEP4_5-										<Nop>
    amenu <silent> 10.551 &File.Show\ In\ Explorer\.\.\.			<Plug>SystemShowFileInExplorer
    amenu <silent> 10.552 &File.Show\ In\ Console\.\.\.				<Plug>SystemShowFolderInConsole
endif

" Clipboard Operations
if has("win32")
    amenu 10.560 &File.-SEP4_6-										<Nop>
    amenu <silent> 10.561 &File.Send\ Path\ To\ Clipboard			<Plug>SystemCopyPathFull
    amenu <silent> 10.562 &File.Open\ File\ From\ Clipboard			<Plug>SystemOpenFromClipboard
endif

" Recent Files
amenu 10.600 &File.-SEP5-                                           <Nop>
amenu 10.610 &File.&Recent\ Files\.\.\.                             <Nop>

" Exit
amenu 10.700 &File.-SEP6-                                           <Nop>
amenu 10.710 &File.Sa&ve-Exit<Tab>:wqa                              <Plug>SystemExitSave
amenu 10.720 &File.E&xit<Tab>:qa                                    <Plug>SystemExit

" ============
" Auto Command Group
" ============
augroup FileMenuGroup
    au!
    auto VimEnter *  call <SID>FileMenuRecentFiles()
augroup END

" ===================================================================
" Edit Menu
" ===================================================================

" ============
" Internal Functions
" ============

" The Edit.Color Scheme submenu
function! s:EditMenuColorScheme() abort
    silent! aunmenu Edit.C&olor\ Scheme\.\.\.
    if has("syntax")
        let labels = map( split(globpath(&runtimepath, "colors/*.vim"), '\n'), 'fnamemodify(v:val, '':t:r'')')
        for colorlabel in l:labels 
            exe 'am 20.700.100 &Edit.C&olor\ Scheme\.\.\..' . escape(colorlabel, ' ') . ' :SyntaxInit ' . colorlabel . '<CR>'
        endfor
    endif
endfunction

" The Edit.Keymap submenu
function! s:EditMenuKeyMap() abort
    silent! aunmenu Edit.&Keymap\.\.\.
    if has("keymap")
        amenu 20.800.100 &Edit.&Keymap\.\.\..\<none\>    :KeyMap ""<CR>
        let labels = map( split(globpath(&runtimepath, "keymap/*.vim"), '\n'), 'substitute(v:val, ''\c.*[/\\:\]]\([^/\\:_]*\)\(_[0-9a-zA-Z-]*\)\=\.vim'', ''\1'', '''')')
        if !empty(l:labels)
            amenu 20.800.200 &Edit.&Keymap\.\.\..-SEP1-    <Nop>
            for keylabel in l:labels
                exe 'amenu 20.800.300 &Edit.&Keymap\.\.\..' . escape(keylabel, ' ') . ' :KeyMap ' . keylabel . '<CR>'
            endfor
        endif
    endif
endfunction

" The Edit.Menu Line submenu
function! s:EditMenuLanguageMode() abort
    silent! aunmenu Edit.&Language\ Mode\.\.\.
    if exists("g:LanguageList")
        amenu 20.900.100 &Edit.&Language\ Mode\.\.\..Default         :LanguageMode default<CR>
        let otherLanguages = sort(filter(keys(g:LanguageList), 'v:val != "Default"'))
        if (!empty(l:otherLanguages))
            amenu 20.900.200 &Edit.&Language\ Mode\.\.\..-SEP1-    <Nop>
            for key in l:otherLanguages
                execute 'amenu 20.900.300 &Edit.&Language\ Mode\.\.\..' . escape(key, ' ') . ' :LanguageMode ' . key . '<CR>'
            endfor
        endif
    endif
endfunction

" The Edit.Status Line submenu
function! s:EditMenuStatusLine() abort
    if has('statusline') && exists('g:StatusLines')
        silent! aunmenu Edit.Status\ Line\.\.\.
        am 20.1000.100 &Edit.Status\ Line\.\.\..default        :EnableStatusLine default<CR>
        let otherLines = sort(filter(keys(g:StatusLines), 'v:val != "default"'))
        let index = 1
        if (!empty(l:otherLines))
            am 20.1000.100 &Edit.Status\ Line\.\.\..-SEP1-    <Nop>
            for key in l:otherLines
                execute 'am 20.1000.100 &Edit.Status\ Line\.\.\..' . escape(l:index < 10 ? '&'.string(l:index).' '.key : key, ' ') . ' :EnableStatusLine ' . key . '<CR>'
                let l:index += 1
            endfor
        endif
    elseif has('cmdline_info') && exists('g:RulerFormats')
        silent! aunmenu Edit.Rulers\.\.\.
        am 20.1000.100 &Edit.Rulers\.\.\..default        :EnableRuler default<CR>
        let otherRulers = sort(filter(keys(g:RulerFormats), 'v:val != "default"'))
        let index = 1
        if (!empty(l:otherRulers))
            am 20.1000.100 &Edit.Ruler\.\.\..-SEP1-    <Nop>
            for key in l:otherRulers
                execute 'am 20.1000.100 &Edit.Ruler\.\.\..&' . l:index . ' ' . escape(l:index < 10 ? '&'.string(l:index).' '.key : key, ' ') . ' :EnableRuler ' . key . '<CR>'
                let l:index += 1
            endfor
        endif
    endif
endfunction

" ============
" Menu  Commands
" ============
" Command Stack
amenu <silent> 20.310 &Edit.&Undo<Tab>u                             <Plug>CoreUndo
amenu <silent> 20.320 &Edit.&Redo<Tab>^R                            <Plug>CoreRedo
amenu <silent> 20.330 &Edit.Rep&eat<Tab>\.                          <Plug>CoreRepeat

" ViM Clipboard Operations
amenu <silent> 20.335 &Edit.-SEP1-                                  <Nop>

vmenu <silent> 20.340 &Edit.Cu&t<Tab>"+x                            <Plug>TextCut

vmenu <silent> 20.350 &Edit.&Copy<Tab>"+y                           <Plug>TextCopy
cmenu <silent>        &Edit.&Copy<Tab>"+y                           <Plug>TextCopy

nmenu <silent> 20.360 &Edit.&Paste<Tab>"+gP                         <Plug>TextPaste
cmenu <silent>        &Edit.&Paste<Tab>"+gP                         <Plug>TextPaste
vmenu <silent>        &Edit.&Paste<Tab>"+gP                         <Plug>TextPaste
imenu <silent>        &Edit.&Paste<Tab>"+gP                         <Plug>TextPaste

nmenu <silent> 20.370 &Edit.Put\ &Before<Tab>[p                     <Plug>TextPutBefore
imenu <silent>        &Edit.Put\ &Before<Tab>[p                     <Plug>TextPutBefore

nmenu <silent> 20.380 &Edit.Put\ &After<Tab>]p                      <Plug>TextPutAfter
imenu <silent>        &Edit.Put\ &After<Tab>]p                      <Plug>TextPutAfter

vmenu <silent> 20.390 &Edit.&Delete<Tab>x                           <Plug>TextDelete

" Find and Replace
amenu <silent> 20.500 &Edit.-SEP2-                                  <Nop>
VMenu <silent> 20.510 &Edit.&Find\.\.\.                             <Plug>TextFind
VMenu <silent> 20.520 &Edit.Find\ and\ Rep&lace\.\.\.               <Plug>TextFindReplace
amenu <silent> 20.590 &Edit.-SEP3-                                  <Nop>

" Setup the Edit.Font submenu
if has("gui")
    amenu <silent> 20.600.10  &Edit.Font\.\.\..&1\ Terminal         <Plug>FontPresetTerminal
    amenu <silent> 20.600.20  &Edit.Font\.\.\..&2\ Lucida           <Plug>FontPresetLucida
    amenu <silent> 20.600.30  &Edit.Font\.\.\..&3\ Consolas         <Plug>FontPresetConsolas
    amenu <silent> 20.600.40  &Edit.Font\.\.\..-SEP1-               <Nop>
    amenu <silent> 20.600.120 &Edit.Font\.\.\..Strikethrough        <Plug>FontToggleStrikethrough
    amenu <silent> 20.600.130 &Edit.Font\.\.\..Bold                 <Plug>FontToggleBold
    amenu <silent> 20.600.140 &Edit.Font\.\.\..Italics              <Plug>FontToggleItalics
    amenu <silent> 20.600.150 &Edit.Font\.\.\..Underline            <Plug>FontToggleUnderline
    amenu <silent> 20.600.160 &Edit.Font\.\.\..Strikethrough        <Plug>FontToggleStrikethrough
    amenu <silent> 20.600.170 &Edit.Font\.\.\..-SEP3-               <Nop>
    amenu <silent> 20.600.180 &Edit.Font\.\.\..Font\ Dialog\.\.\.   <Plug>FontDialog
endif

amenu 20.9999 &Edit.-SEP5-                                          <Nop>
amenu 20.9999 &Edit.Select\ All                                     <Plug>TextSelectAll

" ============
" Auto Command Group
" ============
augroup EditMenuGroup
    au!
    auto VimEnter *  call <SID>EditMenuColorScheme()
    auto VimEnter *  call <SID>EditMenuKeyMap()
    auto VimEnter *  call <SID>EditMenuLanguageMode()
    auto VimEnter *  call <SID>EditMenuStatusLine()
augroup END

" ===================================================================
" Tool Menu
" ===================================================================

" ============
" Internal Functions
" ============
function! s:ToolMenuUpdate() abort
    call <SID>ToolMenuHexUpdate()
    call <SID>ToolMenuSpellUpdate()
endfunction

function! s:ToolMenuHexUpdate() abort
    silent! aunmenu &Tools.-SEPXXD-
    amenu 40.620 &Tools.-SEPXXD-                                        <Nop>
    if &ft != 'xxd'
        silent! aunmenu Tools.&Disable\ Hex\ Mode<Tab>:%!xxd\ -r
        amenu <silent> 40.630 Tools.&Enable\ Hex\ Mode<Tab>:%!xxd       :ToggleHexMode<BAR>call <SID>ToolMenuHexUpdate()<CR>
    else
        silent! aunmenu Tools.&Enable\ Hex\ Mode<Tab>:%!xxd
        amenu <silent> 40.630 Tools.&Disable\ Hex\ Mode<Tab>:%!xxd\ -r  :ToggleHexMode<BAR>call <SID>ToolMenuHexUpdate()<CR>
    endif
endfunction

function! s:ToolMenuSpellUpdate() abort
    if has("spell")
        if &spell
            silent! aunmenu &Tools.&Spelling.&Enable\ Spell\ Check
            amenu <silent> 40.420.110 &Tools.&Spelling.&Disable\ Spell\ Check    :ToggleSpellChecking<BAR>call <SID>ToolMenuSpellUpdate()<CR>
        else
            silent! aunmenu &Tools.&Spelling.&Disable\ Spell\ Check
            amenu <silent> 40.420.110 &Tools.&Spelling.&Enable\ Spell\ Check     :ToggleSpellChecking<BAR>call <SID>ToolMenuSpellUpdate()<CR>
        endif
    endif
endfunction

function! s:ToolMenuSpellDictionary()
    if has("spell")
        silent! aunmenu Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\.

        amenu 40.420.210 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en	:SpellingDictionary en<CR>
        amenu 40.420.220 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en_au	:SpellingDictionary en_au<CR>
        amenu 40.420.230 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en_ca	:SpellingDictionary en_ca<CR>
        amenu 40.420.240 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en_gb	:SpellingDictionary en_gb<CR>
        amenu 40.420.250 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en_nz	:SpellingDictionary en_nz<CR>
        amenu 40.420.260 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..en_us	:SpellingDictionary en_us<CR>

        if &enc == "iso-8859-15"
            let enc = "latin1"
        else
            let enc = &enc
        endif

        let s:labels = filter( map( split(globpath(&runtimepath, "spell/*.".enc .".spl"), '\n'), 'fnamemodify(v:val, '':t:r'')'), 'v:val !~ "en"')
        if !empty(s:labels)
            am 40.420.300 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..-SEP2-    <Nop>
            for nm in s:labels
                exe 'am 40.420.310 &Tools.&Spelling.Use\ Spelling\ Dictionary\.\.\..' . escape(nm, ' ') . ' :SpellingDictionary ' . nm . '<CR>'
            endfor
        endif
    endif
endfunction

" ============
" Menu Commands
" ============
" Tag Commands
VMenu 40.300 &Tools.Tag\ &Jump<Tab>g<C-]>                           <Plug>TagJump
VMenu 40.310 &Tools.Tag\ Jump\ &Selection<Tab>:tselect              <Plug>TagSelection
amenu 40.320 &Tools.Tag\ Jump\ &Back<Tab><C-T>                      <Plug>TagBack
amenu 40.330 &Tools.-SEP1-                                          <Nop>
amenu 40.340 &Tools.&Next\ Tag<tab>:tag                             <Plug>TagForward
amenu 40.350 &Tools.&Previous\ Tag<tab>:pop                         <Plug>TagBack
amenu 40.360 &Tools.&List\ Tags<Tab>:tags                           <Plug>TagList
amenu 40.370 &Tools.Build\ &Tags\ File\.\.\.                        <Plug>TagBuild
amenu 40.400 &Tools.-SEP2-                                          <Nop>

" Sort Sub-Menu
amenu 40.410.110 &Tools.Sort.&Sort                                  <Plug>Sort
amenu 40.410.120 &Tools.Sort.&Sort\ (Numeric)                       <Plug>SortNumeric
amenu 40.410.130 &Tools.Sort.&Sort\ (Reverse)                       <Plug>SortReverse
amenu 40.410.140 &Tools.Sort.&Uniq                                  <Plug>SortUniq

" Spelling Sub-Menu
if has("spell")
    amenu 40.420.130 &Tools.&Spelling.To\ &Next\ error<Tab>]s       <Plug>GoToNextSpellError
    amenu 40.420.130 &Tools.&Spelling.To\ &Previous\ error<Tab>[s   <Plug>GoToPrevSpellError
    amenu 40.420.140 &Tools.&Spelling.Suggest\ &Corrections<Tab>z=  <Plug>SpellSuggestion
    amenu 40.420.150 &Tools.&Spelling.&Repeat\ Correction           <Plug>SpellRepeatCorrection
    amenu 40.420.200 &Tools.&Spelling.-SEP1-                        <Nop>

    call <SID>ToolMenuSpellDictionary()
endif

" Folding Sub-Menu
if has("folding")
    " Open/Close folds
    amenu 40.440.110 &Tools.&Folding.&Next\ Fold<Tab>zk                   <Plug>FoldNext
    amenu 40.440.120 &Tools.&Folding.&Previous\ Fold<Tab>zj               <Plug>FoldPrev
    " Fold Navigation
    amenu 40.440.200 &Tools.&Folding.-SEP1-                               <Nop>
    amenu 40.440.210 &Tools.&Folding.&Toggle\ Folds<Tab>zi                <Plug>FoldingToggleFolds
    amenu 40.440.220 &Tools.&Folding.&View\ Cursor\ Line<Tab>zv           <Plug>FoldingOpenAtCursor
    amenu 40.440.220 &Tools.&Folding.Vie&w\ Cursor\ Line\ only<Tab>zMzx   <Plug>FoldingOpenAtCursorOnly
    amenu 40.440.230 &Tools.&Folding.C&lose\ fold<Tab>zm                  <Plug>FoldingClose
    amenu 40.440.240 &Tools.&Folding.&Close\ all\ folds<Tab>zM            <Plug>FoldingCloseAll
    amenu 40.440.250 &Tools.&Folding.O&pen\ fold<Tab>zr                   <Plug>FoldingOpen
    amenu 40.440.260 &Tools.&Folding.&Open\ all\ folds<Tab>zR             <Plug>FoldingOpenAll
    " Create/Delete Folds
    amenu 40.440.310 &Tools.&Folding.-SEP2-                               <Nop>
    vmenu 40.440.330 &Tools.&Folding.Create\ &Fold<Tab>zf                 <Plug>FoldingCreate
    amenu 40.440.340 &Tools.&Folding.&Delete\ Fold<Tab>zd                 <Plug>FoldingDelete
    amenu 40.440.350 &Tools.&Folding.Delete\ &All\ Folds<Tab>zD           <Plug>FoldingDeleteAll
    " Fold Options
    amenu 40.440.400 &Tools.&Folding.-SEP3-                               <Nop>
    amenu 40.440.410 &Tools.&Folding.Fold\ Met&hod\.\.\.                  <Plug>FoldingMethodPrompt
    amenu 40.440.420 &Tools.&Folding.Fold\ Col&umn\ Width\.\.\.           <Plug>FoldingColumnWidthPrompt
endif

" Diff Sub-Menu
if has("diff")
    amenu 40.450.100 &Tools.&Diff.&Update                                 <Plug>DiffUpdate
    VMenu 40.450.110 &Tools.&Diff.&Get\ Block                             <Plug>DiffGet
    VMenu 40.450.120 &Tools.&Diff.&Put\ Block                             <Plug>DiffPut
    if exists(":VisualDiff")
        vmenu 40.450.200 &Tools.&Diff.-SEP1-                              <Nop>
        vmenu 40.450.210 &Tools.&Diff.&Queue\ Selection                   <Plug>DiffVisualDiffQueue
        vmenu 40.450.220 &Tools.&Diff.&Compare\ Selections                <Plug>DiffVisualDiffCompare
        nmenu 40.450.230 &Tools.&Diff.Cl&ear\ Visual\ Diff\ Queue         <Plug>DiffVisualDiffClear
        nmenu 40.450.240 &Tools.&Diff.Q&uery\ Visual\ Diff\ Queue         <Plug>DiffVisualDiffQuery
    endif
    if exists(":DiffUnsavedChanges")
        nmenu 40.450.300 &Tools.&Diff.-SEP2-                              <Nop>
        nmenu 40.450.310 &Tools.&Diff.&View\ Unsaved\ Changes             <Plug>DiffUnsavedChanges
    endif
endif

" Build Sub-Menu
an 40.500 &Tools.-SEP3-                                                   <Nop>
an 40.510 &Tools.&Make<Tab>:make                                          :make<CR>
an 40.520.10 &Tools.&Build\ Messages.&List\ Errors<Tab>:cl                :cl<CR>
an 40.520.10 &Tools.&Build\ Messages.L&ist\ Messages<Tab>:cl!             :cl!<CR>
an 40.520.10 &Tools.&Build\ Messages.&Next\ Error<Tab>:cn                 :cn<CR>
an 40.520.10 &Tools.&Build\ Messages.&Previous\ Error<Tab>:cp             :cp<CR>
an 40.520.10 &Tools.&Build\ Messages.&Older\ List<Tab>:cold               :colder<CR>
an 40.520.10 &Tools.&Build\ Messages.N&ewer\ List<Tab>:cnew               :cnewer<CR>
an 40.530.50 &Tools.Error\ &Window.&Update<Tab>:cwin                      :cwin<CR>
an 40.530.60 &Tools.Error\ &Window.&Open<Tab>:copen                       :copen<CR>
an 40.530.70 &Tools.Error\ &Window.&Close<Tab>:cclose                     :cclose<CR>

" Setup the Tools.Compiler submenu
let s:n = globpath(&runtimepath, "compiler/*.vim")
let s:idx = 100
while strlen(s:n) > 0
    let s:i = stridx(s:n, "\n")
    if s:i < 0
        let s:name = s:n
        let s:n = ""
    else
        let s:name = strpart(s:n, 0, s:i)
        let s:n = strpart(s:n, s:i + 1, 19999)
    endif
    " Ignore case for VMS and windows
    let s:name = substitute(s:name, '\c.*[/\\:\]]\([^/\\:]*\)\.vim', '\1', '')
    exe "an 40.540." . s:idx . ' &Tools.Se&t\ Compiler.' . s:name . " :compiler " . s:name . "<CR>"
    unlet s:name
    unlet s:i
    let s:idx = s:idx + 10
endwhile
unlet s:n
unlet s:idx

" ============
" Auto Command Group
" ============
augroup ToolMenuGroup
    au!
    auto BufEnter *  call <SID>ToolMenuUpdate()
    if has("spell")
        auto EncodingChanged * call <SID>ToolMenuSpellDictionary()
    endif
augroup END 

" ===================================================================
" Syntax Menu
" ===================================================================

" ============
" Internal Functions
" ============
" Update the Syntax Menu
function! s:SyntaxMenuUpdate() abort
    if has("syntax_items")
        silent! aunmenu &Syntax.&File\ Only\ Enable
        amenu <silent> 50.04 &Syntax.&File\ Only\ Disable :SetSyntaxMode off-file<BAR>call <SID>SyntaxMenuUpdate()<CR>
    else
        silent! aunmenu &Syntax.&File\ Only\ Disable
        amenu <silent> 50.04 &Syntax.&File\ Only\ Enable  :SetSyntaxMode on-file<BAR>call <SID>SyntaxMenuUpdate()<CR>
    endif
endfunction

" ============
" Menu Commands
" ============
" Syntax Enable/Disable Options
amenu 50.01.01 &Syntax.&Enable.&Enable<Tab>:syn\ enable   :SetSyntaxMode on<BAR>call <SID>SyntaxMenuUpdate()<CR>
amenu 50.01.02 &Syntax.&Enable.&Automatic<Tab>:syn\ on    :SetSyntaxMode automatic<BAR>call <SID>SyntaxMenuUpdate()<CR>
amenu 50.01.03 &Syntax.&Enable.&Manual<Tab>:syn\ manual   :SetSyntaxMode manual<BAR>call <SID>SyntaxMenuUpdate()<CR>
amenu 50.02 &Syntax.&Disable<Tab>:syn\ off                :SetSyntaxMode off<BAR>call <SID>SyntaxMenuUpdate()<CR>
amenu 50.03 &Syntax.-SEPB-                     <Nop>

" Syntax FileTypes
amenu 50.09 &Syntax.-SEPC-                     <Nop>
if exists("do_syntax_sel_menu")
    runtime! synmenu.vim
else
    amenu <silent> 50.10 &Syntax.&Show\ Filetypes\.\.\.   :let do_syntax_sel_menu = 1<Bar>runtime! synmenu.vim<Bar>aunmenu &Syntax.&Show\ Filetypes\.\.\.<CR>
endif

" Syntax Misc
nmenu 50.300 &Syntax.-SEPD-                               <Nop>
nmenu 50.310 &Syntax.Co&lor\ test                         :SyntaxColorTest<CR>
nmenu 50.320 &Syntax.&Highlight\ test                     :SyntaxHighlightTest<CR>
nmenu 50.330 &Syntax.&Convert\ to\ HTML                   :SynyaxConvertToHTML<CR>

" ============
" Auto Command Group
" ============
augroup SyntaxMenuGroup
    au!
    auto BufEnter *  call <SID>SyntaxMenuUpdate()
augroup END 

" ===================================================================
" Buffer Menu
" ===================================================================

if !exists("no_buffers_menu")
    
    " wait with building the menu until after loading 'session' files. Makes startup faster.
    let s:bmenu_wait = 1

    if !exists("bmenu_priority")
        let bmenu_priority = 60
    endif

    func! s:BMAdd()
        if s:bmenu_wait == 0
            " when adding too many buffers, redraw in short format
            if s:bmenu_count == &menuitems && s:bmenu_short == 0
                call s:BMShow()
            else
                call <SID>BMFilename(expand("<afile>"), expand("<abuf>"))
                let s:bmenu_count = s:bmenu_count + 1
            endif
        endif
    endfunc

    func! s:BMRemove()
        if s:bmenu_wait == 0
            let name = expand("<afile>")
            if isdirectory(name)
                return
            endif
            let munge = <SID>BMMunge(name, expand("<abuf>"))

            if s:bmenu_short == 0
                exe 'silent! aun &Buffers.' . munge
            else
                exe 'silent! aun &Buffers.' . <SID>BMHash2(munge) . munge
            endif
            let s:bmenu_count = s:bmenu_count - 1
        endif
    endfunc

    " Create the buffer menu (delete an existing one first).
    func! s:BMShow(...)
        let s:bmenu_wait = 1
        let s:bmenu_short = 1
        let s:bmenu_count = 0
        "
        " get new priority, if exists
        if a:0 == 1
            let g:bmenu_priority = a:1
        endif

        " remove old menu, if exists; keep one entry to avoid a torn off menu to
        " disappear.
        silent! unmenu &Buffers
        exe 'noremenu ' . g:bmenu_priority . ".1 &Buffers.Dummy l"
        silent! unmenu! &Buffers

        " create new menu; set 'cpo' to include the <CR>
        let cpo_save = &cpo
        set cpo&vim
        exe 'an <silent> ' . g:bmenu_priority . ".2 &Buffers.&Refresh\\ menu :call <SID>BMShow()<CR>"
        exe 'an ' . g:bmenu_priority . ".4 &Buffers.&Delete<Tab>:bd :confirm bd<CR>"
        exe 'an ' . g:bmenu_priority . ".6 &Buffers.&Alternate<Tab>:b# :confirm b #<CR>"
        exe 'an ' . g:bmenu_priority . ".7 &Buffers.&Previous<Tab>:bprev :bprev<CR>"
        exe 'an ' . g:bmenu_priority . ".7 &Buffers.&Next<Tab>:bnext :bnext<CR>"
        exe 'an ' . g:bmenu_priority . ".9 &Buffers.-SEP- :"
        let &cpo = cpo_save
        unmenu &Buffers.Dummy

        " figure out how many buffers there are
        let buf = 1
        while buf <= bufnr('$')
            if bufexists(buf) && !isdirectory(bufname(buf)) && buflisted(buf)
                let s:bmenu_count = s:bmenu_count + 1
            endif
            let buf = buf + 1
        endwhile

        if s:bmenu_count <= &menuitems
            let s:bmenu_short = 0
        endif

        " iterate through buffer list, adding each buffer to the menu:
        let buf = 1
        while buf <= bufnr('$')
            if bufexists(buf) && !isdirectory(bufname(buf)) && buflisted(buf)
                call <SID>BMFilename(bufname(buf), buf)
            endif
            let buf = buf + 1
        endwhile
        let s:bmenu_wait = 0
        aug buffer_list
        au!
            au BufCreate,BufFilePost * call <SID>BMAdd()
            au BufDelete,BufFilePre * call <SID>BMRemove()
        aug END
    endfunc

    func! s:BMHash(name)
        " Make name all upper case, so that chars are between 32 and 96
        let nm = substitute(a:name, ".*", '\U\0', "")
        if has("ebcdic")
            " HACK: Replace all non alphabetics with 'Z'
            "       Just to make it work for now.
            let nm = substitute(nm, "[^A-Z]", 'Z', "g")
            let sp = char2nr('A') - 1
        else
            let sp = char2nr(' ')
        endif
        " convert first six chars into a number for sorting:
        return (char2nr(nm[0]) - sp) * 0x800000 + (char2nr(nm[1]) - sp) * 0x20000 + (char2nr(nm[2]) - sp) * 0x1000 + (char2nr(nm[3]) - sp) * 0x80 + (char2nr(nm[4]) - sp) * 0x20 + (char2nr(nm[5]) - sp)
    endfunc

    func! s:BMHash2(name)
        let nm = substitute(a:name, ".", '\L\0', "")
        " Not exactly right for EBCDIC...
        if nm[0] < 'a' || nm[0] > 'z'
            return '&others.'
        elseif nm[0] <= 'd'
            return '&abcd.'
        elseif nm[0] <= 'h'
            return '&efgh.'
        elseif nm[0] <= 'l'
            return '&ijkl.'
        elseif nm[0] <= 'p'
            return '&mnop.'
        elseif nm[0] <= 't'
            return '&qrst.'
        else
            return '&u-z.'
        endif
    endfunc

    " insert a buffer name into the buffer menu:
    func! s:BMFilename(name, num)
        if isdirectory(a:name)
            return
        endif
        let munge = <SID>BMMunge(a:name, a:num)
        let hash = <SID>BMHash(munge)
        if s:bmenu_short == 0
            let name = 'an ' . g:bmenu_priority . '.' . hash . ' &Buffers.' . munge
        else
            let name = 'an ' . g:bmenu_priority . '.' . hash . '.' . hash . ' &Buffers.' . <SID>BMHash2(munge) . munge
        endif
        " set 'cpo' to include the <CR>
        let cpo_save = &cpo
        set cpo&vim
        exe name . ' :confirm b' . a:num . '<CR>'
        let &cpo = cpo_save
    endfunc

    " Truncate a long path to fit it in a menu item.
    if !exists("g:bmenu_max_pathlen")
        let g:bmenu_max_pathlen = 35
    endif

    func! s:BMTruncName(fname)
        let name = a:fname
        if g:bmenu_max_pathlen < 5
            let name = ""
        else
            let len = strlen(name)
            if len > g:bmenu_max_pathlen
                let amountl = (g:bmenu_max_pathlen / 2) - 2
                let amountr = g:bmenu_max_pathlen - amountl - 3
                let pattern = '^\(.\{,' . amountl . '}\).\{-}\(.\{,' . amountr . '}\)$'
                let left = substitute(name, pattern, '\1', '')
                let right = substitute(name, pattern, '\2', '')
                if strlen(left) + strlen(right) < len
                    let name = left . '...' . right
                endif
            endif
        endif
        return name
    endfunc

    func! s:BMMunge(fname, bnum)
        let name = a:fname
        if name == ''
            if !exists("g:menutrans_no_file")
                let g:menutrans_no_file = "[No file]"
            endif
            let name = g:menutrans_no_file
        else
            let name = fnamemodify(name, ':p:~')
        endif
        " detach file name and separate it out:
        let name2 = fnamemodify(name, ':t')
        if a:bnum >= 0
            let name2 = name2 . ' (' . a:bnum . ')'
        endif
        let name = name2 . "\t" . <SID>BMTruncName(fnamemodify(name,':h'))
        let name = escape(name, "\\. \t|")
        let name = substitute(name, "&", "&&", "g")
        let name = substitute(name, "\n", "^@", "g")
        return name
    endfunc

    " When just starting Vim, load the buffer menu later
    if has("vim_starting")
        augroup LoadBufferMenu
        au! VimEnter * if !exists("no_buffers_menu") | call <SID>BMShow() | endif
        au  VimEnter * au! LoadBufferMenu
        augroup END
    else
        call <SID>BMShow()
    endif

endif " !exists("no_buffers_menu")

" ===================================================================
" Windows Menu
" ===================================================================

amenu 70.300 &Window.&New<Tab>^Wn                                          <Plug>WindowNewHorizontal
amenu 70.305 &Window.N&ew\ Vertical<Tab>:vnew                              <Plug>WindowNewVertical

amenu 70.309 &Window.-SEP1-                                                <Nop>
amenu 70.310 &Window.&Split<Tab>^Ws                                        <Plug>WindowSplitHorizontal
amenu 70.320 &Window.S&plit\ To\ #<Tab>^W^^                                <Plug>WindowSplitPreviousBuffer
amenu 70.330 &Window.Split\ &Vertically<Tab>^Wv                            <Plug>WindowSplitVertical
amenu <silent> 70.332 &Window.Split\ File\ E&xplorer                       <Plug>SplitExplorer

amenu 70.335 &Window.-SEP2-                                                <Nop>
amenu 70.340 &Window.&Close<Tab>^Wc                                        <Plug>WindowSafeClose
amenu 70.345 &Window.Close\ &Other(s)<Tab>^Wo                              <Plug>WindowSafeCloseOther

amenu 70.350 &Window.-SEP3-                                                <Nop>
amenu 70.351 &Window.N&avigate\ To\.\.\..&Prev<Tab>^Ww                     <Plug>WindowPrev
amenu 70.351 &Window.N&avigate\ To\.\.\..&Next<Tab>^WW                     <Plug>WindowNext
amenu 70.351 &Window.N&avigate\ To\.\.\..-SEP1-                            <Nop>
amenu 70.351 &Window.N&avigate\ To\.\.\..&Top<Tab>^Wk                      <Plug>WindowGoToTop
amenu 70.351 &Window.N&avigate\ To\.\.\..&Bottom<Tab>^Wj                   <Plug>WindowGoToBottom
amenu 70.351 &Window.N&avigate\ To\.\.\..&Left\ side<Tab>^Wh               <Plug>WindowGoToRight
amenu 70.351 &Window.N&avigate\ To\.\.\..&Right\ side<Tab>^Wl              <Plug>WindowGoToLeft

amenu 70.355 &Window.&Move\ To\.\.\..&Top<Tab>^WK                          <Plug>WindowMoveToTop
amenu 70.355 &Window.&Move\ To\.\.\..&Bottom<Tab>^WJ                       <Plug>WindowMoveToBottom
amenu 70.355 &Window.&Move\ To\.\.\..&Left\ side<Tab>^WH                   <Plug>WindowMoveToRight
amenu 70.355 &Window.&Move\ To\.\.\..&Right\ side<Tab>^WL                  <Plug>WindowMoveToLeft

amenu 70.360 &Window.&Resize\.\.\..&Equal\ Size<Tab>^W=                    <Plug>WindowResizeEqual
amenu 70.360 &Window.&Resize\.\.\..&Equal\ Rows                            <Plug>WindowResizeEqualRows
amenu 70.360 &Window.&Resize\.\.\..&Equal\ Columns                         <Plug>WindowResizeEqualColumns
amenu 70.360 &Window.&Resize\.\.\..-SEP1-                                  <Nop>
amenu 70.360 &Window.&Resize\.\.\..&Max\ Height<Tab>^W_                    <Plug>WindowMaxHeight
amenu 70.360 &Window.&Resize\.\.\..M&in\ Height<Tab>^W1_                   <Plug>WindowMinHeight
amenu 70.360 &Window.&Resize\.\.\..Max\ &Width<Tab>^W\|                    <Plug>WindowMaxWidth
amenu 70.360 &Window.&Resize\.\.\..Min\ Widt&h<Tab>^W1\|                   <Plug>WindowMinWidth

amenu 70.370 &Window.Rotate\.\.\..Rotate\ &Up<Tab>^WR                      <Plug>WindowRotateUp
amenu 70.380 &Window.Rotate\.\.\..Rotate\ &Down<Tab>^Wr                    <Plug>WindowRotateDown
amenu 70.390 &Window.Rotate\.\.\..Rotate\ &Layout                          <Plug>WindowRotateLayout

amenu 70.400 &Window.-SEP6-                                                <Nop>
amenu 70.410 &Window.&ScrollBind                                           <Plug>WindowsScrollBind

" ===================================================================
" Tabs Menu
" ===================================================================

" Add a New Window
amenu 80.100 &Tabs.&New\ Tab<Tab>:tabnew                                   <Plug>TabNew
amenu 80.110 &Tabs.&Tab\ Split<Tab>:tabsplit                               <Plug>TabSplit
amenu 80.120 &Tabs.-SEP1-                                                  <Nop>
amenu 80.130 &Tabs.&Close\ Tab<Tab>:tabclose                               <Plug>TabClose
amenu 80.140 &Tabs.Close\ &Other\ Tabs<Tab>:tabonly                        <Plug>TabCloseOther
amenu 80.150 &Tabs.-SEP2-                                                  <Nop>

" Add a Tabs Navigations Commands to Match our Vimrc
amenu 80.160 &Tabs.Navigate\ &To\.\.\..&First\ Tab<Tab>:tabfirst           <Plug>TabGoToFirst
amenu 80.170 &Tabs.Navigate\ &To\.\.\..&Last\ Tab<Tab>:tablast             <Plug>TabGoToLast
amenu 80.190 &Tabs.Navigate\ &To\.\.\..-SEP1-                              <Nop>
amenu 80.200 &Tabs.Navigate\ &To\.\.\..&Next\ Tab<Tab>:tabnext             <Plug>TabGoToNext
amenu 80.210 &Tabs.Navigate\ &To\.\.\..&Previous\ Tab<Tab>:tabprev         <Plug>TabGoToPrev

amenu 80.310.100 &Tabs.&Move\ To\.\.\..Right                               <Plug>TabMoveRight
amenu 80.310.110 &Tabs.&Move\ To\.\.\..Left                                <Plug>TabMoveLeft
amenu 80.310.120 &Tabs.&Move\ To\.\.\..-SEP1-                              <Nop>
amenu 80.310.130 &Tabs.&Move\ To\.\.\..First\ Tab                          <Plug>TabMoveHome
amenu 80.310.140 &Tabs.&Move\ To\.\.\..Last\ Tab                           <Plug>TabMoveEnd

" ===================================================================
" The Popup Menu
" ===================================================================

" ============
" Internal Functions
" ============
" Spell suggestions in the popup menu.  Note that this will slow down the appearance of the menu!
function! <SID>SpellPopup()
    if exists("s:changeitem") && s:changeitem != ''
        call <SID>SpellDel()
    endif

    " Return quickly if spell checking is not enabled.
    if !&spell || &spelllang == ''
        return
    endif

    let curcol = col('.')
    let [w, a] = spellbadword()
    if col('.') > curcol        " don't use word after the cursor
        let w = ''
        call cursor(0, curcol)    " put the cursor back where it was
    endif
    if w != ''
        if a == 'caps'
            let s:suglist = [substitute(w, '.*', '\u&', '')]
        else
            let s:suglist = spellsuggest(w, 10)
        endif
        if len(s:suglist) <= 0
            call cursor(0, curcol)    " put the cursor back where it was
        else
            let s:changeitem = 'change\ "' . escape(w, ' .'). '"\ to'
            let s:fromword = w
            let pri = 1
            for sug in s:suglist
                exe 'anoremenu 1.5.' . pri . ' PopUp.' . s:changeitem . '.' . escape(sug, ' .')
                \ . ' :call <SID>SpellReplace(' . pri . ')<CR>'
                let pri += 1
            endfor

            let s:additem = 'add\ "' . escape(w, ' .') . '"\ to\ word\ list'
            exe 'anoremenu 1.6 PopUp.' . s:additem . ' :spellgood ' . w . '<CR>'

            let s:ignoreitem = 'ignore\ "' . escape(w, ' .') . '"'
            exe 'anoremenu 1.7 PopUp.' . s:ignoreitem . ' :spellgood! ' . w . '<CR>'

            anoremenu 1.8 PopUp.-SpellSep- :
        endif
    endif
endfunction

function! <SID>SpellReplace(n)
    let l = getline('.')
    call setline('.', strpart(l, 0, col('.') - 1) . s:suglist[a:n - 1]
    \ . strpart(l, col('.') + len(s:fromword) - 1))
endfunction

function! <SID>SpellDel()
    exe "aunmenu PopUp." . s:changeitem
    exe "aunmenu PopUp." . s:additem
    exe "aunmenu PopUp." . s:ignoreitem
    aunmenu PopUp.-SpellSep-
    let s:changeitem = ''
endfunction

" ============
" Menu Commands
" ============
amenu 1.10 PopUp.&Undo                  <Plug>CoreUndo
amenu 1.15 PopUp.-SEP1-                 <Nop>
vmenu <silent> 1.20 PopUp.Cu&t          <Plug>TextCut

vmenu <silent> 1.30 PopUp.&Copy         <Plug>TextCopy
cmenu <silent> 1.30 PopUp.&Copy         <Plug>TextCopy

nmenu <silent> 1.40 PopUp.&Paste        <Plug>TextPaste
cmenu <silent> 1.40 PopUp.&Paste        <Plug>TextPaste
vmenu <silent> 1.40 PopUp.&Paste        <Plug>TextPaste
imenu <silent> 1.40 PopUp.&Paste        <Plug>TextPaste

vmenu <silent> 1.50 PopUp.&Delete       <Plug>TextDelete

if has("diff") && exists(":VisualDiff")
    vmenu 1.51 PopUp.-SEPDiff-                           <Nop>
    vmenu 1.52 PopUp.Diff\ &Queue\ Selection             <Plug>DiffVisualDiffQueue
    vmenu 1.53 PopUp.Diff\ &Compare\ Selections          <Plug>DiffVisualDiffCompare
endif

amenu 1.55  PopUp.-SEP3-               <Nop>
vmenu 1.60  PopUp.Select\ Blockwise    <Plug>TextConvertToBlockwiseSelection
Amenu 1.70  PopUp.Select\ &Word        <Plug>TextSelectWord
Amenu 1.73  PopUp.Select\ &Sentence    <Plug>TextSelectSentence
Amenu 1.77  PopUp.Select\ Pa&ragraph   <Plug>TextSelectParagraph
Amenu 1.80  PopUp.Select\ &Line        <Plug>TextSelectLine
Amenu 1.90  PopUp.Select\ &Block       <Plug>TextSelectBlock
amenu 1.95  PopUp.-SEP4-               <Nop>
Amenu 1.100 PopUp.Select\ &All         <Plug>TextSelectAll

" ============
" Auto Command Group
" ============
augroup PopupMenuGroup
    au!
    if has("spell")
        au! MenuPopup * call <SID>SpellPopup()
    endif
augroup END

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo
unlet s:save_cpo

" ===================================================================
" End
" ===================================================================

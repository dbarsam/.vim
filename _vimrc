" ===================================================================
"                        Setup File for VIM
" ===================================================================
" File:           $HOME/.vimrc
" Purpose:        Setup file for the editor Vim (Vi IMproved)
" Author:         David Barsam
" Web:            N/A
" Size:           N/A
" ===================================================================
version 7.3

" ===================================================================
" Environment Settings
" ===================================================================

" ============
" Global Variables
" ============
let g:MSOS = has("win16") || has("win32") || has("win64") || has("dos16") || has("dos32") || has("win95") || has("win32unix")

" ============
" Run Time Directories
" ============
" The primary Vim directory
if (g:MSOS)
    let $VIMFILES=expand('$HOME/vimfiles')
else
    let $VIMFILES=expand('$HOME/.vim')
endif

" The temporary Vim directories
let $VIMBACK=expand('$VIMFILES/.backup')
let $VIMSWAP=expand('$VIMFILES/.swap')
let $VIMVIEW=expand('$VIMFILES/.view')
let $VIMUNDO=expand('$VIMFILES/.undo')
if exists("*mkdir")
    for dir in [$VIMBACK, $VIMSWAP, $VIMVIEW, $VIMUNDO]
        if !isdirectory(dir) 
            call mkdir(dir)
        endif
    endfor
endif

" ===================================================================
" Settings
" ===================================================================
set noautoindent            " always set auto indenting off
set noautowrite             " writes the contents of the file
set   backspace=2           " backspace behavior
set   backup                " write and leave backup of file on computer
set nobomb                  " writes Byte Order Marks into files
set   bioskey               " use PC BIOS to read keyboard, for better ^C detection
set   cmdheight=1           " make command line one lines high
set nocompatible            " use Vim defaults (much better!)
set nodigraph               " insertion of special keys using the backspace (force use of ctrl-k)
set noendofline             " automatically insert an end of line
set   esckeys               " allow usage of cursor keys within insert mode
set noequalalways           " make split window sizes always the same
set   expandtab             " use with the space tab
set   helpheight=15         " amount of help to display
set   hidden                " allow multiple buffers
set   history=100           " command line history
set nohlsearch              " highlight search
set noignorecase            " ignore case in searches
set noincsearch             " automatically search as you type
set noinfercase             " ignore case for keyword completion
set   laststatus=2          " line status
set   lazyredraw            " do not update screen while executing macros
set   linebreak             " setting linebreak at spaces
set   linespace=4           " setting space between lines to 4
set   report=0              " show all changes on command line 
set   ruler                 " cursor co-ordinates on status bar
set   scrolljump=20         " amount to jump the view on the sides
set   scrolloff=2           " amount to jump the view on the top and bottom
set   shiftwidth=4          " space tab of 4
set   showbreak=+++\        " show lines that have been wrapped around the screen
set   shortmess=aiI         " control ViM messages
set   showmatch             " show matching brackets
set   showmode              " show current input mode
set   showcmd               " show commands as they're typed
set   sidescroll=20         " amount to jump the view when scrolling out of view
set nosmartcase             " ignore case except when searching with capitals
set   smarttab              " use space characters instead of tab characters
set nosplitbelow            " control how windows are split horizontally
set   splitright            " control how windows are split vertically
set nospell                 " controls on the fly spelling
set nostartofline           " move the cursor to the start of line after some commands
set   tabstop=4             " number of spaces a tab will count for
set   ttyscroll=500         " amount of line to scroll before re-drawing
set   textwidth=0           " break text every "0" characters
set   undofile              " enable persistent undo, per file
set   undolevels=2000       " maximum number of changes that can be undone
set   undoreload=10000      " maximum number lines to save for undo on a buffer reload
set   updatecount=100       " Number of times to update the swap file
set   updatetime=4000       " write swap file to disk after 4 inactive seconds
set   whichwrap=b,s         " Keys that can wrap up/down text
set   winheight=1           " minimum size for current window
set   winminheight=1        " minimum size for non-current window
set   writebackup           " write backup when saving but clean up afterwards
set nowriteany              " force the use of '!'
set nowrap                  " setting a paragraph to wrap around a screen
set nowrapscan              " scan area when searching

" Encoding
set   encoding=utf-8        " enable Unicode for Vim
set   fileencoding=utf-8    " enable Unicode for writing files

" Special Vim Files and Directories 
set   backupdir=$VIMBACK
set   directory=$VIMSWAP
set   undodir=$VIMUNDO
set   viewdir=$VIMVIEW
set   helpfile=$VIMRUNTIME/doc/help.txt
set   makeprg=make
set   errorformat=%f:%l:\ %m	
set   makeef=vim##.err

" Default format options
set   formatoptions=
set   formatoptions+=c " Auto-wrap comments, inserting the comment leader
set   formatoptions+=r " Insert the comment leader after hitting <Enter> in Insert mode.
set   formatoptions+=o " Insert the comment leader after hitting 'o' or 'O' in Normal mode.
set   formatoptions+=q " Allow formatting of comments with "gq".
set   formatoptions+=n " Formatted Number Lists
set   formatoptions+=l " Long lines are not broken in insert mode.

" The Viminfo File
set   viminfo=
set   viminfo+='1000        " Remember vim-information for the last 1000 edited files
set   viminfo+=\"500        " Save up to 500 lines per register
set   viminfo+=h            " Disable the effect of 'hlsearch' when loading the viminfo file
set   viminfo+=n$VIMFILES/viminfo.txt

" AutoComplete 
set   wildmenu
set   wildmode=full         " How expansion results are presented
set   wildchar=<Tab>        " Character for wildchar expansion
set   wildcharm=<Tab>       " Character for wildchar expansion in mappings
set   wildignore+=*.o,*~,.lo
set   suffixes+=.in,.a

" Fill Characters for Statusline, Foldingline, etc.
set   fillchars=
set   fillchars+=stl:\ 
set   fillchars+=stlnc:\ 
set   fillchars+=vert:\|
set   fillchars+=fold:-
set   fillchars+=diff:-

" Characters to match with showmatch
set   matchpairs=
set   matchpairs+=(:)
set   matchpairs+={:}
set   matchpairs+=[:]
set   matchpairs+=<:>

" Characters to use in list mode
set   listchars=
set   listchars+=tab:\|-    " |---- for tabs
set   listchars+=extends:>
set   listchars+=precedes:<
set   listchars+=trail:-    " - for trailing space
set   listchars+=nbsp:%
set   listchars+=eol:$      " $ for eol

" Scrolling Behaviour
set   scrollopt=
set   scrollopt+=ver        " bind vertical scrolling for 'scrollbind' windows
set   scrollopt+=hor        " bind horizontal scrolling for 'scrollbind' windows
set   scrollopt+=jump       " use the same relative offset in scrolling

" GUI Options
set   guioptions=
set   guioptions+=M         " do not source "$VIMRUNTIME/menu.vim"

" ============
" Win32 Settings
" ============
if has("win32") 
    set winaltkeys=yes      " respect existing alt-keys mappings
    
    " vim defaults to findstr.exe instead of grep.
    if executable("grep.exe")
        set grepprg=grep\ -n
    endif
endif

" ============
" Unix Setting
" ============
if has("unix")
    set dictionary=/usr/share/dict/words
    if "" == &shell
        if executable("/bin/zsh")
            set shell=/bin/zsh
        elseif executable("/bin/bash")
            set shell=/bin/bash
        elseif executable("/bin/sh")
            set shell=/bin/sh
        else
            let shell=/xhbin/tcsh
        endif
    endif
endif

" ===================================================================
" Mappings
" ===================================================================

" ============
" Terminal Mappings
" ============
if has("unix") && !has("gui_running")
   map [2~   <Home>
   map [1~   <Insert>
   map [3~   <PageUp>
   map [5~   <End>
   map [6~   <PageDown>
   map [11~  <F1>
   map [12~  <F2>
   map [13~  <F3>
   map [14~  <F4>
   map [15~  <F5>
   map [17~  <F6>
   map [18~  <F7>
   map [19~  <F8>
   map [20~  <F9>
   map [21~  <F10>
   map [23~  <F11>
   map [24~  <F12>
endif

" ============
" Map Leader
" ============
let mapleader = ";"

" ============
" Console Specific Menu
" ============
map <leader>em <Plug>CoreShowConsoleMenu

" ============
" Function Key Presets
" ============
map <F2>  <Plug>OptionsToggleIndentMode
map <F3>  <Plug>OptionsToggleSearchHighlighting
map <F4>  <Plug>OptionsToggleCaseSensitiveSearching
map <F5>  <Plug>OptionsToggleTextWrap
map <F6>  <Plug>OptionsToggleListMode
map <F7>  <Plug>OptionsToggleLineNumber
map <F8>  <Plug>OptionsToggleExpandTab
map <F9>  <Plug>SyntaxToggleColorPreset

" ============
" Movement Mappings
" ============
" Map classic vi movements to display ASCII value of Current Character
nmap k <Plug>CoreGoToAsciiUp
nmap j <Plug>CoreGoToAsciiDown
nmap l <Plug>CoreGoToAsciiRight
nmap h <Plug>CoreGoToAsciiLeft

" Include Half-Screen Jumping
map <S-PageUp>   <Plug>CoreGoToHalfPageUp
map <S-PageDown> <Plug>CoreGoToHalfPageDown

" Arrow Keys remapped for 'wrap' mode
map <End>  <Plug>OptionsWrapModeEnd
map <Home> <Plug>OptionsWrapModeHome
map <Down> <Plug>OptionsWrapModeDown
map <Up>   <Plug>OptionsWrapModeUp

" ============
" System Mappings
" ============
map <leader>ex <Plug>SystemShowFileInExplorer

" ============
" External Paste Manager Mappings
" ============
imap <S-C-V> <Plug>TextPutBefore
nmap <S-C-V> <Plug>TextPutBefore

" ============
" Quick System Edits Mapped to Keyboard 
" ============
" e0     Edit User File Directory
nmap <leader>e0 <Plug>CoreEditVimFiles

" e1-9   Edit or View system file
nmap <leader>e1 <Plug>CoreEditVimrc
nmap <leader>e2 <Plug>CoreEditGVimrc
nmap <leader>e3 <Plug>CoreEditMenu
nmap <leader>e4 <Plug>CoreEditColorscheme
nmap <leader>e5 <Plug>CoreViewSystemRGB
nmap <leader>e6 <Plug>CoreViewSystemMSWin
nmap <leader>e7 <Plug>CoreViewSystemMenu
nmap <leader>e8 <Plug>CoreViewVimInfo

" Edit Old Files
nmap <leader>eo <Plug>CoreBrowseRecentFiles

" Edit Bundle List
nmap <leader>eb <Plug>BundleEdit

" ============
" Serching Mappings
" ============
vmap <silent> * <Plug>VisualSearchForward
vmap <silent> # <Plug>VisualSearchReverse
vmap <silent> ? <Plug>VisualSearchGrep

" ============
" Buffer Mappings
" ============

" Buffer Naivations using the Alt/Meta Key
nmap <M-Left>   <Plug>BufferGoToPrev
nmap <M-Right>  <Plug>BufferGoToNext

" ============
" Window Mappings
" ============
 
" Window Naivation using the Tab/Arrow Keys
nmap <TAB>      <Plug>WindowGoToNext
nmap <S-Tab>    <Plug>WindowGoToPrev
nmap <S-Up>     <Plug>WindowGoToTop
nmap <S-Down>   <Plug>WindowGoToBottom
nmap <S-Left>   <Plug>WindowGoToLeft
nmap <S-Right>  <Plug>WindowGoToRight

" Window Quick Manipulation Maps
nmap <leader>wq <Plug>WindowDelete
nmap <leader>ws <Plug>WindowSplitHorizontal
nmap <leader>wS <Plug>WindowNewHorizontal
nmap <leader>wv <Plug>WindowSplitVertical
nmap <leader>wV <Plug>WindowNewVertical
nmap <leader>wr <Plug>WindowRotateLayout
nmap <leader>wm <Plug>WindowMaximize
nmap <leader>wM <Plug>WindowMinimize
nmap <leader>w= <Plug>WindowResizeEqual

" ============
" QuickFix Mappings
" ============
" Quick Fix Window Toggle
nmap <leader>qf <Plug>QuickFixToggleQuickFixList 

" Quick Fix Message Navigation
nmap <M-Up>     <Plug>QuickFixGoToPrev
nmap <M-Down>   <Plug>QuickFixGoToNext

" ============
" Tab Mappings
" ============

" Tab Naivation using the Ctrl Key
nmap <C-TAB>    <Plug>TabGoToNext
nmap <C-S-TAB>  <Plug>TabGoToPrev

" ============
" Indenting Mappings
" ============
vmap <TAB>      <Plug>TextMoveRight
vmap <S-TAB>    <Plug>TextMoveLeft

" ============
" Spelling Mappings
" ============
nmap <leader>sp <Plug>OptionsToggleSpellChecking

" ===================================================================
" External Config Files
" ===================================================================

" ============
" Auxiliary Settings
" (Auxiliary Plugin Settings are managed by the BundleManager)
" ============
runtime! settings/*.vim

" ============
" Custom Menus - This will load the first menu.vim file in our rtp, 
" defaulting to the VIMRUNTIME system menu if none is found.
" ============
runtime menu.vim

" ===================================================================
" Bundle Handling
" ===================================================================

if exists(':BundleManagerInit')
    BundleManagerInit
endif

" ===================================================================
" Syntax Highlighting
" ===================================================================

if exists(":SyntaxInit")
    if has("gui_running") || $EMULATOR == "console2"
        SyntaxInit rusty
    endif
endif

" ===================================================================
" Filetype Handling
" ===================================================================
filetype plugin indent on

" ===================================================================
" End
" ===================================================================

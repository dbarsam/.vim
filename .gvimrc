" ===================================================================
"                Setup File for VIM - GUI version
" ===================================================================
" File:           $HOME/.gvimrc
" Purpose:        Setup file for GViM - the GUI of Vim (Vi IMproved)
" Author:         David Barsam
" Web:            N/A
" Availability:   N/A
" ===================================================================
version 7.3

" ===================================================================
" GUI Settings
" ===================================================================
set   cmdheight=1                " command row height
set   columns=90                 " initial window width
set   lines=30                   " initial window height
set   lsp=3                      " line space (in pixels)
set   mousemodel=popup           " behaviour of the mouse clicks
set nomousefocus                 " automate selection of windows with the mouse Unix-style
set   mousehide                  " hide the mouse when typing
set   winaltkeys=menu            " how to handle the alt + key mappings

" Gui Window Appearance
set   guioptions=
set   guioptions+=a              " enable auto-select
set   guioptions+=g              " grey out menu items
set   guioptions+=r              " show the right scroll bar
set   guioptions+=m              " show the menu bar
set   guioptions+=b              " show the bottom scroll bar
set   guioptions+=e              " show tab pages

" Gui Font
set   guifont=
set   guifont+=Terminal:h6
set   guifontwide=
set   guifontwide+=MS_Gothic:h6

" Gui Cursor
set   guicursor=
set   guicursor+=n:block-blinkon0-Cursor
set   guicursor+=v:block-blinkon0-VisualCursor
set   guicursor+=c-i-ci:ver25-blinkon0-Cursor
set   guicursor+=r-cr:hor16-blinkon0-Cursor
set   guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" Gui Tab Tool Tip
set   guitabtooltip=
set   guitabtooltip+=%N          " show the buffer number
set   guitabtooltip+=-\ %f       " show the full filename

" Gui Tab Label
set   guitablabel=
set   guitablabel+=%N            " show buffer number
set   guitablabel+=-\ %t         " show the filename
set   guitablabel+=\ %M          " show the modification flag

" ===================================================================
" External Config Files
" ===================================================================

" ============
" Macros
" ============
runtime macros/editexisting.vim

" ===================================================================
" End
" ===================================================================

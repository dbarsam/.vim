" ===================================================================
"       Window, Tab, and Buffer Scripts and Functions for VIM
" ===================================================================
" File:           settings/windows.vim
" Purpose:        Window, Tab, and Buffer commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_windows_plugin')
   finish
endif
let g:loaded_settings_windows_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============

" Windows Commands
command! -bar -nargs=0 WinNewHorizontal  confirm new
command! -bar -nargs=0 WinNewVertical    confirm vnew
command! -bar -nargs=0 WinDelete         confirm quit
command! -bar -nargs=0 WinClose          confirm close
command! -bar -nargs=0 WinCloseOthers    confirm only

command! -bar -nargs=? WinNext           <args>wincmd w
command! -bar -nargs=? WinPrev           <args>wincmd W
command! -bar -nargs=0 WinLastUsed       wincmd p

command! -bar -nargs=? WinGoToTop        <args>wincmd k
command! -bar -nargs=? WinGoToBottom     <args>wincmd j
command! -bar -nargs=? WinGoToRight      <args>wincmd l
command! -bar -nargs=? WinGoToLeft       <args>wincmd h

command! -bar -nargs=? WinMoveToTop      <args>wincmd K
command! -bar -nargs=? WinMoveToBottom   <args>wincmd J
command! -bar -nargs=? WinMoveToRight    <args>wincmd L
command! -bar -nargs=? WinMoveToLeft     <args>wincmd H

command! -bar -nargs=? WinRotateUp       <args>wincmd R
command! -bar -nargs=? WinRotateDown     <args>wincmd r
command! -bar -nargs=0 WinRotateLayout   call settings#windows#ToggleWindowsOrientationLayout()

command! -bar -nargs=0 WinEqualizeHeight call settings#windows#WinEqualize('r')
command! -bar -nargs=0 WinEqualizeWidth  call settings#windows#WinEqualize('c')
command! -bar -nargs=0 WinMaxHeight      resize
command! -bar -nargs=0 WinMinHeight      resize 1
command! -bar -nargs=0 WinMaxWidth       vertical resize
command! -bar -nargs=0 WinMinWidth       vertical resize 1

" Buffer Commands
command! -bar -nargs=0 BufferNew         confirm new
command! -bar -nargs=0 BufferDelete      confirm bd

command! -bar -nargs=0 BufferNext        bnext
command! -bar -nargs=0 BufferPrev        bprev
command! -bar -nargs=0 BufferLastUsed    e#

command! -bar -nargs=0 BufferList        buffers

" Tab Commands
command! -bar -nargs=0 TabNew            confirm tabnew
command! -bar -nargs=0 TabClose          confirm tabclose
command! -bar -nargs=0 TabCloseOther     tabonly
command! -bar -nargs=0 TabSplit          tab split

command! -bar -nargs=0 TabNext           tabnext
command! -bar -nargs=0 TabPrev           tabprevious
command! -bar -nargs=0 TabGoToFirst      tabfirst
command! -bar -nargs=0 TabGoToLast       tablast

command! -bar -nargs=0 TabMoveRight      call settings#windows#TabMove(1)
command! -bar -nargs=0 TabMoveLeft       call settings#windows#TabMove(-1)
command! -bar -nargs=0 TabMoveHome       tabmove 0
command! -bar -nargs=0 TabMoveEnd        tabmove

" Utilitiy Commands
command! -bar -nargs=0 WinLS                     call settings#windows#WinList()
command! -bar -nargs=0 ToggleWindowsScrollBind   call settings#windows#ToggleWindowsScrollBind()
command! -bar -nargs=0 SplitExplorer             call settings#windows#WinExplorer()
command! -bar -nargs=+ -complete=command WinDo   call settings#windows#WinDo(<q-args>)
command! -bar -nargs=+ -complete=command BufDo   call settings#windows#BufDo(<q-args>)
command! -bar -nargs=+ -complete=command TabDo   call settings#windows#TabDo(<q-args>)

" ============
" Plugin Mappings
" ============
" Tab Commands
nnoremap <Plug>TabNew                   :TabNew<CR>
nnoremap <Plug>TabSplit                 :TabSplit<CR>
nnoremap <Plug>TabClose                 :TabClose<CR>
nnoremap <Plug>TabCloseOther            :TabCloseOther<CR>

nnoremap <Plug>TabGoToFirst             :TabFirst<CR>
nnoremap <Plug>TabGoToLast              :TabLast<CR>
nnoremap <Plug>TabGoToNext              :TabNext<CR>
nnoremap <Plug>TabGoToPrev              :TabPrev<CR>

" Buffer Commands
nnoremap <Plug>BufferNew                :BufferNew<CR>
nnoremap <Plug>BufferDelete             :BufferDelete<CR>
nnoremap <Plug>BufferGoToNext           :BufferNext<CR>
nnoremap <Plug>BufferGoToPrev           :BufferPrev<CR>
nnoremap <Plug>BufferGoToLastUsed       :BUfferLastUsed<CR>
nnoremap <Plug>BufferList               :BufferList<CR>

" Window Commands
nnoremap <Plug>WindowGoToNext           <C-W>w
nnoremap <Plug>WindowGoToPrev           <C-W>W

nnoremap <Plug>WindowGoToTop            <C-W>k
nnoremap <Plug>WindowGoToBottom         <C-W>j
nnoremap <Plug>WindowGoToLeft           <C-W>h
nnoremap <Plug>WindowGoToRight          <C-W>l

nnoremap <Plug>WindowMoveToTop          <C-W>K
nnoremap <Plug>WindowMoveToBottom       <C-W>J
nnoremap <Plug>WindowMoveToLeft         <C-W>H
nnoremap <Plug>WindowMoveToRight        <C-W>L

nnoremap <Plug>WindowRotateUp           <C-W>R
nnoremap <Plug>WindowRotateDown         <C-W>r

nnoremap <Plug>WindowRotateLayout       :WinRotateLayout<CR>

nnoremap <Plug>WindowResizeEqual        <C-W>=
nnoremap <Plug>WindowResizeEqualRows    :WinSizeRows<CR>
nnoremap <Plug>WindowResizeEqualColumns :WinSizeColumns<CR>

nnoremap <Plug>WindowMaxHeight          <C-W>_
nnoremap <Plug>WindowMinHeight          <C-W>1_
nnoremap <Plug>WindowMaxWidth           <C-W><BAR>
nnoremap <Plug>WindowMinWidth           <C-W>1<BAR>
nnoremap <Plug>WindowMaximize           <C-W>_<C-W><BAR>

nnoremap <Plug>WindowNewHorizontal      <C-W>n
nnoremap <Plug>WindowNewVertical        <C-W>v
nnoremap <Plug>WindowDelete             <C-W>q
nnoremap <Plug>WindowClose              <C-W>c
nnoremap <Plug>WindowSafeClose          :WinClose<CR>
nnoremap <Plug>WindowCloseOther         <C-W>o
nnoremap <Plug>WindowSafeCloseOther     :WinCloseOthers<CR>

nnoremap <Plug>WindowSplitHorizontal    <C-W>s
nnoremap <Plug>WindowSplitVertical      <C-W>v
nnoremap <Plug>WindowSplitLastUsed      <C-W><C-^>

nnoremap <Plug>WindowSplitFileExplorer  :SplitExplorer<CR>

nnoremap <Plug>WindowsScrollBind        :ToggleWindowsScrollBind<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

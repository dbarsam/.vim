" ===================================================================
"                       Core Commands for VIM
" ===================================================================
" File:           settings/core.vim
" Purpose:        Custom core commands the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_core_plugin')
   finish 
endif 
let g:loaded_settings_core_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
" Profile Commands
com! -bar -nargs=0 ShowStartupProfile       call settings#core#StartupProfile()
 
" History Commands
com! -bar -nargs=0 ShowLoadHistory          scriptnames
com! -bar -nargs=0 ShowSearchHistory        call feedkeys('q/', 'n')
com! -bar -nargs=0 ShowCommandHistory       call feedkeys('q:', 'n')

" Help Tag Commands
com! -bar -nargs=0 RebuildVimHelp           helptags $VIMRUNTIME/doc
com! -bar -nargs=0 RebuildVimFileslHelp     helptags $VIMFILES/doc

" Quick-Edit commands
com! -bar -nargs=0 ViewSystemRGB            confirm view $VIMRUNTIME/rgb.txt
com! -bar -nargs=0 ViewSystemMSWin          confirm view $VIMRUNTIME/mswin.vim
com! -bar -nargs=0 ViewSystemMenu           confirm view $VIMRUNTIME/menu.vim
com! -bar -nargs=0 ViewSystemPlugin         confirm view $VIMRUNTIME/plugin
com! -bar -nargs=0 ViewSystemFileType       confirm view $VIMRUNTIME/filetype.vim
com! -bar -nargs=0 ViewSystemScripts        confirm view $VIMRUNTIME/scripts.vim

com! -bar -nargs=0 EditColorscheme          call settings#core#EditColorscheme()

com! -bar -nargs=0 EditVimFiles             confirm edit $VIMFILES

com! -bar -nargs=0 ViewVimInfo              confirm view $VIMFILES/viminfo.txt

com! -bar -nargs=0 EditVimrc                confirm edit $VIMFILES/_vimrc
com! -bar -nargs=0 ReloadVimrc              source $VIMFILES/_vimrc

com! -bar -nargs=0 EditGVimrc               confirm edit $VIMFILES/_gvimrc
com! -bar -nargs=0 ReloadGVimrc             source $VIMFILES/_gvimrc

com! -bar -nargs=0 EditMenu                 confirm edit $VIMFILES/menu.vim
com! -bar -nargs=0 ReloadMenu               source $VIMFILES/menu.vim

com! -bar -nargs=0 EditFileType             confirm edit $VIMFILES/filetype.vim
com! -bar -nargs=0 ReloadFileType           source $VIMFILES/filetype.vim

com! -bar -nargs=0 EditScripts              confirm edit $VIMFILES/scripts.vim
com! -bar -nargs=0 ReloadScripts            source $VIMFILES/scripts.vim

" ============
" Plugin Mapping
" ============
" Quick Edit and Reload Commands
nnoremap <Plug>CoreViewSystemRGB        :ViewSystemRGB<CR>
nnoremap <Plug>CoreViewSystemMSWin      :ViewSystemMSWin<CR>
nnoremap <Plug>CoreViewSystemMenu       :ViewSystemMenu<CR>
nnoremap <Plug>CoreViewSystemPlugin     :ViewSystemPlugin<CR>
nnoremap <Plug>CoreViewSystemFileType   :ViewSystemFileType<CR>
nnoremap <Plug>CoreViewSystemScripts    :ViewSystemScripts<CR>
nnoremap <Plug>CoreEditColorscheme      :EditColorscheme<CR>
nnoremap <Plug>CoreEditVimFiles         :EditVimFiles<CR>
nnoremap <Plug>CoreViewVimInfo          :ViewVimInfo<CR>
nnoremap <Plug>CoreEditVimrc            :EditVimrc<CR>
nnoremap <Plug>CoreReloadVimrc          :ReloadVimrc<CR>
nnoremap <Plug>CoreEditGVimrc           :EditGVimrc<CR>
nnoremap <Plug>CoreReloadGVimrc         :ReloadGVimrc<CR>
nnoremap <Plug>CoreEditMenu             :EditMenu<CR>
nnoremap <Plug>CoreReloadMenu           :ReloadMenu<CR>
nnoremap <Plug>CoreEditFileType         :EditFileType<CR>
nnoremap <Plug>CoreReloadFileType       :ReloadFileType<CR>
nnoremap <Plug>CoreEditScripts          :EditScripts<CR>
nnoremap <Plug>CoreReloadScripts        :ReloadScripts<CR>

" Display ASCII value of Current Character
nnoremap <Plug>CoreGoToAsciiUp          <Up>ga
nnoremap <Plug>CoreGoToAsciiDown        <Down>ga
nnoremap <Plug>CoreGoToAsciiLeft        <Left>ga
nnoremap <Plug>CoreGoToAsciiRight       <Right>ga

" Half Page Increments
nnoremap <Plug>CoreGoToHalfPageUp       <C-U>
nnoremap <Plug>CoreGoToHalfPageDown     <C-D>

" Command Line Functions
nnoremap <Plug>CoreShowConsoleMenu      :emenu <Tab>
nnoremap <Plug>CoreShowCommandHistory   q:
nnoremap <Plug>CoreShowSearchHistory    q/

" Core Functions
nnoremap <Plug>CoreUndo                 u
nnoremap <Plug>CoreRedo                 <C-R>
nnoremap <Plug>CoreRepeat               .

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

" ===================================================================
"                        Tag Commands for VIM
" ===================================================================
" File:           autoload/settings/tags.vim
" Purpose:        Custom tag commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_tag_plugin')
   finish 
endif 
let g:loaded_settings_tag_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============

if has("vms")
    com! -nargs=0  TagBuild     !mc vim:ctags *.*
else
    com! -nargs=0  TagBuild     !ctags -R .
endif

com! -bar -nargs=0 TagBrowse    tselect
com! -bar -nargs=0 TagJump      tjump

com! -bar -nargs=0 TagForward   tag
com! -bar -nargs=0 TagBack      pop
com! -bar -nargs=0 TagStack     tags

" Open the tag in a new tab
com!      -nargs=1 TagGuiJump  call settings#tags#TagGUIJump(<f-args>)

" ============
" Plugin Mapping
" ============
nnoremap <Plug>TagJump          g<C-]>
vnoremap <Plug>TagJump          g<C-]>

nnoremap <Plug>TagBack          <C-T>
vnoremap <Plug>TagBack          <C-T>

nnoremap <Plug>TagBrowse        g]
vnoremap <Plug>TagBrowse        g]

nnoremap <Plug>TagForward       :TagForward<CR>
nnoremap <Plug>TagBack          :TagBack<CR>
nnoremap <Plug>TagStack         :TagStack<CR>
nnoremap <Plug>TagBuild         :TagBuild<CR>

nnoremap <Plug>TagGuiJumpTab    :TagGuiJump tab<CR>
nnoremap <Plug>TagGuiJumpVSplit :TagGuiJump vsplit<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

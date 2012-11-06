" ===================================================================
"                  ViM Help File Type Plugin for VIM
" ===================================================================
" File:           after/ftplugin/help.vim
" Purpose:        Additional settings for ViM's Help ftplugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
" Based On:       http://vim.wikia.com/wiki/Mapping_to_quickly_browse_help
"                 http://stackoverflow.com/questions/1683849/mouse-input-in-gvim
" ===================================================================
if exists("b:did_ftplugin_after")
    finish
endif
let b:did_ftplugin_after = 1

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Requirements
" ============
runtime settings/tags.vim

" ============
" Plugin Mappings
" ============
" Map 'q' to quit help
nnoremap <buffer> q :silent! bd<CR>
 
" Jump the page with the Space Bar
nnoremap <buffer> <Space>   <PageDown>
nnoremap <buffer> <S-Space> <PageUp>

" Jump to Next/Prev |label| using <Tab>/<S-Tab>
nnoremap <silent> <buffer> <Tab>   /<Bar>\zs\k*\ze<Bar><CR>
nnoremap <silent> <buffer> <S-Tab> ?<Bar>\zs\k*\ze<Bar><CR>

" Browse just with <CR>/<BS>
nmap <buffer> <CR>  <Plug>TagJump
nmap <buffer> <BS>  <Plug>TagBack

" Navigate the Tag stack wit the Alt/Meta Key
nmap <buffer> <M-Right> <Plug>TagForward
nmap <buffer> <M-Left>  <Plug>TagBack

" Alter the Mouse Click behaviour 
nmap <buffer> <C-LeftMouse>  <Plug>TagGuiJumpTab
nmap <buffer> <M-LeftMouse>  <Plug>TagGuiJumpVSplit

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

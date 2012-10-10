" ===================================================================
"                       Diff Commands for VIM
" ===================================================================
" File:           settings/diff.vim
" Purpose:        Custom diff commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_diff_plugin') || !has("diff")
   finish 
endif 
let g:loaded_settings_diff_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Requirements
" ============
runtime settings/statusline.vim

" ============
" Plugin Data
" ============
let g:DiffModeOverride = 
            \ {
            \ '<TAB>'     : '<Plug>DiffNext',
            \ '<S-TAB>'   : '<Plug>DiffPrev',
            \ '<leader>g' : '<Plug>DiffGet',
            \ '<leader>u' : '<Plug>DiffUpdate',
            \ '<leader>p' : '<Plug>DiffPut'
            \ }"

if exists("g:StatusLines")
    let g:StatusLines['diff']  = ""
    let g:StatusLines['diff'] .="[%3.3n"                           " buffer number
    let g:StatusLines['diff'] .="%H%M%R%W]"                        " flags
    let g:StatusLines['diff'] .="\ %t"                             " file name
    let g:StatusLines['diff'] .="\ %<"                             " truncate marker
    let g:StatusLines['diff'] .="%="                               " right align marker
    let g:StatusLines['diff'] .="(%3l,%3c%V)"                      " line & column
    let g:StatusLines['diff'] .="[%03.3b="                         " value of byte under cursor
    let g:StatusLines['diff'] .="0x%02.2B]"                        " value of byte under cursor (hex)
    let g:StatusLines['diff'] .="\ [%{settings#statusline#FileType()},"    " custom filetype (from statusline.vim)
    let g:StatusLines['diff'] .="%{settings#diff#DiffStatus()},"           " custom diff type
    let g:StatusLines['diff'] .="%{&fileencoding},"                " file encoding
    let g:StatusLines['diff'] .="%{&fileformat},"                  " file format
    let g:StatusLines['diff'] .="%L]"                              " number of lines
    let g:StatusLines['diff'] .="\ %3.p%%"                         " percentage of buffer    
endif

" ============
" Plugin Commands
" ============
com!        -nargs=0 DiffModeToggle  call settings#diff#EnableDiffModeSettings(&diff)

" Diff against last saved version
com!        -nargs=0 DiffLocalChange call settings#diff#DiffLocalChange()

" Diff commands
com!        -nargs=0 DiffUpdate      diffupdate
com!        -nargs=0 DiffGet         diffget
com!        -nargs=0 DiffPut         diffput
com!        -nargs=0 DiffSplit       browse vert diffsplit
com!        -nargs=0 DiffPatch       browse vert diffpatch

" List Diff states in the current buffers
com!        -nargs=0 DiffList        bufdo echo (&diff ? "  diff" : "nodiff")  . "\t" . bufname("%")

" Diff visual blocks of text
com! -range -nargs=1 -complete=customlist,settings#diff#VisualDiffArgs VisualDiff <line1>,<line2>call settings#diff#VisualDiff(<f-args>)

" ============
" Plugin Mappings
" ============
" Diff Navigation
nnoremap <Plug>DiffPrev     [czz
nnoremap <Plug>DiffNext     ]czz

" Split Window Commands
nnoremap <Plug>DiffUpdate   :DiffUpdate<CR>
nnoremap <Plug>DiffPut      :DiffPut<CR>
nnoremap <Plug>DiffGet      :DiffGet<CR>
nnoremap <Plug>DiffSplit    :DiffSplit<CR>
nnoremap <Plug>DiffPatch    :DiffPatch<CR>

" Visual Diff Mapping for Diffing Selections of Text
nnoremap <Plug>DiffVisualDiffClear    :VisualDiff clear<CR>
nnoremap <Plug>DiffVisualDiffQuery    :VisualDiff query<CR>
vnoremap <Plug>DiffVisualDiffCompare  :VisualDiff compare<CR>
vnoremap <Plug>DiffVisualDiffQueue    :VisualDiff queue<CR>

" ============
" Auto Commands for AutoUpdate
" ============" 
augroup DiffMode
    au!
    " Update the Diff settings when we enter a window
    auto WinEnter *         call settings#diff#EnableDiffModeSettings( &diff )
augroup END 

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

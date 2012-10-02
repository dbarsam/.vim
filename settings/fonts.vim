" ===================================================================
"                       Font Commands for VIM
" ===================================================================
" File:           settings/fonts.vim
" Purpose:        Custom font commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_font_plugin')
   finish 
endif 
let g:loaded_settings_font_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:FontList= {
            \ "default"   :"Lucida_Console",
            \ "terminal"  :"Terminal",
            \ "lucida"    :"Lucida_Console",
            \ "consolas"  :"Consolas"
            \ }

" ============
" Plugin Commands
" ============
command! -nargs=+ FontRegister         call settings#fonts#FontPreset(<f-args>)
command! -nargs=+ FontPreset           call settings#fonts#FontPreset(<f-args>)
command! -nargs=0 FontReset            call settings#fonts#FontReset()
command! -nargs=1 FontSetSize          call settings#fonts#FontSetSize(<f-args>)
command! -nargs=1 FontAdjustSize       call settings#fonts#FontAdjustSize(<f-args>)
command! -nargs=1 FontToggleAttribute  call settings#fonts#FontToggleAttribute(<f-args>)
command! -bar -nargs=0 SelectFont      set guifont=*

" ============
" Plugin Mapping
" ============
" Font Selector
nnoremap <Plug>FontDialog           :SelectFont<CR>
 
" Font Reset & Presets
nnoremap <Plug>FontReset            :FontReset<CR>
nnoremap <Plug>FontPresetTerminal   :FontPreset terminal 6<CR>
nnoremap <Plug>FontPresetLucida     :FontPreset lucida   12<CR>
nnoremap <Plug>FontPresetConsolas   :FontPreset consolas 12<CR>

" Font Attributes
nnoremap <Plug>FontToggleBold       :FontToggleAttribute b<CR>
nnoremap <Plug>FontToggleItalics    :FontToggleAttribute i<CR>
nnoremap <Plug>FontToggleUnderline  :FontToggleAttribute u<CR>
nnoremap <Plug>FontToggleStrikeout  :FontToggleAttribute s<CR>

" Font Size Manipulation
nnoremap <Plug>FontSizeIncrement    :FontAdjustSize   1<CR>
nnoremap <Plug>FontSizeDecrement    :FontAdjustSize  -1<CR>
nnoremap <Plug>FontSizeIncrease     :FontAdjustSize  10<CR>
nnoremap <Plug>FontSizeDecrease     :FontAdjustSize -10<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

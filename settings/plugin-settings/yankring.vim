" ===================================================================
"                      YankRing Settings for VIM
" ===================================================================
" File:           settings/yankring.vim
" Purpose:        Custom settings for the YankRing plugin
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_yankring_plugin')
   finish 
endif 
let g:loaded_settings_yankring_plugin = 1 

" ============
"  Plugin Requirements
" ============
runtime settings/statusline.vim

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Functions
" ============
function! s:InitializeYankRingWindow() abort
    let b:TitleString = "yankring"
    let b:StatusLine  = "yankring"
endfunction

" ============
" Plugin Data
" ============
let g:yankring_enabled = 1
let g:yankring_clipboard_monitor = 0
let g:yankring_max_history = 25
let g:yankring_warn_on_truncate = 1
let g:yankring_max_element_length = 1048579
let g:yankring_share_between_instances = 1
let g:yankring_dot_repeat_yank = 1
let g:yankring_window_use_separate = 1
let g:yankring_window_auto_close = 1
let g:yankring_window_use_horiz = 0
let g:yankring_window_use_right = 1
let g:yankring_manage_numbered_reg = 1

if exists("$VIMFILES")
    let g:yankring_history_dir = "$VIMFILES"
    let g:yankring_history_file = "vimyr"
endif

" Remove ';' from o-motions and text objects since it conflicts with our <leader>
let g:yankring_o_keys  = 'b B w W e E d h j k l H M L y G ^ 0 $ ,'
let g:yankring_o_keys .= ' g_  g^ gm g$ gk gj gg ge gE - + _ '
let g:yankring_o_keys .= ' iw iW aw aW as is ap ip a] a[ i] i[ a) a( ab i) i( ib a> a< i> i< at it a} a{ aB i} i{ iB a" a'' a` i" i'' i`'

" Remove <Ctrl-P> and <Ctrl-N> from YankRing mappings
let g:yankring_replace_n_pkey = '<C-Y><C-P>'
let g:yankring_replace_n_nkey = '<C-Y><C-N>'

" ============
" Plugin Mapping
" ============
nnoremap <silent> <leader>yr :YRShow<CR>

" ============
" Menu Configuration
" ============
let g:yankring_default_menu_mode = 3
let g:yankring_menu_root         = "&Edit.&YankRing"
let g:yankring_menu_priority     = "20.450"

" Adjust our Menus to Accomodate the Yank Ring Menu
an 20.440 &Edit.-SEP_YR-	<Nop>

" ============
" Status Line and Title String
" ============
if exists("g:StatusLines")
    let g:StatusLines['yankring']  = ""
    let g:StatusLines['yankring'] .= '[%3.3n]'                    " buffer number
    let g:StatusLines['yankring'] .= ' %t'                        " file name
    let g:StatusLines['yankring'] .= ' %<'                        " truncate marker
    let g:StatusLines['yankring'] .= '%='                         " right align marker
    let g:StatusLines['yankring'] .= '(%3l,%3c%V)'                " line & column
    let g:StatusLines['yankring'] .= '[%L]'                       " number of lines
    let g:StatusLines['yankring'] .= ' %3.p%%'                    " percentage of buffer
endif

if exists("g:TitleStrings")
    let g:TitleStrings['yankring']  = ""
    let g:TitleStrings['yankring'] .= '%t'                        " file name
endif

" ============
" Plugin AutoGroup
" ============
augroup YankRingWindowGroup
    au!
    auto BufNewFile __YankRing__ call <SID>InitializeYankRingWindow()
augroup END

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================" 


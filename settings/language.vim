" ===================================================================
"                     Language Commands for VIM
" ===================================================================
" File:           settings/language.vim
" Purpose:        Custom language commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_language_plugin') 
   finish 
endif 
let g:loaded_settings_language_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Data
" ============
let g:LanguageList = 
            \ {
            \ "Default"         : "en",
            \ "English (Aus)"   : "en_au",
            \ "English (Cdn)"   : "en_ca",
            \ "English (GB)"    : "en_gb",
            \ "English (NZ)"    : "en_nz",
            \ "English (US)"    : "en_us",
            \ "French"          : "fr_fr",
            \ "Chinese"         : "zh_tw",
            \ "Korean"          : "ko",
            \ "Japanese"        : "jo"
            \ }
let g:LanguageKeyMap = 
            \ {
            \ "French"          : "canfr-win"
            \ }
let g:LanguageFont =
            \ {
            \ "Default"         : "MS_Gothic",
            \ "Japanese"        : "MS_Gothic",
            \ "Korean"          : "GulimChe",
            \ "Chinese"         : "NSimSun"
            \ }

" ============
" Plugin Commands
" ============
command! -bar -nargs=0 LanguageReset       call settings#language#LanguageReset()
command! -bar -nargs=1 LanguageSetMode     call settings#language#SetLanguageMode(<f-args>)
command! -bar -nargs=1 KeyMap              call settings#language#SetKeyMap(<f-args>)

" ============
" Plugin Mapping
" ============
nnoremap <Plug>LanguageModeReset    :LanguageReset<CR>
nnoremap <Plug>LanguageModeDefault  :LanguageSetMode Default<CR>
nnoremap <Plug>LanguageModeJapanese :LanguageSetMode Japanese<CR>
nnoremap <Plug>LanguageModeKorean   :LanguageSetMode Korea<CR>
nnoremap <Plug>LanguageModeChinese  :LanguageSetMode Chinese<CR>

" Spelling navigation
if has("spell")
    nnoremap <Plug>SpellSuggestion        z=
    nnoremap <Plug>GoToNextSpellError     ]s
    nnoremap <Plug>GoToPrevSpellError     [s
endif

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

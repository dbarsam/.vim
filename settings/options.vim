" ===================================================================
"                    ViM Options Commands for VIM
" ===================================================================
" File:           settings/options.vim
" Purpose:        Vim Option commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_options_plugin')
   finish
endif
let g:loaded_settings_options_plugin = 1

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
" Setting Toggling commands
com! -bar -nargs=0 ToggleCaseSensitiveSearching call settings#options#ToggleCaseSensitiveSearching()
com! -bar -nargs=0 ToggleCursorColumnLine       call settings#options#ToggleCursorColumnLine()
com! -bar -nargs=0 ToggleExpandTabbing          call settings#options#ToggleExpandTabbing()
com! -bar -nargs=0 ToggleIndentMode             call settings#options#ToggleIndentModes()
com! -bar -nargs=0 ToggleLineNumbering          call settings#options#ToggleLineNumbering()
com! -bar -nargs=0 ToggleRevealCharacters       call settings#options#ToggleRevealCharacters()
com! -bar -nargs=0 ToggleSearchHighlighting     call settings#options#ToggleSearchHighlighting()
com! -bar -nargs=0 ToggleSpellChecking          call settings#options#ToggleSpellChecking()
com! -bar -nargs=0 ToggleTextMargins            call settings#options#ToggleTextMargins()
com! -bar -nargs=0 ToggleTextWrap               call settings#options#ToggleTextWrap()
com! -bar -nargs=1 ToggleGUIOption              call settings#options#ToggleGUIOption(<f-args>)

com! -bar -nargs=0 ShowTextWidthDialog          call settings#options#ShowTextWidthDialog()
com! -bar -nargs=0 ShowSearchPathDialog         call settings#options#ShowSearchPathDialog()
com! -bar -nargs=0 ShowTagsDialog               call settings#options#ShowTagsDialog()
com! -bar -nargs=0 ShowFileFormatDialog         call settings#options#ShowFileFormatDialog()

" ============
" Plugin Mappings
" ============
noremap <expr> <Plug>OptionsWrapModeEnd             (&wrap ? 'g<End>'  : '<End>')
noremap <expr> <Plug>OptionsWrapModeHome            (&wrap ? 'g<Home>' : '<Home>')
noremap <expr> <Plug>OptionsWrapModeDown            (&wrap ? 'g<Down>' : '<Down>')
noremap <expr> <Plug>OptionsWrapModeUp              (&wrap ? 'g<Up>'   : '<Up>')

nnoremap <Plug>OptionsToggleGUIToolbar              :ToggleGUIOption t<CR>
nnoremap <Plug>OptionsToggleGUIToolbarBottom        :ToggleGUIOption b<CR>
nnoremap <Plug>OptionsToggleGUIToolbarLeft          :ToggleGUIOption l<CR>
nnoremap <Plug>OptionsToggleGUIToolbarRight         :ToggleGUIOption t<CR>

nnoremap <Plug>OptionsToggleCaseSensitiveSearching  :ToggleCaseSensitiveSearching<CR>
nnoremap <Plug>OptionsToggleCursorColumnLine        :ToggleCursorColumnLine<CR>
nnoremap <Plug>OptionsToggleExpandTab               :ToggleExpandTabbing<CR>
nnoremap <Plug>OptionsToggleIndentMode              :ToggleIndentMode<CR>
nnoremap <Plug>OptionsToggleLineNumber              :ToggleLineNumbering<CR>
nnoremap <Plug>OptionsToggleTextWrap                :ToggleTextWrap<CR>
nnoremap <Plug>OptionsToggleListMode                :ToggleRevealCharacters<CR>
nnoremap <Plug>OptionsToggleSearchHighlighting      :ToggleSearchHighlighting<CR>
nnoremap <Plug>OptionsToggleSpellChecking           :ToggleSpellChecking<CR>
nnoremap <Plug>OptionsToggleTextMargins             :ToggleTextMargins<CR>

nnoremap <Plug>ShowTextWidthDialog                  :ShowTextWidthDialog<CR>
nnoremap <Plug>ShowSearchPathDialog                 :ShowSearchPathDialog<CR>
nnoremap <Plug>ShowTagsDialog                       :ShowTagsDialog<CR>
nnoremap <Plug>ShowFileFormatDialog                 :ShowFileFormatDialog()<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

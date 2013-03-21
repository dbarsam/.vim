" ===================================================================
"            Commands for interacting with the OS via VIM
" ===================================================================
" File:           settings/system.vim
" Purpose:        System commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_system_plugin')
   finish 
endif 
let g:loaded_settings_system_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
" Saving
com! -nargs=0 SaveToDesktop                     call settings#system#SaveCopyToDesktop()
com! -nargs=0 SaveCopyAsBackup                  call settings#system#SaveCopyAsBackup()
com! -nargs=0 ToggleCopyBackup                  call settings#system#ToggleAutoCopyBackup()

com! -complete=file	-nargs=? ShowInExplorer     call settings#system#ShowInExplorer(<f-args>)
com! -complete=file	-nargs=? ShowInConsole      call settings#system#ShowInCommandPrompt(<f-args>)
com! -complete=file	-nargs=? ShowInPowerShell   call settings#system#ShowInPowerShell(<f-args>)

" Binary Conversion Commands
if has("vms")
    com! -nargs=? XXD                           %!mc vim:xxd <args>
elseif (has("win32") || has("dos32")) && !executable("xxd")
    com! -nargs=? XXD                           exe '%!'. shellescape($VIMRUNTIME . (&shellslash ? '/' : '\') . 'xxd.exe') . ' '. <args> 
else
    com! -nargs=? XXD                           %!xxd <args>
endif
com! -bar -nargs=? ToggleHexMode                call settings#system#ToggleHexMode(<f-args>)

" Path Text Manipulation
com! -nargs=0 OpenFilePathFromClipboard         call settings#system#OpenFilePathFromClipboard()
com! -nargs=1 CopyFilePathToClipboard           call settings#system#CopyFilePathToClipboard(<f-args>)
com! -nargs=0 OpenFileFromText                  call settings#system#OpeFileFromText()
com! -range   LaunchURL                         call settings#system#LaunchURL()
com! -nargs=0 ConvertPathToUNC                  call settings#system#ConvertToUNC(<f-args>)

" SymLink Manipulation
com! -bar -nargs=+ GenerateSymLink              call settings#system#settings#system#GenerateSymLink(<f-args>)

"  File Commands
com! -nargs=0 FileNew                           confirm enew
com! -nargs=0 FileSplitOpen                     browse confirm sp
com! -nargs=0 FileOpen                          browse confirm e
com! -nargs=0 FileClose                         call settings#system#CloseBuffer()
com! -nargs=0 FileSave                          call settings#system#SaveBuffer()
com! -nargs=0 FileSaveAs                        browse confirm saveas

" Printing Commands
if has("printer")
    com! -range=% -nargs=0 FilePrint            <line1>,<line2>hardcopy
elseif has("unix")
    com! -range=% -nargs=0 FilePrint            <line1>,<line2>w !lpr
endif

" Exit Commands
com! -nargs=0 Exit                              confirm qa
com! -nargs=0 ExitSave                          confirm wqa

" ============
" Plugin Mapping
" ============
nnoremap <Plug>SystemFileNew                    :FileNew<CR>
nnoremap <Plug>SystemFileOpen                   :FileOpen<CR>
nnoremap <Plug>SystemFileClose                  :FileClose<CR>
nnoremap <Plug>SystemFileSave                   :FileSave<CR>
nnoremap <Plug>SystemFileSaveAs                 :FileSaveAs<CR>
nnoremap <Plug>SystemFileSplitOpen              :FileSplitOpen<CR>

nnoremap <Plug>SystemFilePrint                  :FilePrint<CR>
vnoremap <Plug>SystemFilePrint                  :FilePrint<CR>

nnoremap <Plug>SystemExit                       :Exit<CR>
nnoremap <Plug>SystemExitSave                   :ExitSave<CR>

nnoremap <Plug>SystemFileSaveToDesktop          :SaveToDesktop<CR>
nnoremap <Plug>SystemFileSaveAsBackup           :SaveCopyAsBackup<CR>

nnoremap <Plug>SystemShowFileInExplorer         :ShowInExplorer<CR>
nnoremap <Plug>SystemShowFolderInConsole        :ShowInConsole<CR>
nnoremap <Plug>SystemShowFolderInPowershell     :ShowInPowerShell<CR>

nnoremap <Plug>SystemCopyPathHead               :CopyFilePathToClipboard path<CR>
nnoremap <Plug>SystemCopyPathFull               :CopyFilePathToClipboard full<CR>
nnoremap <Plug>SystemOpenFromClipboard          :OpenFilePathFromClipboard<CR>

" Special Exploring Maps
for var in ["$HOME", "$VIMRUNTIME", "$DESKTOP", "$VIMFILES"]
    let s:mapvar = substitute(tolower(var),'\$\(\<\w\+\>\)', '\u\1', 'g')
    if exists(var)
        execute 'nnoremap <Plug>SystemFileExplore'.s:mapvar.' :ShowInExplorer '.var.'<CR>'
    endif
    unlet s:mapvar
endfor

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

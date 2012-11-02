" ===================================================================
"       ViM Syntax and Color Scheme Commands for VIM
" ===================================================================
" File:           autoload/settings/syntax.vim
" Purpose:        Syntax and color scheme commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_syntax_plugin') 
   finish 
endif 
let g:loaded_settings_syntax_plugin = 1

" ============
" Plugin Requirements
" ============
runtime settings/statusline.vim

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ===========
" Plugin Data
" ===========
" Highlighting & Coloring Variables
if has("gui_running")
    let g:ColorList = 
            \ {
            \ "default" : "rusty",
            \ "dark"    : "rusty",
            \ "light"   : "dirty"
            \ }"
else
    let g:ColorList = 
            \ {
            \ "default" : "rainy",
            \ "dark"    : "rainy",
            \ "light"   : "foggy"
            \ }"
endif

if exists("g:StatusLines")
    let g:StatusLines['color']  = ""
    let g:StatusLines['color'] .= "[%3.3n"                          " buffer number
    let g:StatusLines['color'] .= "%H%M%R%W]"                       " flags
    let g:StatusLines['color'] .= " %t"                             " file name
    let g:StatusLines['color'] .= " %<"                             " truncate marker
    let g:StatusLines['color'] .= " [%{settings#syntax#SynID()}"            " color scheme item id
    let g:StatusLines['color'] .= " %{settings#syntax#SynColor()}"          " color values
    let g:StatusLines['color'] .= " %{settings#syntax#SynAttribute()}]"     " color attributes
    let g:StatusLines['color'] .= "%="                              " right align marker
    let g:StatusLines['color'] .= "(%3l,%3c%V)"                     " line & column
    let g:StatusLines['color'] .= " [%{settings#syntax#ColorSchemeName()}," " color scheme name
    let g:StatusLines['color'] .= "%{&fileencoding},"               " file encoding
    let g:StatusLines['color'] .= "%{&fileformat},"                 " file format
    let g:StatusLines['color'] .= "%L]"                             " number of lines
    let g:StatusLines['color'] .= " %3.p%%"                         " percentage of buffer
endif

" ===========
" Plugin Highlight Groups
" ===========
hi link CustomWhiteSpaceError   Error
hi link CustomLineLengthWarning WarningMsg
hi link CustomLineLengthError   Error 

" ============
" Syntax Init
" ============
func! EnableColorScheme(name, verbose)
    hi clear
    if a:name == ""
        syntax off
        syntax reset
        let message =  "Syntax Colouring: Off (" . &background . ")"
    else
        let inlist = exists("g:ColorList") && has_key(g:ColorList, a:name)
        if l:inlist
            let l:colorname = g:ColorList[a:name]
        else
            let l:colorname = a:name
        endif
        if (globpath(&runtimepath, 'colors/'.l:colorname.'.vim') != '')
            syntax on
            syntax reset
            execute "colorscheme " . l:colorname
            if l:inlist
                let message = "Syntax Colouring: On - Color Scheme ".g:ColorList[a:name]." (" . a:name .")"
            else
                let message = "Syntax Colouring: On - Color Scheme ".a:name"
            endif
        else
            syntax off
            syntax reset
            let message = "Syntax Colouring: Off - No syntax highlighting defintions available for (".a:name.")"
        endif
    endif    
    redraw
    if a:verbose && exists("l:message")
        echomsg l:message
    endif    
endf

" ============
" Plugin Commands
" ============
com! -bar -nargs=1 -complete=customlist,settings#syntax#SetSyntaxModeArgs SetSyntaxMode   call settings#syntax#SetSyntaxMode(<f-args>)

com! -bar -nargs=1 SyntaxInit                                   call EnableColorScheme(<f-args>, 0)
com! -bar -nargs=1 EnableColorScheme                            call EnableColorScheme(<f-args>, 1)

com! -bar -nargs=0 ToggleColorPreset                            call settings#syntax#ColorPresetToggle()
com! -bar -nargs=0 ToggleColorScheme                            call settings#syntax#ColorSchemeToggle()
com! -bar -nargs=0 ToggleSyntaxHighlightingMode                 call settings#syntax#SetSyntaxMode( has("syntax_items") ? 'off' : 'automatic' )

com! -bar -nargs=0 ColorSchemeReset                             call settings#syntax#ColorSchemeReset()
com! -bar -nargs=0 ColorSchemeRefresh                           call settings#syntax#ColorSchemeRefresh()

com! -bar -nargs=0 GoToNextColorScheme                          call settings#syntax#ColorSchemeCycle(1)
com! -bar -nargs=0 GoToPrevColorScheme                          call settings#syntax#ColorSchemeCycle(-1)

com! -bar -nargs=0 SyntaxHighlightLineLength                    call settings#syntax#ColorLineLengthHighlight(0)
com! -bar -nargs=0 SyntaxHighlightLineLengthRefresh             call settings#syntax#ColorLineLengthHighlight(1)

com! -bar -nargs=1 SyntaxHighlightWhiteSpace                    call settings#syntax#ColorWhiteSpaceHighlight(<f-args>)

com!      -nargs=0 SyntaxColorTest                              sp $VIMRUNTIME/syntax/colortest.vim<Bar>so %
com!      -nargs=0 SyntaxHighlightTest                          runtime syntax/hitest.vim
com!      -nargs=0 SyntaxConvertToHTML                          runtime syntax/2html.vim

" ============
" Plugin Mappings
" ============
nnoremap <Plug>SyntaxToggleColorPreset                          :ToggleColorPreset<CR>
nnoremap <Plug>SyntaxToggleColorScheme                          :ToggleColorScheme<CR>
nnoremap <Plug>SyntaxToggleSyntaxHighlightingMode               :ToggleSyntaxHighlighting<CR>

nnoremap <Plug>SyntaxHighlightLineLength                        :SyntaxHighlightWhiteSpace<CR>

nnoremap <Plug>SyntaxHighlightWhiteSpaceDisable                 :SyntaxHighlightWhiteSpace ''<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceTrailing                :SyntaxHighlightWhiteSpace e<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceLeading                 :SyntaxHighlightWhiteSpace b<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceIndenting               :SyntaxHighlightWhiteSpace i<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceFloatingTabs            :SyntaxHighlightWhiteSpace t<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceMixedSpaceTabs          :SyntaxHighlightWhiteSpace s<CR>
nnoremap <Plug>SyntaxHighlightWhiteSpaceTrailingInteractive     :SyntaxHighlightWhiteSpace E<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

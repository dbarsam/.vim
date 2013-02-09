" ===================================================================
"     ViM StatusLine, Title, and Ruler Autoload Function for VIM
" ===================================================================
" File:           autoload/settings/statusline.vim
" Purpose:        Vim statusline commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Status Line String Format Functions
" ============
function! settings#statusline#FileType() abort
    return strlen(&ft) ? &ft : "none"
endfunction

function! settings#statusline#Time() abort
    return exists("*strftime") ? strftime("%b-%d-%y %I:%M%p") : ""
endfunction

" ============
" Enables a specific Title String
" ============
func! settings#statusline#EnableTitleString(type) abort
    if has('title') && exists("g:TitleStrings") && has_key(g:TitleStrings, a:type)
        execute "set titlestring =".escape(g:TitleStrings[a:type], '" ')
    endif
endfunction

" ============
" Enables a specific Ruler
" ============
func! settings#statusline#EnableRuler(type) abort
    elseif has('cmdline_info') && exists("g:RulerFormats") && has_key(g:RulerFormats, a:type)
        setlocal ruler
        execute "setlocal ruler =".escape(g:RulerFormats[a:type], ' ')
    endif
endf

" ============
" Enables a specific Status Line
" ============
func! settings#statusline#EnableStatusLine(type) abort
    if has('statusline') && exists("g:StatusLines") && has_key(g:StatusLines, a:type)
        execute "setlocal statusline =".escape(g:StatusLines[a:type], ' ')
    endif
endf

" ============
" Update Window
" ============
func! settings#statusline#UpdateWindow() abort
    
    if exists("b:TitleString") 
        call settings#statusline#EnableTitleString(b:TitleString)
    elseif exists("g:TitleString") 
        call settings#statusline#EnableTitleString(g:TitleString)
    elseif exists("s:TitleString")
        call settings#statusline#EnableTitleString(s:TitleString)
    else
        call settings#statusline#EnableTitleString('default')
    endif

    if exists("b:StatusLine") 
        call settings#statusline#EnableStatusLine(b:StatusLine)
    elseif exists("g:StatusLine") 
        call settings#statusline#EnableStatusLine(g:StatusLine)
    elseif exists("s:StatusLine") 
        call settings#statusline#EnableStatusLine(s:StatusLine)
    else
        call settings#statusline#EnableStatusLine('default')
    endif
endfunction
" ===================================================================
" End
" ===================================================================

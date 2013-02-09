" ===================================================================
"                Language Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/language.vim
" Purpose:        Custom language commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Resets the Language
" ============
function! settings#language#LanguageReset() abort
    if exists("s:LanguageKeyMap")
        let &keymap = s:LanguageKeyMap
        unlet s:LanguageKeyMap
    endif

    if exists("s:LanguageFontReset")
        let &guifontwide = s:LanguageFontReset
        unlet s:LanguageFontReset
    endif

    redraw
endfunction

" ============
" Language Mode
" ============
function! settings#language#SetLanguageMode(language) abort
    if exists("g:LanguageFont") && has_key(g:LanguageFont, a:language)
        call settings#language#SetFont(g:LanguageFont[a:language])
    endif

    if exists("g:LanguageKeyMap") && has_key(g:LanguageKeyMap, a:language)
        call settings#language#SetKeyMap(g:LanguageKeyMap[a:language])
    endif

    if exists("g:LanguageList") && has_key(g:LanguageList, a:language)
        if globpath(&runtimepath, 'spell/**/'.g:LanguageList[a:language].'.*.spl') != ''
            exe "set spl = ". g:LanguageList[a:language] . " spell"
        endif
        echomsg "Current Language Mode: ". a:language
    endif
endfunction

" ============
" Wide Fonts
" ============
function! settings#language#SetFont(font) abort
    if !exists("s:LanguageFontReset")
        let s:LanguageFontReset = &guifontwide
    endif        
    let &guifontwide = a:font
    redraw
endfunction

" ============
" Generate the List of Key Map Files
" ============
function! settings#language#KeyMapList(path)
    return map( split(globpath(&runtimepath, "keymap/*.vim"), '\n'), '[substitute(v:val, ''\c.*[/\\:\]]\([^/\\:_]*\)\(_[0-9a-zA-Z-]*\)\=\.vim'', ''\1'', ''''), v:val]')
endfunction

" ============
" Key Map
" ============
function! settings#language#SetKeyMap(keymap) abort
    if globpath(&runtimepath, 'keymap/**/'.a:keymap.'*.vim') != ''
        if !exists("s:LanguageKeyMap")
            let s:LanguageKeyMap = &keymap
        endif        

        let &keymap = a:keymap
        echomsg "Keyboard Mapping: " . &keymap == "" ? "None" : &keymap
    endif
endfunction

" ============
" Generate the List of Spelling Dictionaries
" ============
function! settings#language#SpellingDictionaryList(path)
    return map( split(globpath(a:path, "spell/*.spl"), '\n'), '[substitute(v:val, ''.*spell[/\\]\(..\)\.[^/\\]*\.spl'', ''\1'', ''''), fnamemodify(v:val, '':t:r''), v:val]')
endfunction

" ============
" Spelling Dictionaries
" ============
function! settings#language#SetSpellingDictionary(dict) abort
    exe 'set spl='.a:dict.' spell'
    echomsg "Spelling Dictionary: " . &spl == "" ? "None" : &spl
endfunction


" ===================================================================
" End
" ===================================================================

" ===================================================================
"            Text Manipulation Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/text.vim
" Purpose:        Text commands the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Select All
" ============
func! settings#text#TextSelectAll() abort
    exe "normal! gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endf

" ============
" Michael Naumann's Visual Search
" Based on: http://amix.dk/blog/viewEntry/19334
"           http://vim.wikia.com/wiki/VimTip171
" ============
function! settings#text#TextVisualSearch(flag) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:flag == '*'
        execute "normal! /" . l:pattern . "^M"
    elseif a:flag == 'gv'
        execute "vimgrep " . '/'. l:pattern . '/' . ' **/*.'
    elseif a:flag == '#'
        execute "normal! ?" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" ============
" Paste
" ============
func! settings#text#TextPaste() abort
    let paste_state = &paste
    set paste
    normal! p`[=`]
    let &paste = paste_state
endf

" ============
" Send All Matching Lines to the clipboard
" Based on: http://vim.wikia.com/wiki/Copy_the_search_results_into_clipboard
" ============
func! settings#text#TextSendSearchResultsToClipboard() abort
    let posinit = getpos(".")
    call cursor(1, 1)
    let cnt = 0
    let hits = []
    let snum = search(@/, 'cW')
    while snum > 0
        let enum = search(@/, 'ceW')
        call extend(hits, getline(snum, enum))
        let cnt += 1
        normal! $
        let snum = search(@/, 'W')
    endwhile
    if cnt > 0
        let @+ = join(hits, "\n") . "\n"
    endif
    call cursor(posinit[1], posinit[2])
    echomsg cnt 'lines (or blocks) were appended to the clipboard.'
endf

" ============
" Replace the carriage return and new line character with a standard escape
" Based on system menu.vim
" ============"
fun! settings#text#ConvertNewLine(text)
    return substitute(a:text, "[\r\n]", '\\n', 'g')
endfunction

" ============
" Redirect command output into a register 
" Based on: http://vim.sourceforge.net/scripts/script.php?script_id=401
" ============
function! settings#text#RedirectOutputToRegister(reg, cmd)
    " redirects the output of the a:cmd command(s) into register a:reg
    let reg = a:reg
    exe 'redir @' . reg
    let cmd = a:cmd
    let idx = stridx(cmd, '|')
    while idx >= 0 
	if idx > 0
	    let part = strpart(cmd, 0, idx - 1)
	    if part != ""
		exe ':silent! ' . part
		exe 'redir END'
		exe 'redir @' . toupper(a:reg)
	    endif
	endif
	let cmd = strpart(cmd, idx+1)
	let idx = stridx(cmd, '|')
    endwhile
    exe ':silent! ' . cmd 
    exe 'redir END'
endfunction

" ===================================================================
" End
" ===================================================================

" ===================================================================
"       ViM Syntax and Color Scheme Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/syntax.vim
" Purpose:        Syntax and color scheme commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Get the Syn ID of the item under the cursor
" Based On: http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
" ============
function! settings#syntax#SynID() abort
    return 'hi[' . synIDattr(synID(line("."),col("."),1),"name") . '] trans[' . synIDattr(synID(line("."),col("."),0),"name") . "] lo[" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . "]"
endfunction

" ============
" Get the coloring of the item under the cursor
" ============
function! settings#syntax#SynColor() abort
    let i = synIDtrans(synID(line("."),col("."),1))
    return 'fg['.synIDattr(i,"fg") . '-' . synIDattr(i,"fg#") .'] bg['.synIDattr(i,"bg") . '-' . synIDattr(i,"bg#") .']'
endfunction

" ============
" Get the attributes of the item under the cursor
" ============
function! settings#syntax#SynAttribute() abort
    let i = synIDtrans(synID(line("."),col("."),1))
    let result = 'attrb['
    for a in ["bold", "italic", "reverse", "inverse", "underline", "undercurl"]
        if (synIDattr(i,a))
            if result == ''
                let result = a
            else
                let result .= ' ' . a
            endif
        endif
    endfor
    let result .= ']'
    return result
endfunction

" ============
" Get a Formatted Color Scheme Name
" ============
function! settings#syntax#ColorSchemeName() abort
    let name = exists('g:colors_name') ? g:colors_name : ""
    if &background == 'dark'
        let name .= " (dark)"
    elseif &background == 'light'
        let name .= " (light)"
    endif
    return name
endfunction

" ============
" Reload the current Color Scheme
" ============
function! settings#syntax#ColorSchemeRefresh() abort
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
    execute "colorscheme " . g:colors_name
endfunction

" ============
" Generate the List of Color Names
" ============
function! settings#syntax#ColorList(path)
    return map( split(globpath(a:path, "colors/*.vim"), '\n'), '[fnamemodify(v:val, '':t:r''), v:val]')
endfunction

" ============
" Toggle Syntax Highlighting via Prompt
" ============
function! settings#syntax#SetSyntaxModePrompt() abort
    let list = ['Select a Syntax Mode...', 
                \ '1. On (Manual)',
                \ '2. On (Automatic)',
                \ '3. Off',
                \ '4. Clear',
                \ '5. On  (Local to File)',
                \ '6. Off (Local to File)']
    let choice = inputlist(l:list)
    if choice != 0
        call settings#syntax#SetSyntaxMode(settings#syntax#SetSyntaxModeArgs(0,0,0)[l:choice])
    endif
endfunction

" ============
" Visual Diff Argument Complete Function
" ============
function! settings#syntax#SetSyntaxModeArgs(ArgLead,CmdLine,CusrorPos) abort
    return ["manual", "automatic", "on", "off", "clear", "on-file", "off-file"]
endfunction

" ============
" Toggle Syntax Highlighting
" ============
function! settings#syntax#SetSyntaxMode(type) abort
    if a:type == 'manual'
        syntax manual
        redraw
        echomsg "Syntax Highlighting: On (Manual)"
    elseif a:type == 'automatic'
        syntax on
        redraw
        echomsg "Syntax Highlighting: On (Automatic)"        
    elseif a:type == 'clear'
        syntax clear
        redraw
        echomsg "Syntax Highlighting: Cleared Highlighting Info"
    elseif a:type == 'on'
        syntax enable
        redraw
        echomsg "Syntax Highlighting: On"
    elseif a:type == 'off'
        syntax off
        redraw
        echomsg "Syntax Highlighting: Off"
    elseif a:type == 'off-file'
        set syntax=OFF
        redraw
        echomsg "Syntax Highlighting: Disabled in Current File"
    elseif a:type == 'on-file'
        if !exists("g:syntax_on")
            syntax manual
        endif
        set syntax=ON
        redraw
        echomsg "Syntax Highlighting: Enabled in Current File"
    endif
endfunction

" ============
" Toggle color schemes via none, light, dark
" ============
function! settings#syntax#ColorSchemeToggle() abort
    if has('syntax_items')
        syntax off
        syntax reset
        let message = "Syntax Colouring: Off"
    elseif(&background == 'dark')
        let &background = 'light'
        syntax on
        syntax reset
        let message = "Syntax Colouring: On - Color Scheme " . settings#syntax#ColorSchemeName()
    elseif(&background == 'light')
        let &background = 'dark'
        syntax on
        syntax reset
        let message = "Syntax Colouring: On - Color Scheme " . settings#syntax#ColorSchemeName()
    endif
    redraw
    echomsg l:message
endfunction

" ============
" Toggle color schemes via none, light, dark
" ============
function! settings#syntax#ColorPresetToggle() abort
    if has('syntax_items')
        call EnableColorScheme("", 1)
    elseif(&background == 'dark')
        call EnableColorScheme("light", 1)
    elseif(&background == 'light')
        call EnableColorScheme("dark", 1)
   endif
endfunction

" ============
" Cycle through all of the color schemes 
" ============
function! settings#syntax#ColorSchemeCycle(direction) abort
    let s:colors_name_list = settings#syntax#ColorList(&runtimepath)

    if !exists("s:colors_name_index")
        let s:colors_name_index = 0
        for [colorname, colorfile] in s:colors_name_list
            if colorname == g:colors_name
                break
            endif
            let s:colors_name_index += 1
        endfor
    endif
    let s:colors_name_index = ( s:colors_name_index + a:direction ) % len(s:colors_name_list)

    if (s:colors_name_index < 0)
        let s:colors_name_index = len(s:colors_name_list) - 1
    endif

    call EnableColorScheme( s:colors_name_list[s:colors_name_index][0], 0)

    echomsg "Color Scheme: #". s:colors_name_index ." - ".(exists("g:colors_name") ? g:colors_name : "NONE")." (".s:colors_name_list[s:colors_name_index][1].")"
endfunc

" ============
" Enable a particular color schemes by way of its index
" ============
function! settings#syntax#ColorSchemeEnable(index) abort
    let s:colors_name_list = settings#syntax#ColorList(&runtimepath)

    let s:colors_name_index = a:index % len(s:colors_name_list)
    if (s:colors_name_index < 0)
        let s:colors_name_index = 0
    endif

    call EnableColorScheme( s:colors_name_list[s:colors_name_index][0], 0)
    echomsg "Color Scheme: #". s:colors_name_index ." - ".(exists("g:colors_name") ? g:colors_name : "NONE")." (".s:colors_name_list[s:colors_name_index][1].")"
endfunc

" ============
" Find the color scheme's file
" ============
function! settings#syntax#FindColorSchemeFile(colorname)
    for [colorname, colorfile] in settings#syntax#ColorList(&runtimepath)
        if colorname == g:colors_name
            return colorfile
        endif
    endfor
    return ""
endfunction

" ============
" Reset the Color Scheme
" ============
function! settings#syntax#ColorSchemeReset() abort
    call EnableColorScheme("default", 0)
    redraw
    echomsg "Color Scheme: ".(exists("g:colors_name") ? g:colors_name : "NONE")." (". settings#syntax#FindColorSchemeFile(g:colors_name).")"
endfunc

" ============
" Whitespace Highlighting
" Based On: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Based On: http://vim.wikia.com/wiki/Highlight_some_whitespace_characters
" ============
" flags is '' to clear highlighting, or is a string to
" specify what to highlight (one or more characters):
"   e  toggles whitespace at end of line
"   b  toggles whitespace at beginning of line
"   i  toggles spaces used for indenting
"   s  toggles spaces before a tab
"   t  toggles tabs not at start of line
"   E  toggles whitespace at end of line - except when typing at the end of a line. 
"   '' clears all whitespace highlighting
fun! settings#syntax#ColorWhiteSpaceHighlight(flags) abort

    let pat = []
    let msg = []
    for c in split(a:flags, '\zs')
        if c == 'e' || c == 'E' 
            if c == 'E' && index(pat, '\s\+$') == -1
                call add(pat, '\s\+\%#\@<!$')
                call add(msg, 'Trailing Whitespace (except while typing)')
            elseif c == 'e' && index(pat, '\s\+\%#\@<!$') == -1
                call add(pat, '\s\+$')
                call add(msg, 'Trailing Whitespace')
            endif
        elseif c == 'b'
            call add(pat, '^\s* \s*')
            call add(msg, 'Leading Whitespace')
        elseif c == 'i'
            call add(pat, '^\t*\zs \+')
            call add(msg, 'Spaces In Indents')
        elseif c == 's'
            call add(pat, ' \+\ze\t')
            call add(msg, 'Spaces Before Tabs')
        elseif c == 't'
            call add(pat, '[^\t]\zs\t\+')
            call add(msg, 'Floating Tabs')
        endif
    endfor

    if len(pat) > 0
        let s = join(pat, '\|')
        let m = join(msg, ' - ')

        if exists("s:colors_whitespace_match")
            let matches = getmatches()
            let pattern_exists = 0
            for item in matches
                let pattern_exists = item.id == s:colors_whitespace_match && item.pattern == s
                if pattern_exists
                    break
                endif
            endfor
            call matchdelete(s:colors_whitespace_match)
            unlet s:colors_whitespace_match

            if !pattern_exists
                let s:colors_whitespace_match = matchadd("CustomWhiteSpaceError", s )
            endif
        else
            let s:colors_whitespace_match = matchadd("CustomWhiteSpaceError", s )
        endif       

        echomsg "White Space Highlighting (". m ."): " . (exists("s:colors_whitespace_match") ? "On" : "Off")
    else
        if exists("s:colors_whitespace_match")
            call matchdelete(s:colors_whitespace_match)
            unlet s:colors_whitespace_match
        endif
        echomsg "White Space Highlighting: Off"
    endif
endfunction

" ============
" Line Length Highlighting
" Based On: http://vim.wikia.com/wiki/Highlight_long_lines
" ============
function! settings#syntax#ColorLineLengthHighlight(update) abort

    let l:linelength_error = &textwidth + 1
    let l:linelength_warning = &textwidth - 11

    " Build the regex pattern - if textwidth is 0 then create an impossible pattern
    if &textwidth > 0
        let l:pattern_error   = '\%'.l:linelength_error.'v.*'
        let l:pattern_warning = '\%<'.l:linelength_error.'v.\%>'.l:linelength_warning.'v'
    else
        let l:pattern_error   = '$^'
        let l:pattern_warning = '$^'
    endif

    " If updating implies that we want to maintain the current highlghlighting
    " state.  Other wise we're going to toggle it on or off.
    let l:enable = (a:update ? exists("g:colors_linelength_match") : !exists("g:colors_linelength_match"))

    if exists("g:colors_linelength_match") 
        call matchdelete(g:colors_linelength_match)
        call matchdelete(g:colors_linelength_warning)
        unlet g:colors_linelength_match
        unlet g:colors_linelength_warning
    endif

    if l:enable  
        let g:colors_linelength_match   = matchadd("CustomLineLengthError", l:pattern_error, -1)
        let g:colors_linelength_warning = matchadd("CustomLineLengthWarning", l:pattern_warning, -1)
    endif

    if (l:enable || !a:update)
        if &textwidth > 0
            echomsg "Line Length Highlighting (".&textwidth." Columns): ".(exists("g:colors_linelength_match") ? "On" : "Off")
        else
            echomsg "Line Length Highlighting Disabled (TextWidth is 0)"
        endif
    endif
endfunction

" ===================================================================
" End
" ===================================================================

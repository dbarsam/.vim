" ===================================================================
"                  Core Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/core.vim
" Purpose:        Custom core commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Launches another instance of Vim with the profile report
" ============
function! settings#core#StartupProfile() abort
    if has("startuptime") && has("gui")
        let fname =  "VimStartupProfile_".strftime("%Y%m%d_%H%M").".txt"  
        if isdirectory($TEMP)
            let fname = fnameescape($TEMP . "/". l:fname)
        else
            let fname = fnameescape($HOME . "/". l:fname)
        endif
        exe "!start gvim --startuptime ".l:fname. " ". l:fname
    endif
endfunction

" ============
" Select a session to load
" Default to current session name if present
" ============
function! settings#core#LoadVimSession()
    if strlen(v:this_session) > 0
        let name = fnameescape(v:this_session)
    else
        let name = "Session.vim"
    endif
    execute "browse so " . name
endfunction

" ============
" Select a session to save
" Default to current session name if present
" ============
function! settings#core#SaveVimSession()
    if strlen(v:this_session) == 0
        let v:this_session = "Session.vim"
    endif
    execute "browse mksession! " . fnameescape(v:this_session)
endfunction

" ============
" Edit a 'setting' by loading all of its related files
" ============
function! settings#core#EditSettings(...)
    let l:formats=[
                \ $VIMFILES . "/settings/%s.vim",
                \ $VIMFILES . "/settings/plugin-settings/%s.vim",
                \ $VIMFILES . "/autoload/settings/%s.vim"
                \ ]
    let l:files = []
    for s in a:000
        let l:files += filter(map(copy(l:formats), 'printf(v:val,"'.s.'")'), 'filereadable(v:val)')
    endfor
    if !empty(files)
        for f in files
            exe 'e '.f
        endfor
    else
        echomsg "Cannot Edit Setting:  Failed to match ".string(a:000)." to any setting file."
    endif
endfunction

" ============
" Edit 'setting' Argument Complete Function
" ============
function! settings#core#EditSettingsArgs(ArgLead,CmdLine,CusrorPos) abort
    if !exists("s:EditSettingsKeywords")
        let s:EditSettingsKeywords = sort(map(split( globpath(expand($VIMFILES."/settings").",".expand($VIMFILES."/autoload"), "**/*.vim"), '\n'), 'fnamemodify(v:val, ":t:r")'))
        let s:EditSettingsKeywords = filter(copy(s:EditSettingsKeywords), 'index(s:EditSettingsKeywords, v:val, v:key+1)==-1')        
    end
    return filter(copy(s:EditSettingsKeywords), 'match(v:val, "^'.a:ArgLead.'") != -1')
endfunction
 
" ============
" Jump to a recent file (stored in viminfo)
" ============
function! settings#core#EditRecentFile(...)
    if a:0 == 0
        browse oldfiles
    elseif a:0 == 1
        exe 'e#<' . str2nr(a:1) 
    endif
endfunction

" ============
" Select a session to view
" Default to current session name if present
" ============
function! settings#core#ViewVimSession()
    if strlen(v:this_session) == 0
        let v:this_session = "Session.vim"
    endif
    execute "confirm browse view " . fnameescape(v:this_session)
endfunction

" ============
" Edits the Current Colorscheme file
" ============
function! settings#core#EditColorscheme() abort
    if !exists("g:syntax_on")
        echomsg "Cannot Edit Colorscheme: Syntax coloring is not enable."
    elseif !exists("g:colors_name")
        echomsg "Cannot Edit Colorscheme: Syntax coloring has no color scheme file."
    else
        let colors_file = get( split(globpath(&rtp, "colors/".g:colors_name.".vim"), '\n'), 0, '')
        if filereadable(l:colors_file)
            if has($VIMFILES) && strridx(l:colors_file, $VIMFILES) != -1
                exe 'confirm edit ' . l:colors_file
            else
                exe 'confirm view ' . l:colors_file
            endif
        endif
    endif
endfunction

" ===================================================================
" End
" ===================================================================

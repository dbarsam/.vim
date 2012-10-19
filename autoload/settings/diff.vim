" ===================================================================
"                  Diff Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/diff.vim
" Purpose:        Custom diff commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
 
" ============
" Returns the Diff Status string
" ============
fun! settings#diff#DiffStatus() abort
    if &diff
        if &diffopt =~ "iwhite"
            return "iw"
        else
            return "noiw"
        endif
    else
        return ''
    endif
endfunction

" ============
" Toggle Diff Mode
" ============
func! settings#diff#EnableDiffModeSettings(toggle) abort

    if a:toggle
        if !exists("b:DiffModeRestore")
            let b:DiffModeRestore = {}
        endif

        for key in keys(g:DiffModeOverride)
            if !has_key(b:DiffModeRestore, key)	
                let b:DiffModeRestore[key] = maparg(key, "n")
            endif
            if empty(b:DiffModeRestore[key])
                execute "nmap <buffer> ".key." ".g:DiffModeOverride[key]."\")"
            else
                execute "nmap <expr> <buffer> ".key." (&diff ? \"".g:DiffModeOverride[key]."\" : \"".b:DiffModeRestore[key]."\")"
            endif
        endfor
    else
        if exists("b:DiffModeRestore")
            for key in keys(g:DiffModeOverride)
                if has_key(b:DiffModeRestore, key)	
                    execute "nunmap <buffer> ".key
                    if !empty(b:DiffModeRestore[key])
                        execute "nmap ".key." ".b:DiffModeRestore[key]
                    endif
                endif
            endfor  
            unlet b:DiffModeRestore
        endif
    endif
endf


" ============
" Standard Diff Function from Initial .vimrc
" ============
func! settings#diff#Diff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" ============
" Visual Diff Functions
" Based On: http://www.vim.org/scripts/script.php?script_id=2048
" ============
fun! settings#diff#VisualDiff(...) range

    " disable clipboard options
    let clipbackup = &clipboard
    set clipboard = ""

    " backup the unnamed register 
    let regbackup = @@

    if a:0 > 0 && a:1 == "queue" 
        if !exists("s:VisualDiffItemQueue")
            let s:VisualDiffItemQueue = []
        endif
        " copy the current selection into the unnamed register and store the value into the queue
        exe a:firstline . "," . a:lastline . "y"
        call add(s:VisualDiffItemQueue, @@)
        echo "Visual Selection Queued for Visual Diff (" . len(s:VisualDiffItemQueue) . " items)"

    elseif a:0 > 0 && a:1 == "query"
        let qsize = exists("s:VisualDiffItemQueue") ? len(s:VisualDiffItemQueue) : 0
        echo "Visual Diff Selection Queue has " . l:qsize . " items."
        unlet l:qsize

    elseif a:0 > 0 && a:1 == "clear" && exists("s:VisualDiffItemQueue")
        unlet s:VisualDiffItemQueue
        echo "Visual Diff Selection Queue Cleared"

    elseif a:0 > 0 && a:1 == "compare" && exists("s:VisualDiffItemQueue")
        " copy the current selection into the unnamed register and store the value into the queue
        exe a:firstline . "," . a:lastline . "y"
        
        " open new tab, paste second selected block
        tabnew
        normal P
        " to prevent 'No write since last change' message:
        se buftype=nowrite
        diffthis

        for diffitem in s:VisualDiffItemQueue
            " vsplit left for selected block
            lefta vnew

            " copy diff item into unnamed register & paste
            let @@ = diffitem
            normal P
            se buftype=nowrite

            " start diff
            diffthis
        endfor
        call settings#diff#EnableDiffModeSettings(&diff)
        
        " clear the queue
        unlet s:VisualDiffItemQueue
    endif

    " restore unnamed register
    let @@ = l:regbackup    

    " restore clipbaord options
    exe 'set clipboard +=' . l:clipbackup
endfun

" ============
" Visual Diff Argument Complete Function
" ============
function! settings#diff#VisualDiffArgs(ArgLead,CmdLine,CusrorPos) abort
    return ["query", "clear", "compare", "queue"]
endfunction

" ============
" Compare current buffer with last saved version.
" Based On: http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
" ============" 
func! settings#diff#DiffUnsavedChanges() 
    let bufnum = bufnr('%')
    let filetype = &ft 
    tabnew
    exe "buffer " . l:bufnum
    diffthis 
    vnew | r # | normal 1Gdd 
    diffthis 
    call settings#diff#EnableDiffModeSettings(&diff)
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype 
endfunction 

" ===================================================================
" End
" ===================================================================

" ===================================================================
"         Window, Tab, and Buffer Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/windows.vim
" Purpose:        Window, Tab, and Buffer commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Toggles between all-horizontal and all-vertical window layouts.  BTW,
" to make all buffers into separate windows, use :sba.  Based on the vimtip
" http://vim.sourceforge.net/tips/tip.php?tip_id=862 and taken from 
" http://mysite.verizon.net/astronaut/vim/index.html#VimFuncs
"                    W
"    W | W | W  <=>  W
"                    W
" ============
func! settings#windows#ToggleWindowsOrientationLayout() abort
    if winnr('$') > 1
        let curwin= winnr()
        if curwin == 1
            " try to go down one window
            wincmd j
            let isvert= winnr() != curwin
            wincmd k
        else      
            " try to go up one window
            wincmd k
            let isvert= winnr() != curwin
            wincmd j
        endif

        if isvert
            windo wincmd H
            echomsg "Window Orientation Layout: Vertical"
        else
            windo wincmd K
            echomsg "Window Orientation Layout: Horizontal"
        endif

       wincmd = 
   else
       echo "Window Orientation Layout: Unchanged"
   endif
endfunc

" ============
" Toggle Windows Scroll Locking
" ============
func! settings#windows#ToggleWindowsScrollBind() abort
    let currwin=winnr()
    windo set scrollbind!
    syncbind
    execute currwin . 'wincmd w'    
    echo "Scroll Binding: " . strpart("OffOn", 3 *&scrollbind, 3)
endf

" ============
" Resize all windows equally with a restriction
"   'r'   equalizes rows to the same height
"   'c'   equalizes columns to the same width
" ============
func! settings#windows#WinEqualize(flag) abort
    if winnr('$') > 1 && (a:flag == 'r' || a:flag == 'c')
        
        " Save focused window number
        let currwin = winnr()

        if a:flag == 'r'         " Equalize all rows
            let sizeOption  = "winfixwidth"
            let sizeMessage = "Window Resize: Equal Rows"
        elseif a:flag == 'c'    " Equalize all columns
            let sizeOption  = "winfixheight"
            let sizeMessage = "Window Resize: Equal Columns"
        endif

        " Collect the various window states
        let states = {}
        windo execute "let l:states[".winnr()."] = &".l:sizeOption

        " Lock the dimension and execute the command
        execute "windo set ".sizeOption
        execute "wincmd ="

        " Restore the state
        windo execute "let &".l:sizeOption."= l:states[".winnr()."]"

        " Restore the focus 
        execute currwin . 'wincmd w'

        echomsg l:sizeMessage
    else
        echomsg "Window Resize: Unchanged"
    endif
endf

" ============
" Open Vim's Internal File Explorer
" ============
func! settings#windows#WinExplorer() abort
    if @% == ""
        20vsp .
    else
        exe "20vsp " . s:FnameEscape(expand("%:p:h"))
    endif
endfunc


" ============
" List open tabs & windows
" ============
func! settings#windows#WinList() abort
    let t = 1
    let w = 0
    echo ":LS"
    if tabpagenr('$') == 1
        let bufs = tabpagebuflist(t)
        while w < tabpagewinnr(t, '$')
            echo "  " . w ."\t".bufname(bufs[w])
            let w += 1
        endwhile
    else
        while t <= tabpagenr('$')
            echo "  Tab [" . t . "]:"
            let bufs = tabpagebuflist(t)
            let w = 0
            while w < tabpagewinnr(t, '$')
                echo "\t" . w . "\t".bufname(bufs[w])
                let w += 1
            endwhile
            let t += 1
        endwhile
    endif
endfunc

" ============
" Arrange Tabs
" Based On: http://vim.wikia.com/wiki/Move_the_current_tabpage_forward_or_backward
" ============
function settings#windows#TabMove(direction)
    let tab_count = tabpagenr('$')
    if l:tab_count > 1

        let current_tab = tabpagenr() - 1
        let next_tab = l:current_tab + a:direction

        if a:direction > 0              " Move to the Right
            execute 'tabmove' (next_tab > tab_count ? tab_count : next_tab)
        elseif a:direction < 0          " Move to the Left
            execute 'tabmove' (next_tab < 0 ? 0 : next_tab)
        endif
    endif
endfunction

" ============
" A version of WinDo that restores the cursor to the initial window
" Based on VimTip: Windo and Bufdo (http://vim.wikia.com/wiki/Windo_and_Bufdo)
" ============
function! settings#windows#WinDo(command) abort
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction

" ============
" A version of BufDo that restores the cursor to the initial buffer
" Based on VimTip: Windo and Bufdo (http://vim.wikia.com/wiki/Windo_and_Bufdo)
" ============
function! settings#windows#BufDo(command) abort
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction

" ============
" A version of TabDo that restores the cursor to the initial tab
" Based on VimTip: Windo and Bufdo (http://vim.wikia.com/wiki/Windo_and_Bufdo)
" ============
function! settings#windows#TabDo(command) abort
  let currTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currTab
endfunction

" ===================================================================
" End
" ===================================================================

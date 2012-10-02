" ===================================================================
"                  Font Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/fonts.vim
" Purpose:        Custom font commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Register A Font
" ============
func! settings#fonts#FontRegister(key, font) abort
    if !exists("g:FontList")
        let g:FontList = {}
    endif
    let g:FontList[a:key] = a:font
endfunc


" ============
" Resets the Fonts
" ============
func! settings#fonts#FontReset() abort
    if exists("s:FontSizeReset")
        call settings#fonts#FontSetSize(s:FontSizeReset)
        unlet s:FontSizeReset
    endif
endfunc

" ============
" Set the Font
" ============
func! settings#fonts#FontPreset(name, ...) abort
    if a:name == ""
       let &guifont = ""
    elseif exists("g:FontList") && has_key(g:FontList, a:name)
        let size = a:0 == 0 ?  matchstr(&guifont, '\(\:h\)\@<=[0-9.]\+') : a:1
        let &guifont = g:FontList[a:name] . ":h" . l:size

        " synchronise the wide font to match the size
        if !empty(&guifontwide)
            let &guifontwide = substitute(&guifontwide, '\:h[0-9\.]\+', ':h' . l:size, '' )
        endif
    endif
    redraw
    echomsg "Current Font: ". &guifont . (&guifontwide != "" ? " (Wide Font: " . &guifontwide . ")" : "")
endfunc

" ============
" Set the Size of the Font
" ============
func! settings#fonts#FontSetSize(value) abort
    if !exists("s:FontSizeReset")
        let s:FontSizeReset = matchstr(&guifont, '\(\:h\)\@<=[0-9.]\+')
    endif

    let &guifont = substitute(&guifont, '\:h[0-9\.]\+', ':h' . a:value, '' )

    " synchronise the wide font to match the size
    if !empty(&guifontwide)
        let &guifontwide = substitute(&guifontwide, '\:h[0-9\.]\+', ':h' . a:value, '' )
    endif

    redraw
    echomsg "Current Font: ". &guifont . (&guifontwide != "" ? " (Wide Font: " . &guifontwide . ")" : "")
endfunc

" ============
" Increase the Size of the Font
" ============
func! settings#fonts#FontAdjustSize(increment) abort
    let l:size = matchstr(&guifont, '\(\:h\)\@<=[0-9.]\+')
    let l:size = ( (size + a:increment) < 1 ) ? 1 : ( size + a:increment )
    call settings#fonts#FontSetSize(l:size)
endfunc

" ============
" Toggle The Font's Attribute
" ============
func! settings#fonts#FontToggleAttribute(attribute) abort
   let l:boldflag = matchstr(&guifont, '\(\:'.a:attribute.'\)')

   if (l:boldflag == "")
      let &guifont = &guifont . ":".a:attribute
      if !empty(&guifontwide)
          let &guifontwide = &guifontwide . ":".a:attribute
      endif
   else
      let &guifont = substitute(&guifont,':'.a:attribute,'','')
      if !empty(&guifontwide)
          let &guifontwide = substitute(&guifontwide,':'.a:attribute,'','')
      endif
   endif

   redraw
   echomsg "Current Font: ". &guifont . (&guifontwide != "" ? " (Wide Font: " . &guifontwide . ")" : "")
endfunc

" ===================================================================
" End
" ===================================================================

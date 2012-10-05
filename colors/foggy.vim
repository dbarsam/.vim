" Vim color file
" Maintainer:  David Barsam
" Date:        $Date: 2002/04/11 03:29:51 $ 
" Version:     $Revision: 1.0 $

set background=light	
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="foggy"

" Vim Editor Groups
hi Cursor         term=NONE                            ctermbg=DarkBlue
hi CursorColumn   term=reverse                         ctermbg=LightGrey
hi CursorLine     term=underline       cterm=underline
hi ErrorMsg       term=standout                        ctermbg=DarkRed   ctermfg=White
hi VertSplit      term=reverse         cterm=reverse  
hi Folded         term=standout                        ctermbg=LightGrey ctermfg=DarkBlue
hi FoldColumn     term=standout                        ctermbg=LightGrey ctermfg=DarkBlue
hi SignColumn     term=standout                        ctermbg=LightGrey ctermfg=DarkBlue
hi IncSearch      term=reverse         cterm=reverse
hi LineNr         term=underline                       ctermbg=LightGrey ctermfg=Black
hi MatchParen     term=reverse                         ctermbg=DarkCyan
hi ModeMsg        term=bold            cterm=bold
hi MoreMsg        term=bold                                              ctermfg=LightGreen 
hi Question       term=standout                                          ctermfg=LightGreen
hi Search         term=reverse                         ctermbg=Yellow 
hi SpecialKey     term=bold                                              ctermfg=LightBlue
hi StatusLine     term=bold,reverse                    ctermbg=DarkBlue  ctermfg=White
hi StatusLineNC   term=reverse                         ctermbg=LightGrey ctermfg=Black
hi TabLine        term=underline                       ctermbg=LightGrey ctermfg=Black 
hi TabLineFill    term=reverse         cterm=reverse  
hi TabLineSel     term=bold            cterm=bold
hi Title          term=bold                            ctermfg=LightMagenta
hi Underlined     term=underline       cterm=underline ctermfg=DarkMagenta 
hi Visual         term=reverse         cterm=reverse
hi VisualNOS      term=underline       cterm=underline
hi WarningMsg     term=standout                                          ctermfg=LightRed
hi WildMenu       term=standout                       ctermbg=Yellow     ctermfg=Black

" Internal Pop-up Menu
hi Pmenu          term=NONE                           ctermbg=Magenta    ctermfg=Black
hi PmenuSbar      term=NONE                           ctermbg=LightGrey  ctermfg=Black
hi PmenuSel       term=NONE                           ctermbg=LightGray  ctermfg=Black
hi PmenuThumb     term=reverse         cterm=reverse

" Spelling
hi SpellBad       term=standout                      ctermbg=DarkRed     ctermfg=Yellow
hi SpellCap       term=underline                     ctermbg=DarkBlue    ctermfg=Yellow
hi SpellLocal     term=underline                     ctermbg=DarkCyan    ctermfg=Yellow
hi SpellRare      term=underline                     ctermbg=DarkMagenta ctermfg=Yellow

" Diff Operations
hi DiffAdd        term=bold                           ctermbg=DarkBlue
hi DiffChange     term=bold                           ctermbg=DarkMagenta
hi DiffDelete     term=bold                           ctermfg=Blue ctermbg=DarkCyan
hi DiffText       term=reverse         cterm=bold     ctermbg=Red

" Directory Listings
hi Directory      term=bold                           ctermfg=LightRed guifg=Red

" Syntax Colouring Groups
hi NonText        term=NONE            ctermfg=LightBlue 
hi Normal         term=NONE            ctermbg=White  ctermfg=Black
hi Comment        term=bold                           ctermfg=DarkGreen 
hi Constant       term=underline,bold                 ctermfg=DarkRed
hi Special        term=bold                           ctermfg=DarkRed 
hi Identifier     term=underline                      ctermfg=DarkCyan
hi Statement      term=bold            cterm=bold     ctermfg=DarkBlue    ctermbg=White
hi PreProc        term=underline                      ctermfg=DarkMagenta
hi Type           term=underline                      ctermfg=DarkYellow
hi Error          term=reverse                        ctermbg=Red         ctermfg=White
hi Todo           term=standout                       ctermbg=DarkBlue    ctermbg=Yellow 

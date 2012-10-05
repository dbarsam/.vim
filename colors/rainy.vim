" Vim color file
" Maintainer:  David Barsam
" Date:        $Date: 2002/04/11 03:29:51 $ 
" Version:     $Revision: 1.0 $

set background=dark	
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="rainy"

" Vim Editor Groups
hi Cursor         term=NONE            cterm=reverse                          gui=NONE       guifg=#001000        guibg=wheat       
hi CursorColumn   term=reverse         ctermfg=Black        ctermbg=DarkGrey  gui=NONE                            guibg=Grey40
hi CursorLine     term=underline       ctermfg=Black        ctermbg=DarkGrey  gui=NONE                            guibg=Grey40
hi ErrorMsg       term=standout        ctermfg=White        ctermbg=DarkRed   gui=NONE       guifg=White          guibg=Red         
hi VertSplit      term=reverse         cterm=reverse                          gui=NONE       guifg=#90B090        guibg=#204020         
hi Folded         term=standout        ctermfg=Cyan         ctermbg=DarkGrey  gui=NONE       guifg=Cyan           guibg=DarkGrey
hi FoldColumn     term=standout        ctermfg=Cyan         ctermbg=DarkGrey  gui=NONE       guifg=Cyan           guibg=Grey
hi SignColumn     term=standout        ctermfg=Cyan         ctermbg=DarkGrey  gui=NONE       guifg=Cyan           guibg=Grey
hi IncSearch      term=reverse         cterm=reverse                          gui=NONE       guifg=black          guibg=Yellow         
hi LineNr         term=underline       ctermfg=Yellow       ctermbg=Black     gui=NONE       guifg=DarkGoldenrod  guibg=#001000        
hi MatchParen     term=reverse         ctermfg=Black        ctermbg=DarkCyan  gui=NONE                            guibg=DarkCyan
hi ModeMsg        term=bold            cterm=bold                             gui=bold
hi MoreMsg        term=bold            ctermfg=Green        ctermbg=Black     gui=NONE       guifg=SkyBlue        guibg=#001000        
hi Question       term=standout        ctermfg=Green        ctermbg=Black     gui=bold       guifg=SeaGreen       guibg=#001000        
hi Search         term=reverse         ctermfg=Black        ctermbg=Yellow    gui=bold       guifg=blue           guibg=Yellow         
hi SpecialKey     term=bold            ctermfg=Blue         ctermbg=Black     gui=NONE       guifg=cyan           guibg=#001000        
hi StatusLine     term=bold,reverse    ctermfg=Black        ctermbg=Gray      gui=bold       guifg=#204020        guibg=#709070       
hi StatusLineNC   term=reverse         ctermfg=Gray         ctermbg=DarkGray  gui=NONE       guifg=#90B090        guibg=#204020         
hi TabLine        term=underline       ctermfg=White        ctermbg=DarkGrey  gui=underline                       guibg=DarkGrey
hi TabLineFill    term=reverse         cterm=reverse                          gui=reverse
hi TabLineSel     term=bold            cterm=reverse                          gui=bold
hi Title          term=bold            ctermfg=Magenta      ctermbg=Black     gui=bold       guifg=Magenta        guibg=#001000        
hi Underlined     term=underline       ctermfg=Blue         ctermbg=Black     gui=underline  guifg=#80a0ff
hi Visual         term=reverse         ctermfg=Black        ctermbg=DarkGrey  gui=NONE       guifg=wheat          guibg=#4F4F4F         
hi VisualNOS      term=underline       cterm=bold,underline                   gui=NONE       guifg=wheat          guibg=#001000        
hi WarningMsg     term=standout        ctermfg=Red          ctermbg=Black     gui=NONE       guifg=black          guibg=Yellow         
hi WildMenu       term=standout        ctermfg=Black        ctermbg=Yellow    gui=NONE       guifg=Black          guibg=Yellow

" Internal Pop-up Menu
hi Pmenu          term=NONE            ctermfg=Grey         ctermbg=DarkBlue  gui=NONE       guibg=Magenta
hi PmenuSbar      term=NONE            ctermfg=Yellow       ctermbg=Grey      gui=NONE       guibg=Grey
hi PmenuSel       term=NONE            ctermfg=Black        ctermbg=DarkGrey  gui=NONE       guibg=DarkGrey
hi PmenuThumb     term=reverse         cterm=reverse                          gui=reverse

" Spelling
hi SpellBad       term=standout        ctermfg=Black        ctermbg=Red       gui=undercurl  guifg=Red            guisp=Red 
hi SpellCap       term=underline       ctermfg=Black        ctermbg=Blue      gui=undercurl                       guisp=Blue 
hi SpellLocal     term=underline       ctermfg=Black        ctermbg=Magenta   gui=undercurl                       guisp=Magenta
hi SpellRare      term=underline       ctermfg=Black        ctermbg=Cyan      gui=undercurl                       guisp=Cyan

" Diff Operations
hi DiffAdd        term=bold            ctermfg=Black        ctermbg=DarkBlue                                      guibg=DarkBlue
hi DiffChange     term=bold            ctermfg=Black        ctermbg=DarkMagenta                                      guibg=DarkMagenta
hi DiffDelete     term=bold            ctermfg=Blue         ctermbg=DarkCyan  gui=bold       guifg=Blue           guibg=DarkCyan
hi DiffText       term=reverse         cterm=bold                             gui=bold       guibg=Red

" Directory Listings
hi Directory      term=bold            ctermfg=Cyan         ctermbg=Black  gui=NONE       guifg=cyan           guibg=#001000

" Syntax Colouring Groups
hi NonText        term=NONE            ctermfg=Cyan         ctermbg=Black  gui=NONE       guifg=#e0f0e0        guibg=#001000
hi Normal         term=NONE            ctermfg=Gray         ctermbg=Black  gui=NONE       guifg=wheat          guibg=#001000
hi Comment        term=bold            ctermfg=DarkGreen    ctermbg=Black  gui=NONE       guifg=DarkSeaGreen   guibg=#001000
hi Constant       term=underline,bold  ctermfg=Brown        ctermbg=Black  gui=NONE       guifg=pink           guibg=#001000
hi Special        term=bold            ctermfg=Red          ctermbg=Black  gui=NONE       guifg=orange         guibg=#001000
hi Identifier     term=underline       ctermfg=DarkCyan     ctermbg=Black  gui=NONE       guifg=SlateGray3     guibg=#001000
hi Statement      term=bold            ctermfg=DarkCyan     ctermbg=Black  gui=NONE       guifg=yellow         guibg=#001000
hi PreProc        term=underline       ctermfg=DarkCyan     ctermbg=Black  gui=NONE       guifg=RosyBrown      guibg=#001000
hi Type           term=underline       ctermfg=DarkGray     ctermbg=Black  gui=NONE       guifg=orange         guibg=#001000
hi Error          term=reverse         ctermfg=Red          ctermbg=Black  gui=NONE       guifg=White          guibg=Red
hi Todo           term=standout        ctermfg=Yellow       ctermbg=Black  gui=NONE       guifg=Blue           guibg=Yellow

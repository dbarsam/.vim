" Vim color file
" Maintainer:  David Barsam
" Date:        $Date: 2002/04/11 03:29:51 $ 
" Version:     $Revision: 1.0 $

set background=dark	
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="rusty"

" Vim Editor Groups
hi Cursor         term=NONE            gui=NONE       guifg=#001000        guibg=wheat       
hi CursorColumn   term=reverse         gui=NONE                            guibg=Grey40
hi CursorLine     term=underline       gui=NONE                            guibg=Grey40
hi ErrorMsg       term=standout        gui=NONE       guifg=White          guibg=Red         
hi Folded         term=standout        gui=NONE       guifg=Cyan           guibg=DarkGrey
hi FoldColumn     term=standout        gui=NONE       guifg=Cyan           guibg=DarkGrey
hi SignColumn     term=standout        gui=NONE       guifg=Cyan           guibg=DarkGrey
hi IncSearch      term=reverse         gui=NONE       guifg=Black          guibg=Yellow         
hi LineNr         term=underline       gui=NONE       guifg=DarkGoldenrod  guibg=#001000        
hi MatchParen     term=reverse         gui=NONE                            guibg=DarkCyan
hi ModeMsg        term=bold            gui=bold
hi MoreMsg        term=bold            gui=NONE       guifg=SkyBlue        guibg=#001000        
hi Question       term=standout        gui=bold       guifg=SeaGreen       guibg=#001000        
hi Search         term=reverse         gui=bold       guifg=blue           guibg=Yellow         
hi SpecialKey     term=bold            gui=NONE       guifg=cyan           guibg=#001000        
hi TabLine        term=underline       gui=underline                       guibg=DarkGrey
hi TabLineFill    term=reverse         gui=reverse
hi TabLineSel     term=bold            gui=bold
hi Title          term=bold            gui=bold       guifg=Magenta        guibg=#001000        
hi Underlined     term=underline       gui=underline  guifg=#80a0ff
hi Visual         term=reverse         gui=NONE       guifg=wheat          guibg=#4F4F4F         
hi VisualNOS      term=underline       gui=NONE       guifg=wheat          guibg=#001000        
hi WarningMsg     term=standout        gui=NONE       guifg=black          guibg=Yellow         
hi WildMenu       term=standout        gui=NONE       guifg=Black          guibg=Yellow
hi StatusLine     term=bold,reverse    gui=bold       guifg=#204020        guibg=#709070       
hi StatusLineNC   term=reverse         gui=NONE       guifg=#90B090        guibg=#204020         
hi VertSplit      term=reverse         gui=NONE       guifg=#90B090        guibg=#204020         

" Internal Pop-up Menu
hi Pmenu          term=NONE            gui=NONE       guibg=Magenta
hi PmenuSbar      term=NONE            gui=NONE       guibg=Grey
hi PmenuSel       term=NONE            gui=NONE       guibg=DarkGrey
hi PmenuThumb     term=reverse         gui=reverse

" Spelling
hi SpellBad       term=standout        gui=undercurl  guifg=Red            guisp=Red 
hi SpellCap       term=underline       gui=undercurl  guifg=Red            guisp=Blue 
hi SpellLocal     term=underline       gui=undercurl  guifg=Red            guisp=Magenta
hi SpellRare      term=underline       gui=undercurl  guifg=Red            guisp=Cyan

" Diff Operations
hi DiffAdd        term=bold                                                guibg=#334333
hi DiffChange     term=bold                                                guibg=#334333
hi DiffDelete     term=bold            gui=italic     guifg=#444444        guibg=#333333
hi DiffText       term=reverse         gui=bold       guifg=White          guibg=DarkRed

" Directory Listings
hi Directory      term=bold            gui=NONE       guifg=cyan           guibg=#001000

" Syntax Colouring Groups
hi NonText        term=NONE            gui=NONE       guifg=#e0f0e0        guibg=#001000
hi Normal         term=NONE            gui=NONE       guifg=wheat          guibg=#001000
hi Comment        term=bold            gui=NONE       guifg=DarkSeaGreen   guibg=#001000
hi Constant       term=underline,bold  gui=NONE       guifg=pink           guibg=#001000
hi Special        term=bold            gui=NONE       guifg=orange         guibg=#001000
hi Identifier     term=underline       gui=NONE       guifg=SlateGray3     guibg=#001000
hi Statement      term=bold            gui=NONE       guifg=yellow         guibg=#001000
hi PreProc        term=underline       gui=NONE       guifg=RosyBrown      guibg=#001000
hi Type           term=underline       gui=NONE       guifg=orange         guibg=#001000
hi Error          term=reverse         gui=NONE       guifg=White          guibg=Red
hi Todo           term=standout        gui=NONE       guifg=Blue           guibg=Yellow

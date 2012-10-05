" Vim color file
" Maintainer:  David Barsam
" Date:        $Date: 2002/04/11 03:29:51 $ 
" Version:     $Revision: 1.0 $

set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="dirty"

" Vim Editor Groups
hi Cursor         term=NONE            gui=NONE       guifg=#fdfdfd        guibg=#001000       
hi CursorColumn   term=reverse         gui=NONE                            guibg=Grey40
hi CursorLine     term=underline       gui=NONE                            guibg=Grey40
hi ErrorMsg       term=standout        gui=NONE       guifg=White          guibg=Red         
hi VertSplit      term=reverse         gui=NONE       guibg=#90B090        guifg=#204020         
hi Folded         term=standout        gui=NONE       guifg=Cyan           guibg=DarkGrey
hi FoldColumn     term=standout        gui=NONE       guifg=Cyan           guibg=Grey
hi SignColumn     term=standout        gui=NONE       guifg=Cyan           guibg=Grey
hi IncSearch      term=reverse         gui=NONE       guifg=black          guibg=Yellow         
hi LineNr         term=underline       gui=NONE       guifg=DarkGoldenrod  guibg=#fdfdfd        
hi MatchParen     term=reverse         gui=NONE                            guibg=DarkCyan
hi ModeMsg        term=bold            gui=bold
hi MoreMsg        term=bold            gui=NONE       guifg=SkyBlue        guibg=#fdfdfd        
hi Question       term=standout        gui=bold       guifg=SeaGreen       guibg=#fdfdfd        
hi Search         term=reverse         gui=bold       guifg=blue           guibg=Yellow         
hi SpecialKey     term=bold            gui=NONE       guifg=Cyan3          guibg=#fdfdfd        
hi StatusLine     term=bold,reverse    gui=bold       guibg=#204020        guifg=#f0fff0       
hi StatusLineNC   term=reverse         gui=NONE       guibg=#90B090        guifg=#204020         
hi TabLine        term=underline       gui=underline                       guibg=DarkGrey
hi TabLineFill    term=reverse         gui=reverse
hi TabLineSel     term=bold            gui=bold
hi Title          term=bold            gui=bold       guifg=Magenta        guibg=#fdfdfd        
hi Underlined     term=underline       gui=underline  guifg=#80a0ff
hi Visual         term=reverse         gui=NONE       guifg=wheat          guibg=#4F4F4F         
hi VisualNOS      term=underline       gui=NONE       guifg=#001000        guibg=#fdfdfd        
hi WarningMsg     term=standout        gui=NONE       guifg=black          guibg=Yellow         
hi WildMenu       term=standout        gui=NONE       guifg=black          guibg=Yellow

" Internal Pop-up Menu
hi Pmenu          term=NONE            gui=NONE       guibg=Magenta
hi PmenuSbar      term=NONE            gui=NONE       guibg=Grey
hi PmenuSel       term=NONE            gui=NONE       guibg=DarkGrey
hi PmenuThumb     term=reverse         gui=reverse

" Spelling
hi SpellBad       term=standout        gui=undercurl  guifg=Red            guisp=Red 
hi SpellCap       term=underline       gui=undercurl                       guisp=Blue 
hi SpellLocal     term=underline       gui=undercurl                       guisp=Magenta
hi SpellRare      term=underline       gui=undercurl                       guisp=Cyan

" Diff Operations
hi DiffAdd        term=bold                                                guibg=DarkBlue
hi DiffChange     term=bold                                                guibg=DarkMagenta
hi DiffDelete     term=bold            gui=bold       guifg=Blue           guibg=DarkCyan
hi DiffText       term=reverse         gui=bold       guibg=Red

" Directory Listings
hi Directory      term=bold            gui=NONE       guifg=DarkCyan       guibg=#fdfdfd

" Syntax Colouring Groups
hi NonText        term=NONE            gui=NONE       guifg=Cyan3          guibg=#fdfdfd
hi Normal         term=NONE            gui=NONE       guifg=#001000        guibg=#fdfdfd
hi Comment        term=bold            gui=NONE       guifg=DarkSeaGreen4  guibg=#fdfdfd
hi Constant       term=underline,bold  gui=NONE       guifg=Maroon         guibg=#fdfdfd
hi Special        term=bold            gui=NONE       guifg=DarkOrange2    guibg=#fdfdfd
hi Identifier     term=underline       gui=NONE       guifg=DarkBlue       guibg=#fdfdfd
hi Statement      term=bold            gui=NONE       guifg=SteelBlue      guibg=#fdfdfd
hi PreProc        term=underline       gui=NONE       guifg=RosyBrown4     guibg=#fdfdfd
hi Type           term=underline       gui=NONE       guifg=DarkOrange3    guibg=#fdfdfd
hi Error          term=reverse         gui=NONE       guifg=White          guibg=Red
hi Todo           term=standout        gui=NONE       guifg=Blue           guibg=Yellow

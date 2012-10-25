" ===================================================================
"                  Text Manipulation Commands for VIM
" ===================================================================
" File:           settings/text.vim
" Purpose:        Text commands the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_text_plugin')
    finish 
endif 
let g:loaded_settings_text_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
" Whitespace & Duplication
com! -bar -nargs=0 RemoveEmptyLines                 v/\S/d               " Remove all Empty Lines (Whitespace included)
com! -bar -nargs=0 RemoveTrailingWhitespace         %s/\s\+$//e          " Remove trailing whitepspace at the end of a line
com! -bar -nargs=0 RemoveWhitespaceInEmptyLines     %s/^\s\+$//e         " Remove whitepspace in empty lines (i.e. compresses line -- does not delete line)
com! -bar -nargs=0 MergeEmptyLines                  g/^\s*$/,/\S/-j      " Replace Blocks of Empty Lines with a Single Empty Lines

com! -bar -nargs=0 RemoveDuplicateLines             g/\%(^\1$\n\)\@<=\(.*\)$/d   " Remove Duplicate Lines - Leave First Occurrence
com! -bar -nargs=0 RemoveDuplicateLinesReverse      g/^\(.*\)$\n\1$/d            " Remove Duplicate Lines - Leave Last Occurrence

" Sorting
com! -bar -range -nargs=0 Sort              sort
com! -bar -range -nargs=0 SortReverse       sort!
com! -bar -range -nargs=0 SortNumeric       sort n
com! -bar -range -nargs=0 SortUniq          sort u

" Select All
com! -nargs=0 SelectAll                     call settings#text#TextSelectAll()

" Visual Searching
com! -range -nargs=1 VisualSearch           call settings#text#TextVisualSearch(<f-args>)

" Register Manipulation
com! -register -nargs=+ RegisterRedirect    call settings#text#RedirectOutputToRegister("<reg>", "<args>")

" Formatting
com! -bar -nargs=0 FormatCommas             g/^> /s/,\([^ ]\)/, \1/g   " Format all commas with a following space
com! -bar -nargs=0 FormatSpaces             %s/  \+/ /g                " Format all lines of 3 or more spaces into a single space
com! -bar -nargs=0 FormatDOSReturns         %s/\r/\r/g                 " 'Fix' Dos Carriage returns
com! -bar -nargs=0 FormatDoubleSpace        g/^/put_                   " Double Space the buffer
com! -bar -nargs=0 FormatReverse            g/^/m0                     " Reverse The Buffer
com! -bar -nargs=0 FormatReverseSelection   'a,'bg/^/m'b               " Reverse The Selection
com! -bar -nargs=0 FormatParagraph          gql                        " Breaks a line of text into a paragraph of the current textwidth
com! -bar -nargs=0 FormatBuffer             normal gg=G                " Format Buffer using equalprg
com! -bar -nargs=0 FormatFile               normal ggVG=               " Format File using equalprg

" Formats the Line with title case, i.e. initial capitals
com! -bar -nargs=0 FormatTitle              s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g
com! -bar -range -nargs=0 FormatTitleRange  s/\%V\(\w\)\(\w*\)\%V/\u\1\L\2/g

" Underlining
com! -bar -nargs=1 DrawLineUnder            normal yypv$r<args>k       " Places a line of characters below the line
com! -bar -nargs=1 DrawLineOver             normal yyPv$r<args>j       " Places a line of characters above the line
com! -bar -nargs=1 DrawLineDouble           normal yypv$r<args>yykPj   " Places a line of characters above *and* below the line

" Moving Lines Of Text
" Based On: http://vim.wikia.com/wiki/Moving_lines_up_or_down_in_a_file
com! -bar -nargs=? MoveLineDown             move .+<args>
com! -bar -nargs=? MoveLineUp               move .-1-<args>
com! -bar -range -nargs=? MoveRangeDown     '<,'>move '>+<args>
com! -bar -range -nargs=? MoveRangeUp       '<,'>move '<-1-<args>

" Statistics
com! -bar -range -nargs=0 WordCount         normal g<C-G>               " Word Count
com! -bar -nargs=1 WordInstanceCount        %s/<args>//gn               " Word Instance Counting

" ============
" Plugin Mappings
" ============
" See http://vim.wikia.com/wiki/Accessing_the_system_clipboard
vnoremap <Plug>TextCut              "+x
vnoremap <Plug>TextCopy             "+y
cnoremap <Plug>TextCopy             <C-Y>
nnoremap <Plug>TextPaste            "+gP
cnoremap <Plug>TextPaste            <C-R>+
vnoremap <Plug>TextPaste            paste#paste_cmd['v']
inoremap <Plug>TextPaste            paste#paste_cmd['i']

nnoremap <Plug>TextPutBefore        [p
inoremap <Plug>TextPutBefore        <C-O>[p
nnoremap <Plug>TextPutAfter         ]p
inoremap <Plug>TextPutAfter         <C-O>[p

nnoremap <Plug>TextDelete           x
vnoremap <Plug>TextDelete           x
nnoremap <Plug>TextErase            d
vnoremap <Plug>TextErase            d

" Sorting
noremap <Plug>Sort                  :Sort<CR>
noremap <Plug>SortReverse           :SortReverse<CR>
noremap <Plug>SortNumeric           :SortNumeric<CR>
noremap <Plug>SortUniq              :SortUniq<CR>

" Text Selection
nnoremap <Plug>TextSelectAll        :SelectAll<CR>
onoremap <Plug>TextSelectAll        :SelectAll<CR>
vnoremap <Plug>TextSelectAll        <C-C>:SelectAll<CR>
inoremap <Plug>TextSelectAll        <C-O>:SelectAll<CR>
cnoremap <Plug>TextSelectAll        <C-C>:SelectAll<CR>

nnoremap <Plug>TextSelectWord       vaw
onoremap <Plug>TextSelectWord       aw
vnoremap <Plug>TextSelectWord       <C-C>vaw
inoremap <Plug>TextSelectWord       <C-O>vaw
cnoremap <Plug>TextSelectWord       <C-C>vaw

nnoremap <Plug>TextSelectSentence   vas
onoremap <Plug>TextSelectSentence   as
vnoremap <Plug>TextSelectSentence   <C-C>vas
inoremap <Plug>TextSelectSentence   <C-O>vas
cnoremap <Plug>TextSelectSentence   <C-C>vas

nnoremap <Plug>TextSelectParagraph  vap
onoremap <Plug>TextSelectParagraph  ap
vnoremap <Plug>TextSelectParagraph  <C-C>vap
inoremap <Plug>TextSelectParagraph  <C-O>vap
cnoremap <Plug>TextSelectParagraph  <C-C>vap

nnoremap <Plug>TextSelectLine       V
onoremap <Plug>TextSelectLine       <C-C>V
vnoremap <Plug>TextSelectLine       <C-C>V
inoremap <Plug>TextSelectLine       <C-O>V
cnoremap <Plug>TextSelectLine       <C-C>V

nnoremap <Plug>TextSelectBlock      <C-V>
onoremap <Plug>TextSelectBlock      <C-C><C-V>
vnoremap <Plug>TextSelectBlock      <C-C><C-V>
inoremap <Plug>TextSelectBlock      <C-O><C-V>
cnoremap <Plug>TextSelectBlock      <C-C><C-V>

vnoremap <Plug>TextConvertToBlockwiseSelection <C-V>

" Text Manipulation
nnoremap <Plug>TextMoveDown         mz:m+<CR>`z
nnoremap <Plug>TextMoveUp           mz:m-2<CR>`z
nnoremap <Plug>TextMoveRight        >>
nnoremap <Plug>TextMoveLeft         <<
inoremap <Plug>TextMoveDown         <Esc>:m+<CR>gi
inoremap <Plug>TextMoveUp           <Esc>:m-2<CR>gi
inoremap <Plug>TextMoveRight        <Esc>>>gi
inoremap <Plug>TextMoveLeft         <Esc><<gi
vnoremap <Plug>TextMoveDown         :m'>+<CR>gv`<my`>mzgv`yo`z
vnoremap <Plug>TextMoveUp           :m'<-2<CR>gv`>my`<mzgv`yo`z
vnoremap <Plug>TextMoveRight        >gv`<my`>mzgv`yo`z
vnoremap <Plug>TextMoveLeft         <gv`>my`<mzgv`yo`z

" Text Searching
vnoremap <Plug>VisualSearchForward  :VisualSearch '*'<CR>
vnoremap <Plug>VisualSearchReverse  :VisualSearch '#'<CR>
vnoremap <Plug>VisualSearchGrep     :VisualSearch 'gv'<CR>

if has("gui")
    noremap  <Plug>TextFind         :promptfind<CR>
    vnoremap <Plug>TextFind         y:promptfind <C-R>=substitute(@", "[\r\n]", '\\n', 'g')<CR><CR>
    noremap  <Plug>TextFindReplace  :promptrepl<CR>
    vnoremap <Plug>TextFindReplace  y:promptrepl <C-R>=substitute(@", "[\r\n]", '\\n', 'g')<CR><CR>
else
    noremap  <Plug>TextFind         /
    noremap  <Plug>TextFindReplace  :%s/
    vnoremap <Plug>TextFindReplace  :s/
endif

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

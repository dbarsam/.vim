" ===================================================================
"               Microsoft Office Autload Functions VIM
" ===================================================================
" File:           autoload/settings/msoffice.vim
" Purpose:        Microsoft Office commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" Store the lines in the 'O' register
" ============
function! settings#msoffice#MSOutlookRowFilterBuild() range
    let @o=''
    execute a:firstline . "," . a:lastline . "g!/^\s*$/y O"
endfunction

" ============
" Execute the filter with the contents of the 'O' register
" ============
function! settings#msoffice#MSOutlookRowFilterApply() range
    execute a:firstline . "," . a:lastline . "call settings#msoffice#MSOutlookRowFilter(" . string(map(split(strtrans(@o), '\^@'), '"^[^A-Z]\\+\\c" . v:val')) . ")"
endfunction

" ============
" Generic Row Filter
" ============
function! settings#msoffice#MSOutlookRowFilter(list) range
    if (len(a:list) == 0)
        echo "MSOutlookRowFilter:  No parameters to filter"
    else
        execute a:firstline . "," . a:lastline . "g!/" . join(a:list, '\|') . "/d"
    endif
endfunction
" ============
" Transpose a Name from <First Last> to <Last, First>
" ============
function! settings#msoffice#MSOutlookTransposeName(name) abort
    let names = split(a:name, " ")
    if (len(l:names) <= 1)
        echo "MSOutlookMeetingTrackingFilter:  Malformed name [" . a:name . "]"
        return ""
    endif
    return join(names[1:], " ").", ".names[0]
endfunction

" ============
" Outlook Meeting: Remove the unmatched 'Tracking' Results from an Outlook Meeting Tracking Results
" ============
function! settings#msoffice#MSOutlookMeetingTrackingFilter(...) range
    if (a:0 == 0)
        echo "MSOutlookMeetingTrackingFilter:  No parameters to filter"
    else
        execute a:firstline . "," . a:lastline . "g!/" . join(map(copy(a:000), '"\\c" . v:val . "$"'), '\|') . "/d"
    endif
endfunction

" ============
" Outlook Meeting: Strip the Tracking Information from 'Tracking' Results from an Outlook Meeting Tracking Results
" ============
function! settings#msoffice#MSOutlookMeetingTrackingExtractNames() range
    execute a:firstline . "," . a:lastline . "s/\t.*//g"
endfunction

" ============
" Outlook Meeting: Tranpose Names from 'Tracking' Results from an Outlook Meeting Tracking Results
" ============
function! settings#msoffice#MSOutlookMeetingTrackingTransposeNames() range
    execute a:firstline . "," . a:lastline . "s/\\([^\t]\\+\\)/\\=settings#msoffice#MSOutlookTransposeName(submatch(1))"
endfunction

" ============
" Outlook Meeting: Outlook Tracking Keyword Complete Function
" ============
function! settings#msoffice#MSOutlookMeetingTrackingKeywords(ArgLead,CmdLine,CusrorPos) abort
    return filter(["Accepted", "Tentative", "Declined", "None"], 'match(v:val, "^'.a:ArgLead.'") != -1')
endfunction

" ============
" Outlook Mailing List: Strip the Mailing List Information from an expanded Mailing List
" ============
function! settings#msoffice#MSOutlookMailingListExtractNames() range
    execute a:firstline . "," . a:lastline . "s/ <[^>]\\+>//g"
    execute a:firstline . "," . a:lastline . "s/; /\r/g"
endfunction

" ===================================================================
" End
" ===================================================================

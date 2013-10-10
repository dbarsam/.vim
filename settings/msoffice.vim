" ===================================================================
"            Microsoft Office Scripts and Functions for VIM
" ===================================================================
" File:           settings/msoffice.vim
" Purpose:        Microsoft Office commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_msoffice_plugin')
   finish
endif
let g:loaded_settings_msoffice_plugin = 1 

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Plugin Commands
" ============
command! -bar -range=% -nargs=+ -complete=customlist,settings#msoffice#MSOutlookMeetingTrackingKeywords MSOutlookMeetingTrackingFilter  <line1>,<line2>call settings#msoffice#MSOutlookMeetingTrackingFilter(<f-args>)
command! -bar -range=% -nargs=0 MSOutlookMeetingTrackingExtractNames                                                                    <line1>,<line2>call settings#msoffice#MSOutlookMeetingTrackingExtractNames()
command! -bar -range=% -nargs=0 MSOutlookMeetingTrackingTransposeNames                                                                  <line1>,<line2>call settings#msoffice#MSOutlookMeetingTrackingTransposeNames()
command!               -nargs=0 MSOutlookMeetingTrackingCleanUp                                                                         MSOutlookMeetingTrackingFilter Accepted Tentative<BAR>MSOutlookMeetingTrackingExtractNames<BAR>MSOutlookMeetingTrackingTransposeNames

command! -bar -range=% -nargs=0 MSOutlookMailingListExtractNames                                                                        <line1>,<line2>call settings#msoffice#MSOutlookMailingListExtractNames()
command!               -nargs=0 MSOutlookMailingListCleanUp                                                                             MSOutlookMailingListExtractNames<BAR>MSOutlookMeetingTrackingTransposeNames

command! -bar -range=% -nargs=0 MSOutlookRowFilterBuild                                                                                 <line1>,<line2>call settings#msoffice#MSOutlookRowFilterBuild()
command! -bar -range=% -nargs=0 MSOutlookRowFilterApply                                                                                 <line1>,<line2>call settings#msoffice#MSOutlookRowFilterApply()

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

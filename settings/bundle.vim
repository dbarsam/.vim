" ===================================================================
"                     Bundle Commands for VIM
" ===================================================================
" File:           settings/bundle.vim
" Purpose:        Bundle commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================
if exists('g:loaded_settings_bundle_plugin')
   finish 
endif 
let g:loaded_settings_bundle_plugin = 1 

" ============
" Plugin Requirements
" ============
" Plugin is only valid if git is in the path
if !executable("git")
    echoerr expand('%')." requires git in the path."
    finish
endif

if !executable("curl")
    echohl WarningMsg | echo expand('%')." requires curl in the path for some functionality." | echohl None
endif

" ============
" Disable Compatibility Options
" ============
let s:save_cpo = &cpo
set cpo&vim

" ============
" Global Variables
" ============
" The Bundle Directory
let $VIMBUNDLE=expand('$VIMFILES/bundle')

" The Bundle List
let s:BundleList = {}

" The Auxilliary Bundle List file
let s:BundleFile = expand('$VIMBUNDLE/bundle.vim')

" ============
" Bundle Functions
" ============

" Bundle Register 
function! s:BundleRegister(name, path)
    let s:BundleList[a:name] = a:path
endfunction

" Bundle Init - Setting up Vundle automatically
" From https://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
function! s:BundleManagerInit()

    let g:vundle_default_git_proto = "ssh"

    BundleRegister Vundle 'https://github.com/gmarik/vundle'
    if filereadable(s:BundleFile)
        exe "source " . s:BundleFile
    endif

    " preserve the output of filetype
    redir => output
    silent filetype
    redir END
    let ftstate = matchlist(l:output, 'detection:\(\S\+\)\s\+plugin:\(\S\+\)\s\+indent:\(\S\+\)')
    filetype off

    " check if bundle directory exixts
    if !isdirectory($VIMBUNDLE)
        echomsg "Making Bundle Directory:  '".$VIMBUNDLE."'"
        call mkdir($VIMBUNDLE)
    endif

    " check if Vundle exixts
    let installed = filereadable( expand('$VIMBUNDLE/vundle/README.md') )
    if !installed
        echomsg "Installing Vundle for the first time..."
        execute "silent !git clone https://github.com/gmarik/vundle ".shellescape(expand('$VIMBUNDLE/vundle'))
        if v:shell_error
            echoerr "Could not install Vundle via HTTPS, trying GIT..."
            execute "silent !git clone git://github.com/gmarik/vundle.git ".shellescape(expand('$VIMBUNDLE/vundle'))
        endif
        if v:shell_error
            echoerr "Could not install Vundle via HTTPS, trying SSH..."
            execute "silent !git clone git@github.com:/gmarik/vundle ".shellescape(expand('$VIMBUNDLE/vundle'))
        endif
        " re-check if Vundle exixts
        let installed = filereadable( expand('$VIMBUNDLE/vundle/README.md') )
    endif

    " init Vundle
    if installed
        set rtp+=$VIMBUNDLE/vundle/
        call vundle#rc($VIMBUNDLE)

        " process the other bundles and load their settings
        for [name, bundle] in items(s:BundleList)
            exe 'runtime! settings/plugin-settings/*'.name.'*'
            Bundle bundle
        endfor 
        
        " cleanup *.git files
        for file in split(globpath($VIMBUNDLE, "**/.git"), '\n')
            " echomsg file
        endfor
    else
        echoerr "Could not install Vundle!  Bundles are offline!"
    endif

    " restore the filetype
    if (l:ftstate[1] == "ON") | filetype on | endif
    if (l:ftstate[2] == "ON") | filetype plugin on | endif
    if (l:ftstate[3] == "ON") | filetype indent on | endif
endfunction

" Bundle Install - Kick off the install process for bundles
function! s:BundleManagerInstall()

    BundleInstall

    " cleanup *.git files
    for file in split(globpath($VIMBUNDLE, "**/.git"), '\n')
        " echomsg file
    endfor    
endfunction

" ============
" Bundle Commands
" ============
com! -bar -nargs=0 BundleEdit            confirm edit $VIMBUNDLE/bundle.vim
com! -bar -nargs=+ BundleRegister        call <SID>BundleRegister(<f-args>)
com! -bar -nargs=0 BundleManagerInit     call <SID>BundleManagerInit()
com! -bar -nargs=0 BundleManagerInstall  call <SID>BundleManagerInstall()
com! -bar -nargs=0 BundleManagerUpdate   call <SID>BundleManagerInit() | call <SID>BundleManagerInstall()

" ============
" Plugin Mapping
" ============
" Quick Edit and Reload Commands
nnoremap <Plug>BundleEdit               :BundleEdit<CR>

" ============
" Restore Compatibility Options
" ============
let &cpo = s:save_cpo

" ===================================================================
" End
" ===================================================================

" ===================================================================
"                 System Autoload Functions for VIM
" ===================================================================
" File:           autoload/settings/system.vim
" Purpose:        System commands for the editor Vim (Vi IMproved)
" Author:         David Barsam
" URL:            https://github.com/dbarsam/.vim
" ===================================================================

" ============
" 'Close' Buffer
" ============
fun! settings#system#CloseBuffer()
    if winheight(2) < 0
       confirm enew
    else
       confirm close
    endif
endfunction

" ============
" 'Save' Buffer
" ============
fun! settings#system#SaveBuffer()
    if expand("%") == "" 
        browse confirm w
    else 
        confirm w 
    endif
endfunction

" ============
" Save Copy of the Current Buffer to the Desktop
" ============
function! settings#system#SaveCopyToDesktop() abort
    if has("win32") && exists("$DESKTOP")
        let l:desktop=escape(substitute(expand($DESKTOP),'\','/','ge'),"|[]*'\" #")
        if expand("%") == ""
            let l:bdir = &browsedir
            execute "set browsedir=".l:desktop
            browse confirm w
            execute "set browsedir=".l:bdir
        else
            let l:name=l:desktop."/".expand("%:t")
            execute "confirm w ".l:name
        endif
    endif
endf

" ============
" Save a Time-Stamped Backup Copy of the Current Buffer to the Backup folder
" Based On: http://vim.wikia.com/wiki/VimTip694
" ============
function! settings#system#SaveCopyAsBackup() abort
    if has("win32") && exists("&backupdir")
        let l:backupdir=escape(substitute(expand(&backupdir),'\','/','ge'),"|[]*'\" #")
        if expand("%") == ""
            let l:bdir = &browsedir
            execute "set browsedir=".l:backupdir
            browse confirm w
            execute "set browsedir=".l:bdir
        else
            let l:name = l:backupdir . "/" . expand("%:r") . strftime(".%Y%m%d-%H%M%S.") . expand("%:e") . &backupext
            silent execute "confirm w ".l:name
            echomsg "Saved Backup Copy to: ".l:name
        endif
    endif
endf

" ============
" Toggle Auto "SaveCopyAsBackup"
" Based On: http://vim.wikia.com/wiki/VimTip892
" Based On: http://vim.wikia.com/wiki/Write_a_date-stamped_backup_of_the_current_file
" ============
function! settings#system#ToggleAutoCopyBackup() abort
    if exists("#AutoBackupGroup")
        autocmd! AutoBackupGroup BufWritePost,FileWritePost
        augroup! AutoBackupGroup
        echomsg "Copy Backup: Disabled"
    else
        augroup AutoBackupGroup
        autocmd AutoBackupGroup BufWritePost,FileWritePost * silent call settings#system#SaveCopyAsBackup()
        augroup END
        echomsg "Copy Backup: Enabled"
    endif
endf


" ============
" Open the selected text as a URL address
" Based On: http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
" ============
function! settings#system#LaunchURL() range
    if has("win32")
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:url = matchstr(@", '\(www\|\(http\|ftp\|file\)://\)[[:graph:]]\+')

        if l:url != o"
            if executable("firefox.exe")
                silent execute "!start firefox.exe ". l:url
            elseif executable("iexplorer.exe")
                silent execute "!start iexplorer.exe ". l:url
            else
                silent execute "!start cmd.exe /c start ". l:url
            endif
            echomsg "Launched \"" . l:url . "\""
        else
            echomsg "No URL found in line."
        endif

        let @" = l:saved_reg
    endif
endfunction

" ============
" Open Windows Explorer
" ============
function! settings#system#ShowInExplorer(...) abort
    if has("win32")
        if a:0 == 0
            if expand("%") == ""
                let l:winfolder=substitute(getcwd(), '/', '\', 'g')
                silent execute "!start explorer /e,".l:winfolder
            else
                let l:winfile=substitute(expand("%:p"), '/', '\', 'g')
                silent execute "!start explorer /e,/select,".l:winfile
            endif
        else
            for path in a:000
                if isdirectory(l:path)
                    let l:winfolder=substitute(l:path, '/', '\', 'g')
                    silent execute "!start explorer /e,".l:winfolder
                elseif filereadable(l:path)
                    let l:winfile=substitute(l:path, '/', '\', 'g')
                    silent execute "!start explorer /e,/select,".l:winfile
                endif
            endfor            
        endif
    endif
endf

" ============
" Open Windows Command Prompt
" ============
function! settings#system#ShowInCommandPrompt(...) abort
    if has("win32")
        if a:0 == 0
            let l:winfolder=substitute(expand("%") == "" ? getcwd() : expand("%:p:h") , '/', '\', 'g')
            silent execute "!start cmd /k pushd ".l:winfolder
        else
            for path in a:000
                if isdirectory(l:path) || filereadable(l:path)
                    let l:winfolder=substitute(fnamemodify(l:path, ":p:h"), '/', '\', 'g')
                    silent execute "!start cmd /k pushd ".l:winfolder
                endif
            endfor
        endif
    endif
endf

" ============
" Open PowerShell Command Prompt 
" ============
function! settings#system#ShowInPowerShell(...) abort
    if has("win32") && executable("powershell.exe")
        if a:0 == 0
            let l:winfolder=substitute(expand("%") == "" ? getcwd() : expand("%:p:h") , '/', '\', 'g')
            silent execute "!start powershell -NoExit Set-Location ".l:winfolder
        else
            for path in a:000
                if isdirectory(l:path) || filereadable(l:path)
                    let l:winfolder=substitute(fnamemodify(l:path, ":p:h"), '/', '\', 'g')
                    silent execute "!start powershell -NoExit Set-Location ".l:winfolder
                endif
            endfor
        endif
    endif
endf

" ============
" Open the selected text as a file
" ============
function! settings#system#OpenFileFromSelectedText() range
    normal! gf
endfunction

" ============
" Open File Path from Clipboard
" ============
function! settings#system#OpenFilePathFromClipboard() abort
    if glob(@*) != ""
        execute "edit " . @*
    endif
endf

" ============
" Copy File Path to Clipoard
" ============
function! settings#system#CopyFilePathToClipboard(name) abort
    if (has("win32"))
        if (expand("%") == "")
            let @*=substitute(getcwd(), '/', '\', 'g')
        else
            if (a:name == "head")
                let @*=substitute(expand("%:h"), '/', '\', 'g')
            elseif (a:name == "root")
                let @*=substitute(expand("%:r"), '/', '\', 'g')
            elseif (a:name == "tail")
                let @*=substitute(expand("%:t"), '/', '\', 'g')
            elseif (a:name == "ext")
                let @*=substitute(expand("%:e"), '/', '\', 'g')
            elseif (a:name == "full")
                let @*=substitute(expand("%:p"), '/', '\', 'g')
            elseif (a:name == "path")
                let @*=substitute(expand("%:p:h"), '/', '\', 'g')
            elseif (a:name == "unc")
                let @*=settings#system#ConvertToUNC(expand("%:p"))
            endif
        endif
        echo "Copied Path to Clipboard: ".@*
    endif
endf

" ============
" Replace the carriage return and new line character with a standard escape
" Based on system menu.vim
" ============"
fun! settings#system#ConvertNewLine(text)
    return substitute(a:text, "[\r\n]", '\\n', 'g')
endfunction

" ============
" Convert a File Path to according to FNameEscape rules
" Based on system menu.vim
" ============"
function! settings#system#ConvertFileName(text)
    if exists('*fnameescape')
        return fnameescape(a:text)
    return escape(a:text, " \t\n*?[{`$\\%#'\"|!<")
endfunction

" ============
" Convert a File Path to UNC format
" Based on http://www.vim.org/scripts/script.php?script_id=434
" ============
function! settings#system#ConvertToUNC( filename )
    if (has("win32"))
        let shares=system('net share')
        let shares=substitute(shares,"\n[^ \n]\\+[$]\\s[^\n]\\+","",'g')
        let newname=''
        let current=fnamemodify(a:filename,':gs+/+\\+')
        let do_it=1
        let ss=((&shellslash)?('/'):('\'))
        while do_it
            let tx=fnamemodify(current, ':h')
            if tx==current
                let do_it=0
            else
                let current=tx
                let mx= '\c'."\n".'\([^ 	'."\n".']\+\)\s\+'.escape(current,'$\.&').'\s\+'
                let match=matchstr(shares,mx)
                if match != ""
                    let sharename=substitute(match,mx,'\1','')
                    let drivepart=strpart(a:filename, strlen(current))
                    if drivepart!~ '^[\\/]'
                        let drivepart=ss.drivepart
                    endif
                    return ss.ss.$COMPUTERNAME.ss.sharename.drivepart
                endif
            endif
        endwhile
    endif
endfunction

" ============
" Function to cycle through list of files and edit them incrementally
" ============
function! settings#system#CycleFiles(files, flag) abort
    if !empty(a:files)
        let indx = -1
        for file in a:files
            if expand(l:file) == expand("%")
                let indx = index(a:files, l:file)
            endif
        endfor        

        if (indx == -1)
            let indx = 0
        else
            if (!&modified)
                bdelete
            endif
            if a:flag == 'n'
                let indx = (l:indx + 1) % len(a:files)
            elseif a:flag == 'p'
                let indx = (l:indx - 1) % len(a:files)
            endif
        endif

        execute "e ".a:files[l:indx]
     endif
endfunction

" ============
" Toggle 'Hex Mode' via xxd
" ============
function! settings#system#ToggleHexMode(...)
    if exists(":XXD")
        let mod = &mod
        if (a:0 == 0)
            let l:enable = &ft != 'xxd'
        else
            let l:enable = a:1
        endif

        if (l:enable)
            echomsg "Filtering through xxd..."
            XXD
            if getline(1) =~ "^0000000:"		" only if it worked
                set ft=xxd
            endif
        elseif &ft == 'xxd'
            echomsg "Filtering through xxd (reverse)..."
            XXD -r
            set ft=
            doautocmd filetypedetect BufReadPost
        endif
        let &mod = l:mod            
    endif
endfunction

" ============
" Make a symbolic link using operating system link command
" ============
function! settings#system#GenerateSymLink(source, link)
    if (has("win32") || has("win64"))
        
        " Get our link exectuable
        if !exists(s:symlinkexe)
            silent execute "!start cmd.exe /C mklink /?"
            if v:shell_error == 0
                let s:symlinkexe = "cmd.exe /C mklink"
            endif
        endif
        if !exists(s:symlink) && exectuble("fsutil.exe")
            let s:symlink = "fsutil.exe hardlink create"
        endif

        if exists(s:symlink)
            if !filereadable(a:source)
                echoerr "Cannot read Symbolic Link source (".a:source.")"
            elseif !filereadable(a:link) || (confirm("Link arleady exists, overwrite it?", "&Yes\n&No\n&Cancel") == 1 && delete(a:link) == 0)
                silent execute "!start ".s:symlinkexe." ".shellescape(a:link)." ".shellescape(a:source)
                if (v:shell_error > 0)
                    echo "Symbolic Link Failed: [".source."] =\= [".a:link."]"
                else
                    echo "Symbolic Link Created: [".source."] => [".a:link."]"
                endif
            endif
        endif
    endif
endfunction

" ============
" OS Version
" ============
function! settings#system#GetOSVersion()
    if (has("win16") || has("win32") || has("win64"))
        " See http://www.robvanderwoude.com/ver.php for list of ver output
        let vstring = matchstr(system('ver'), 'Version \(\.\+\|\d\+\)\+')         
        return matchstr(l:vstring, '\(\.\+\|\d\+\)\+')
    endif
    return -1
endfunction

" ============
" OS Name
" ============
function! settings#system#GetOSName()
    if (has("win16") || has("win32") || has("win64"))

        let parts = split(settings#system#GetOSVersion(), '\.')

        if parts[0] == "5"
            if parts[1] == "2"
                return "Windows 2003 or XP 64 bit " . expand("$PROCESSOR_ARCHITECTURE")
            else
                return "Windows XP ". expand("$PROCESSOR_ARCHITECTURE")
            endif
        elseif parts[0] == "6"
            if parts[1] == "1"
                return "Windows 7 or Windows 2008 R2 ". expand("$PROCESSOR_ARCHITECTURE")
            else
                return "Windows Vista or Windows 2008 ". expand("$PROCESSOR_ARCHITECTURE")
            endif
        endif
    endif
    return "Unknown Version"
endfunction

" ===================================================================
" End
" ===================================================================

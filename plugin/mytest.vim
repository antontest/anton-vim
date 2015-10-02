set nocp exrc
"au FileType c :call Showstr()
fu! GetCursorPreChar()
    return getline('.')[col('.')-2]
endf

fu! Showstr()
    let str=GetCursorPreChar()
    if str != ' '
        :echo "blank"
        ino , <SPACE>,&str
    else
        :echo "string is:"str
    endif
endf

nmap <Leader>pr :call Showstr()<CR>

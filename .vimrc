" Use bundle config if available
if filereadable(expand("~/.vim/vimrcs/bundle.vim"))
        source ~/.vim/vimrcs/bundle.vim
endif

" Use general config if available
if filereadable(expand("~/.vim/vimrcs/general.vim"))
        source ~/.vim/vimrcs/general.vim
endif

" Use keymap config if available
if filereadable(expand("~/.vim/vimrcs/keymap.vim"))
        source ~/.vim/vimrcs/keymap.vim
endif

" Use plugin config if available
if filereadable(expand("~/.vim/vimrcs/plugin.vim"))
        source ~/.vim/vimrcs/plugin.vim
endif

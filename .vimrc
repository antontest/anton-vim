" Use bundle config if available
if filereadable(expand("~/.vim/conf/bundle.vim"))
        source ~/.vim/conf/bundle.vim
endif

" Use general config if available
if filereadable(expand("~/.vim/conf/general.vim"))
        source ~/.vim/conf/general.vim
endif

" Use keymap config if available
if filereadable(expand("~/.vim/conf/keymap.vim"))
        source ~/.vim/conf/keymap.vim
endif

" Use plugin config if available
if filereadable(expand("~/.vim/conf/plugin.vim"))
        source ~/.vim/conf/plugin.vim
endif

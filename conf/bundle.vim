"*****************************************************
""                 Vundle Setting                    *
"*****************************************************
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" The following are examples of different formats supported.
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Bundle 'gmarik/vundle'
" Bundle 'sjl/gundo.vim'
" Bundle 'vim-scripts/vcscommand.vim'
" Bundle 'plasticboy/vim-markdown'
" Bundle 'vim-scripts/TxtBrowser'
" Bundle 'AndrewRadev/splitjoin.vim'
" Bundle 'roman/golden-ratio'
" Bundle 'Shougo/unite.vim'
" Bundle 'Shougo/vimproc.vim'
" Bundle 'vim-scripts/TaskList.vim'
" Bundle 'honza/vim-snippets'
" Bundle 'SirVer/ultisnips'
" Bundle 'msanders/snipmate.vim'
" Bundle 'scrooloose/syntastic'
" Bundle 'fholgado/minibufexpl.vim'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'oblitum/YouCompleteMe'
" Bundle 'vim-scripts/OmniCppComplete'
" Bundle 'ervandew/supertab'
" Bundle 'justmao945/vim-clang'
" Bundle 'vim-scripts/c.vim'
" Bundle 'bling/vim-bufferline'
" Bundle 'plasticboy/vim-markdown'
" Bundle 'gcmt/wildfire.vim'
" Bundle 'jiangmiao/auto-pairs'
" Bundle 'Shougo/neocomplcache.vim'
" Bundle 'Shougo/neosnippet'
" Bundle 'Shougo/neosnippet-snippets'
" Bundle 'Shougo/vimshell.vim' 
" Bundle 'vim-scripts/AutoComplPop'
" Bundle 'garbas/vim-snipmate'

" Plugin Running
"" others
"""""""""""""""""""""""""""""""""""""""""
" Bundle 'itchyny/calendar.vim'
" Bundle 'vim-scripts/sessionman.vim'
" Bundle 'bogado/file-line'
" Bundle 'amitab/vim-unite-cscope'
" Bundle 'Shougo/unite.vim'
" Bundle 'Shougo/vimproc.vim'
" Bundle 'brookhong/cscope.vim'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'oplatek/Conque-Shell'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'vim-scripts/vcscommand.vim'

"" status and list bar
""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/taglist.vim'
Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'vim-scripts/undotree.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/winmanager'
" Bundle 'wellle/targets.vim'

"" code style
Bundle 'godlygeek/tabular'
Bundle 'luochen1990/rainbow'
Bundle 'junegunn/vim-easy-align'
Bundle 'Yggdroot/indentLine'
" Bundle 'nathanaelkane/vim-indent-guides'

"" easy move, match and find
"""""""""""""""""""""""""""""""""""""""""
Bundle 'Lokaltog/vim-easymotion'
Bundle 'edsono/vim-matchit'
Bundle 'dkprice/vim-easygrep'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'kristijanhusak/vim-multiple-cursors'
Bundle 'terryma/vim-expand-region'
Bundle 'tybenz/ctrl-z'

"" git amd man enhance
"""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/gitignore'
Bundle 'chemzqm/vim-easygit'
Bundle 'chemzqm/unite-git-log'
Bundle 'mhinz/vim-signify'
" Bundle 'airblade/vim-gitgutter'
" Bundle 'vim-utils/vim-man'
" Bundle 'vim-scripts/CaptureClipboard'
" Bundle 'jeetsukumaran/vim-buffergator'
" Bundle 'vim-scripts/sh.vim--Cla'

"" code comment
"""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/DoxygenToolkit.vim'
" Bundle 'scrooloose/nerdcommenter'

"" code auto complete
"""""""""""""""""""""""""""""""""""""""""
Bundle 'tsaleh/vim-supertab'
Bundle 'drmingdrmer/xptemplate' 
Bundle 'xaizek/vim-inccomplete'
Bundle 'vim-scripts/L9'
Bundle 'tpope/vim-repeat'
Bundle 'vim-scripts/AutoComplpop'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/echofunc.vim'
" Bundle 'vim-scripts/TTrCodeAssistor'
" Bundle 'terhechte/syntastic'
" Bundle 'marcweber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'guns/ultisnips'
" Bundle 'vim-scripts/autoproto.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


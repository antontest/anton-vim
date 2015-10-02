""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    _      _
"   (_)  __(_)___ ___
"   | | / / / __ `__ \
"   | |/ / / / / / / /
"   |___/_/_/ /_/ /_/
"
"   Main Contributor: Antonio <d198908@163.com>
"   Version: 1.0
"   Created: 2015-10-01
"   Last Modified: 2015-10-01
"
"   Sections:
"     -> General
"     -> User Interface
"     -> Autocmd
"     -> Colors and Fonts
"     -> Files and backups 
"     -> Indent Related
"     -> Search Related
"     -> Fold Related
"     -> Key Mapping
"     -> Plugin Setting
"     -> Bundle
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                     General                       *
"*****************************************************
set nocompatible                  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set viminfo='1000,f1,:1000,/1000  " 保存全局变量
set timeoutlen=500                " Time to wait for a command
set backupcopy=yes                " see :help crontab

" set mouse to work in the console
" set mouse=a

set number                      " Show line numbers
set showcmd                     " Show cmd
set showmode                    " Show mode, insert, normal
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
" set matchtime=2               " Decrease the time to blink

" New splits open to right and bottom
set splitbelow
set splitright

" Enable filetype plugin  
" filetype on
" filetype plugin on
" filetype indent on  
" filetype plugin indent on " Enable filetype

set history=1000          " Increase the lines of history
set modeline              " Turn on modeline
set completeopt+=longest  " Optimize auto complete
set completeopt-=preview  " Optimize auto complete

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set noeb

" size of cmd window
set cmdheight=1

" Set directories
function! InitializeDirectories()
    let parent=$HOME
    let prefix='.vim'
    let dir_list={
                \ 'backup': 'backupdir',
                \ 'view': 'viewdir',
                \ 'swap': 'directory',
                \ 'undo': 'undodir',
                \ 'cache': '',
                \ 'session': ''}
    for [dirname, settingname] in items(dir_list)
        let directory=parent.'/'.prefix.'/'.dirname.'/'
        if !isdirectory(directory)
            if exists('*mkdir')
                let dir = substitute(directory, "/$", "", "")
                call mkdir(dir, 'p')
            else
                echo 'Warning: Unable to create directory: '.directory
            endif
        endif
        if settingname!=''
            exec 'set '.settingname.'='.directory
        endif
    endfor
endfunction
call InitializeDirectories()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                User Interface                     *
"*****************************************************
" Set title
set title
set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)

" Set tabline
set showtabline=2 " Always show tab line
" Set up tab labels
set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]
set tabline=%!MyTabLine()
function! MyTabLine()
    let s=''
    let t=tabpagenr() " The index of current page
    let i=1
    while i<=tabpagenr('$') " From the first page
        let buflist=tabpagebuflist(i)
        let winnr=tabpagewinnr(i)
        let s.=(i==t ? '%#TabLineSel#' : '%#TabLine#')
        let s.='%'.i.'T'
        let s.=' '
        let bufnr=buflist[winnr-1]
        let file=bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        let m=''
        if getbufvar(bufnr, '&modified')
            let m='[+]'
        endif
        if buftype=='nofile'
            if file=~'\/.'
                let file=substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file=fnamemodify(file, ':p:t')
        endif
        if file==''
            let file='[No Name]'
        endif
        let s.=m
        let s.=i.':'
        let s.=file
        let s.='['.winnr.']'
        let s.=' '
        let i=i+1
    endwhile
    let s.='%T%#TabLineFill#%='
    let s.=(tabpagenr('$')>1 ? '%999XX' : 'X')
    return s
endfunction
" Set up tab tooltips with each buffer name
set guitabtooltip=%F

" Only have cursorline in current window and in normal window
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Use powerful wildmenu
set shortmess=at                " Avoids hit enter

set backspace=indent,eol,start  " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,]      " Backspace and cursor keys wrap to
set virtualedit=block,onemore   " Allow for cursor beyond last character
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set sidescroll=1                " Minimal number of columns to scroll horizontally
set sidescrolloff=10            " Minimal number of screen columns to keep away from cursor

set formatoptions+=rnlmM        " Optimize format options
set wrap                        " Set wrap
set textwidth=80                " Change text width

"set list                                           " Show these tabs and spaces and so on
"set listchars=tab:?\ ,eol:?,extends:?,precedes:?   " Change listchars
set linebreak                                       " Wrap long lines at a blank
set showbreak=?                                     " Change wrap line break
set fillchars=diff:?,vert:│                         " Change fillchars
augroup trailing                                    " Only show trailing whitespace when not in insert mode
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:?
    autocmd InsertLeave * :set listchars+=trail:?
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"*****************************************************
""                     Autocmd                       *
"*****************************************************
autocmd  BufWritePost  ~/.vimrc source ~/.vimrc         " Source the vimrc file after saving it
autocmd! bufwritepost  ~/.vimrc source ~/.vimrc         " autocmd BufWritePost $MYVIMRC NeoBundleClean
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
autocmd InsertEnter * set nocursorline
autocmd InsertLeave * set cursorline
" autocmd BufWritePost *.c,*.h,*.cpp call UpdateCtags() " auto build tags
" autocmd BufWinLeave *.* silent! mkview                " Make Vim save view (state) (folds, cursor, etc)
" autocmd BufWinEnter *.* silent! loadview              " Make Vim load view (state) (folds, cursor, etc)
" Automatically jump to the next open position
autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \ exe "normal! g'\"" |
            \ endif 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                Colors and Fonts                   *
"*****************************************************
syntax on     " Enable syntax
set t_Co=256  " Use 256 colors
" syntax enable

" Coding mode
set encoding=utf-8        " Set utf-8 encoding
set fencs=utf-8,gb18030 

" Automatic judge coding
set fileformats=unix
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set background=dark  "dark, light
colorscheme mydy  
"Dracula peaksea fruit vylight taqua molokai winter tcsoft peachpuff lettuce ,kellys ,mustang dawn bclear habilight default nuvola zellner vc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"*****************************************************
""                Files and backups                  *
"*****************************************************
" Turn backup off, since most stuff is in SVN, git anyway...  
set nowb  
set noswapfile  
set nowritebackup
set nobackup 

" Session 
set sessionoptions-=curdir
set sessionoptions+=sesdir

set autoread              " Set autoread when a file is changed outside
set autowrite             " Write on make/shell commands
set hidden                " Turn on hidden"
set backup                " Set backup
set undofile              " Set undo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                  Indent Related                   *
"*****************************************************
set autoindent     " Preserve current indent on new lines
set cindent        " set C style indent
set expandtab      " Convert all tabs typed to spaces
set softtabstop=4  " Indentation levels every four columns
set shiftwidth=4   " Indent/outdent by four columns
set shiftround     " Indent/outdent to nearest tabstop
set smartindent    " 开启新行的自动缩进
set smarttab       " 根据 “shiftwidth” 插入空白
set tabstop=4 
set formatoptions=tcrqn
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,node_modules/*
"Format C code
set et
set ci


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"*****************************************************
""                  Search Related                   *
"*****************************************************
set smartcase   " Case sensitive when uc present
set hlsearch    " Highlight search terms
set incsearch   " Find as you type search
set gdefault    " turn on g flag
set noic
set ignorecase  " Case insensitive search
" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction

" Use sane regexes, Search Related 
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                   Fold Related                   *
"*****************************************************
set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(' ',fillcharcount).foldedlinecount.'L'.' '
endfunction
set foldtext=MyFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                    Key Mapping                    *
"*****************************************************
" With a map leader it's possible to do extra key combinations  
" like <leader>w saves the current file  
let mapleader=','                         " Change the mapleader
let g:mapleader = ","  
let maplocalleader='\'                    " Change the maplocalleader
" set pastetoggle=<F2>                    " F2 = Paste Toggle (in insert mode, pasting indented text behavior changes)

" copy and paste
" nmap <C-v> "+gp  
" nmap <C-c> "+y  

" fast edite file
nmap <leader>w  :w!<cr>                  " Fast saving  
nmap <leader>q  :q!<cr>                  " Fast quit  
nmap <leader>;; :wq!<cr>                 " Fast saving and quit 

" fast edite and resource .vimrc
nnoremap <Leader>x  :tabedit ~/.vimrc<CR>  " Fast edit the .vimrc file using ,x
nnoremap <Leader>rs :source ~/.vimrc<CR>

" Space to toggle and create folds.
nnoremap <silent> <Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
vnoremap <Space> zf

" Select entire buffer
nnoremap vaa ggvGg_

" Modify all the indents
nnoremap \= gg=G

" shift tab pages
nnoremap ;p  :tabp<CR>                    " Previous tab
nnoremap ;n  :tabn<CR>                    " Next tab

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Strip all trailing whitespace in the current file
" nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

" Plugin Key Mapping
" Tabularize
nmap <Leader>a&     :Tabularize /&<CR>
vmap <Leader>a&     :Tabularize /&<CR>
nmap <Leader>a=     :Tabularize /=<CR>
vmap <Leader>a=     :Tabularize /=<CR>
nmap <Leader>a:     :Tabularize /:<CR>
vmap <Leader>a:     :Tabularize /:<CR>
nmap <Leader>a::    :Tabularize /:\zs<CR>
vmap <Leader>a::    :Tabularize /:\zs<CR>
nmap <Leader>a,     :Tabularize /,<CR>
vmap <Leader>a,     :Tabularize /,<CR>
nmap <Leader>a,,    :Tabularize /,\zs<CR>
vmap <Leader>a,,    :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" Doxygen toolkit  
:nmap <C-@>m :Dox<CR>

" NERDTree
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" Calendar
nnoremap <Leader>cal :Calendar<CR>
nnoremap <Leader>cay :Calendar -view=year -split=vertical -width=27<CR>

" ctags
nmap <F10> :call UpdateCtags()<CR>
" map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

" taglist
nnoremap <Leader>tl :Tlist<CR>

" cscope
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>    
" nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>    
" nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR><CR>

" session
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>

" multi_cursor
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'

" NeoComplCache
inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"

"rkdown to HTML  
nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>

" Vundle
nnoremap <Leader>bl :BundleList<CR> 
nnoremap <Leader>bd :BundleInstall<CR> 
nnoremap <Leader>bu :BundleUpdate<CR> 
nnoremap <Leader>bc :BundleClean<CR> 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"--------------------------------------------------------------------
" => Plugin Setting
"--------------------------------------------------------------------

"*****************************************************
""                Doxygen toolkit                    *
"*****************************************************
let g:DoxygenToolkit_commentType="C"
let g:DoxygenToolkit_authorName="Antonio_an"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1

"*****************************************************
""                     NERDTree                      *
"*****************************************************
let NERDTreeWinPos = 'right'
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let g:nerdtree_tabs_open_on_gui_startup=0

"*****************************************************
""                     undotree                      *
"*****************************************************
let g:undotree_SetFocusWhenToggle=1
set undodir='~/.undodir/'
set undofile

"*****************************************************
""                     Calendar                      *
"*****************************************************
let g:calendar_frame = 'default'

"*****************************************************
""                       ctags                       *
"*****************************************************
function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction

" tag files path
set tags=tags;
set tags+=~/tools/include/tags;
set tags+=~/.vim/systags;
set tags+=/usr/include/tags;
set tags+=~/.vim/tags/libc.tags
set tags+=~/.vim/tags/susv2.tags
set tags+=~/.vim/tags/glib.tags
set tags+=~/.vim/tags/cpp.tags
set autochdir 

"*****************************************************
""                     echofunc                      *
"*****************************************************
set tags+=/usr/include/tags 
let g:EchoFuncLangsUsed = ["c", "cpp", "java"] 
"let g:EchoFuncShowOnStatus = 1 

"*****************************************************
""                     taglist                      *
"*****************************************************
" let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Compact_Format=1
let Tlist_Show_One_File=1  
let Tlist_Auto_Highlight_tag=1
let Tlist_Exit_OnlyWindow=1 
let Tlist_Use_SingClick=1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
set completeopt=longest,menu
" let Tlist_Sort_Type = "name"  " Sort by name

"*****************************************************
""                       cscope                      *
"*****************************************************
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set nocst
    set cspc=6
    let g:autocscope_menus=0
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        cs add /usr/include/cscope.out
        cs add /home/anton/tools/include/cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
        cs add /usr/include/cscope.out
        cs add /home/anton/tools/include/cscope.out
    endif
    set csverb
    " show in quickbuffer
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif 

"*****************************************************
""                     supertab                      *
"*****************************************************
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"*****************************************************
""                OmniCppComplete                    *
"*****************************************************
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"*****************************************************
""                    Vim-Airline                    *
"*****************************************************
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep='?'  " Slightly fancier than '>'
let g:airline_right_sep='?' " Slightly fancier than '<'

let g:airline_theme='bubblegum'
let g:bufferline_modified='[+]'
let g:bufferline_echo=0
set noshowmode " Hide the default mode text

set guifont=Ubuntu\ Mono\ derivative\ Powerline
" set status line
set laststatus=2
set fillchars+=stl:\ ,stlnc:\
" enable powerline-fonts
" let g:airline_powerline_fonts = 1
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'

function! AirlineInit()
	let g:airline#extensions#tabline#buffer_nr_show = 1
	let g:airline_section_c = airline#section#create(['%{getcwd()}/%t'])
	let g:airline_section_z = airline#section#create(['Pos: %p%% %l/%L:%c '])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

"*****************************************************
""                      ultisnips                    *
"*****************************************************
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger="<F2>"
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'

"*****************************************************
""                  NeoComplCache                    *
"*****************************************************
let g:neocomplcache_enable_at_startup=1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_quick_match = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"*****************************************************
""                    session                        *
"*****************************************************
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize

"*****************************************************
""                    Tag bar                        *
"*****************************************************
nnoremap <Leader>tg :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width=30
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_zoomwidth = 0
let g:tagbar_sort = 0
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

"*****************************************************
""                     rainbow                       *
"*****************************************************
"0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
    "   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    "   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['brown', 'darkmagenta', 'darkblue', 'darkcyan'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \   'c': {
    \     'parentheses': [
    \       'start=/(/ end=/)/ fold',
    \       'start=/\[/ end=/\]/ fold',
    \       'start=/{/ end=/}/ fold',
    \       'start=/\(\(\<operator\>\)\@<!<\)\&[a-zA-Z0-9_]\@<=<\ze[^<]/ end=/>/'] 
    \       }, 
    \   'cpp': {
    \     'parentheses': [
    \       'start=/(/ end=/)/ fold',
    \       'start=/\[/ end=/\]/ fold',
    \       'start=/{/ end=/}/ fold',
    \       'start=/\(\(\<operator\>\)\@<!<\)\&[a-zA-Z0-9_]\@<=<\ze[^<]/ end=/>/'] 
    \       }, 
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}


"*****************************************************
""                 Matchit Setting                   *
"*****************************************************
" Use Tab instead of % to switch
nmap <Tab> %
vmap <Tab> %

"*****************************************************
""              multi_cursor Setting                 *
"*****************************************************
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_exit_from_visual_mode=1
" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

"*****************************************************
""                    Syntastic                      *
"*****************************************************
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_error_symbol = '?'
let g:syntastic_style_error_symbol = '?'
let g:syntastic_warning_symbol = '?'
let g:syntastic_style_warning_symbol = '≈'

"****************************************************
""                    Splitjoin                     *
"****************************************************
let g:splitjoin_split_mapping = ',s'
let g:splitjoin_join_mapping  = ',j'
let g:splitjoin_normalize_whitespace=1
let g:splitjoin_align=1

"*****************************************************
""                    markdown                       *
"*****************************************************
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
let g:vim_markdown_frontmatter=1

"*****************************************************
""                 Vundle Setting                    *
"*****************************************************
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Bundle 'gmarik/vundle'
" Bundle 'sjl/gundo.vim'
" Bundle 'vim-scripts/vcscommand.vim'
" Bundle 'plasticboy/vim-markdown'
" Bundle 'vim-scripts/TxtBrowser'
" Bundle 'AndrewRadev/splitjoin.vim'
" Bundle 'roman/golden-ratio'
" Bundle 'Shougo/unite.vim'
" Bundle 'Shougo/vimproc.vim'

" The following are examples of different formats supported.
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/sessionman.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-repeat'
Bundle 'dkprice/vim-easygrep'
Bundle 'luochen1990/rainbow'
Bundle 'vim-scripts/echofunc.vim'
Bundle 'edsono/vim-matchit'
Bundle 'kristijanhusak/vim-multiple-cursors'
Bundle 'wellle/targets.vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'plasticboy/vim-markdown'


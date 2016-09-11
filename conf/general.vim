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

"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
"好处：误删什么的，如果以前屏幕打开，可以找回
" set t_ti= t_te=

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=exclusive
set selection=inclusive
set selectmode=mouse,key

" size of cmd window
set cmdheight=1

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
set cul " Highlight the current line   

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

" set formatoptions+=rnlmM      " Optimize format options
set formatoptions+=mM           " Optimize format options
set wrap                        " Set wrap
set textwidth=120               " Change text width

" set list                                           " Show these tabs and spaces and so on
" set listchars=tab:?\ ,eol:?,extends:?,precedes:?   " Change listchars
" set linebreak                                       " Wrap long lines at a blank
set showbreak=?                                     " Change wrap line break
set fillchars=diff:?,vert:│                         " Change fillchars
augroup trailing                                    " Only show trailing whitespace when not in insert mode
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:?
    autocmd InsertLeave * :set listchars+=trail:?
augroup END

" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
"set relativenumber number
"au FocusLost * :set norelativenumber number
"au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
"autocmd InsertEnter * :set norelativenumber number
"autocmd InsertLeave * :set relativenumber
"function! NumberToggle()
"    if(&relativenumber == 1)
"        set norelativenumber number
"    else
"        set relativenumber
"    endif
"endfunc
"nnoremap `n :call NumberToggle()<cr>

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" allows cursor change in tmux mode
"if exists('$TMUX')
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif


" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

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

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CompleteDone * pclose
augroup GoAwayPreviewWindow
autocmd! InsertLeave * wincmd z
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"*****************************************************
""                Colors and Fonts                   *
"*****************************************************
syntax on     " Enable syntax
" syntax enable

" Coding mode
set encoding=utf-8        " Set utf-8 encoding
set fencs=utf-8,gb18030 
set termencoding=utf-8 
set sessionoptions=blank,buffers,folds,help,resize,tabpages,winpos,winsize " Set session persistence options
set noequalalways " Do not maintain window-size ratio (when having multiple window splits I don't find it desirable)

" Automatic judge coding
set fileformats=unix
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set t_Co=256  " Use 256 colors
colorscheme mydy
set background=light "dark, light
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
" set nowrap

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
" set formatoptions=tcrqn
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
" nnoremap / /\v
" vnoremap / /\v
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

" quickfix的使用, 回车跳转到报错点, s或v分屏打开
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window =>
" open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" 关闭方向键, 强迫自己用 hjkl
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nu!<CR>
" F4 换行开关
nnoremap <F3> :set wrap! wrap?<CR>
set pastetoggle=<F4>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" disbale paste mode when leaving insert mode 
au InsertLeave * set nopaste
" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F5> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" 多窗口编辑时, 临时放大某个窗口, 编辑完再切回原来的布局
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" 分号映射为冒号, 省得要进入命令模式需要按shift 
" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

" H和L跳转到行首行末, 实在不想按0和$, 太远 
" Go to home and end using capitalized directions
noremap H ^
noremap L $

" 命令行模式快捷键, ctrl-a/e跳转到行首行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 交换#和*, #更近
" switch # *
nnoremap # *
nnoremap * #

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" 复制动作的变更, Y, 复制到行末
" y$ -> Y Make Y behave like other capitals
map Y y$

" 选中全部/选中段落 
" select all
" map <Leader>sa ggVG"
" select block
nnoremap <leader>v V`}

" 保存, 没权限的时候 
" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif

" 其他一些设置 
" 启动的时候不显示那个援助索马里儿童的提示 
set shortmess=atI
" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉 
" 好处：误删什么的，如果以前屏幕打开，可以找回 
" set t_ti= t_te= 
" 鼠标暂不启用, 键盘党.... 
set mouse-=a 

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange 

" for error highlight，防止错误整行标红导致看不清 
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" filetype
filetype plugin on
filetype plugin indent on 

"******************************************************************
"****************** Plugin Setting ********************************
"******************************************************************
""--------------------------------------------------------------------
"" => Other enhance
""--------------------------------------------------------------------

"*****************************************************
""                      Vim-Man                      *
"*****************************************************
map <C-m> <Plug>(Man) "open man page for word under cursor in a horizontal split
" map <C-M> <Plug>(Vman) "open man page for word under cursor in a vertical split


"*****************************************************
""                     Calendar                      *
"*****************************************************
let g:calendar_frame = 'default'
" Calendar Key Binding
nnoremap <Leader>cal :Calendar<CR>
nnoremap <Leader>cay :Calendar -view=year -split=vertical -width=27<CR>


"*****************************************************
""                    session                        *
"*****************************************************
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
" session Key Binding
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>


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

" multi_cursor Key Binding
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'


"*****************************************************
""                  miniBufexplorer                  *
"*****************************************************
let g:miniBufExplVSplit=32
let g:miniBufExplBRSplit=1
let g:miniBufExplorerAutoStart=1
let g:miniBufExplBuffersNeeded=2
let g:miniBufExplMapWindowNavArrows = 1  
let g:miniBufExplMapWindowNavVim = 1  
let g:miniBufExplMapCTabSwitchWindows = 1  
"let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
"解决FileExplorer窗口变小问题  
let g:miniBufExplForceSyntaxEnable = 1  
let g:miniBufExplorerMoreThanOne=2  


""--------------------------------------------------------------------
"" => Status line
""--------------------------------------------------------------------
"*****************************************************
""              vim-indent-guides                    *
"*****************************************************
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1 " 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey


"*****************************************************
""                     echofunc                      *
"*****************************************************
let g:EchoFuncLangsUsed = ["c", "cpp", "java"] 
"let g:EchoFuncShowOnStatus = 1 
" Key to echo the next function
" let g:EchoFuncKeyNext = '<C-Space>'
" Key to echo the prev function
" let g:EchoFuncKeyPrev = '<C-S-Space>'

"*****************************************************
""                    Vim-Airline                    *
"*****************************************************
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" let g:airline_symbols.space = "\ua0"

" unicode symbols
let g:airline_left_sep='?'  " Slightly fancier than '>'
let g:airline_right_sep='?' " Slightly fancier than '<'
let g:airline_theme='simple'
let g:bufferline_modified='[+]'
let g:bufferline_echo=0
set noshowmode " Hide the default mode text
set guifont=Ubuntu\ Mono\ derivative\ Powerline
" set status line
set laststatus=2
set fillchars+=stl:\ ,stlnc:\
" enable powerline-fonts
let g:airline_powerline_fonts = 0
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

function! AirlineInit()
	let g:airline#extensions#tabline#buffer_nr_show = 1
	" let g:airline_section_b = airline#section#create(['%{getcwd()}'])
	" let g:airline_section_b = '%{strftime("%c")}'
	let g:airline_section_z = airline#section#create(['Pos: %p%% %l/%L:%c  '])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

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


""--------------------------------------------------------------------
"" => Code Comment
""--------------------------------------------------------------------

"*****************************************************
""                Doxygen toolkit                    *
"*****************************************************
let g:DoxygenToolkit_commentType="C"
let g:DoxygenToolkit_authorName="Antonio_an"
let s:licenseTag = "Copyright(C)\<enter\>"
let s:licenseTag = s:licenseTag . "For free\<enter\>"
let s:licenseTag = s:licenseTag . "All right reserved"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
" Doxygen toolkit Key Binding
:nmap <C-@>m :Dox<CR>


""--------------------------------------------------------------------
"" => Tag bar
""--------------------------------------------------------------------

"*****************************************************
""                       ctags                       *
"*****************************************************
" tag files path
set tags=tags;
set tags+=~/tools/tags/tools.tags;
set tags+=~/tools/tags/usr_include_std.tags
set tags+=~/tools/tags/usr_include_str_time.tags
set tags+=~/tools/tags/usr_include_net.tags
set tags+=~/tools/tags/usr_include_sys.tags
" set tags+=~/.vim/systags;
set autochdir 

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+liaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction

" ctags Key Binding
nmap <F10> :call UpdateCtags()<CR>
" map <F5> :!ctags -R --c++-kinds=+p --fields=+liaS --extra=+q .<CR><CR> :TlistUpdate<CR>


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
" set completeopt=preview,longest,menu,menuone
" let Tlist_Sort_Type = "name"  " Sort by name
" taglist Key Binding
" nnoremap <Leader>tl :Tlist<CR>

"*****************************************************
""                    Tag bar                        *
"*****************************************************
nnoremap <Leader>t :TagbarToggle<CR>
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
""                     NERDTree                      *
"*****************************************************
let NERDTreeWinPos = 'left'     " left
let NERDTreeChDirMode=2          "选中root即设置为当前目录
let NERDTreeQuitOnOpen=1         "打开文件时关闭树
let NERDTreeShowBookmarks=1      "显示书签
let NERDTreeMinimalUI=1          "不显示帮助面板
let NERDTreeShowHidden=1         "目录箭头 1 显示箭头 0传统+-|号
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let nerdtree_tabs_open_on_gui_startup=0
" NERDTree Key Binding
nnoremap <Leader>d :NERDTreeToggle<CR>
" nnoremap <Leader>f :NERDTreeFind<CR>


"*****************************************************
""                     undotree                      *
"*****************************************************
let g:undotree_SetFocusWhenToggle=1
set undodir='~/.undodir/'
set undofile
" undotree Key Binding
nnoremap <Leader>u :UndotreeToggle<CR>

""--------------------------------------------------------------------
"" => Search
""--------------------------------------------------------------------

"*****************************************************
""                vim-expand-region                  *
"*****************************************************
" let g:expand_region_use_select_mode = 1

" Default settings. (NOTE: Remove comments in dictionary before sourcing)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1, 
      \ 'iB'  :1,
      \ 'il'  :0, 
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ }

" Extend the global default (NOTE: Remove comments in dictionary before sourcing)
call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1, 
      \ 'ab' :1,
      \ 'aB' :1, 
      \ 'ii' :0, 
      \ 'ai' :0,
      \ })

map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

"*****************************************************
""                       cscope                      *
"*****************************************************
if has("cscope")
    set csprg=/usr/local/bin/cscope
    set csto=1
    set nocst
    set cspc=6
    let g:autocscope_menus=1
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " cs add /usr/include/cscope.out
    " cs add /home/anton/tools/include/cscope.out
    set csverb
    " show in quickbuffer
    " set cscopequickfix=s-,c-,d-,i-,t-,e-
endif 

" cscope Key Binding
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>    
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>    
" nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>    
" nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR><CR>

"*****************************************************
""                      ctrlp                        *
"*****************************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag
 
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>']}
endif


"*****************************************************
""                     EasyMotion                    *
"*****************************************************
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" EasyMotion  Key Binding
" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `s{char}{target}`
" `s<CR>` repeat last find motion.
nmap S <Plug>(easymotion-s)
" Bidirectional & within line 't' motion
omap T <Plug>(easymotion-bd-tl)

" hjkl-motion
map `l <Plug>(easymotion-lineforward)
map `j <Plug>(easymotion-j)
map `k <Plug>(easymotion-k)
map `h <Plug>(easymotion-linebackward)

" n-char motion 
map  ;/ <Plug>(easymotion-sn)
omap ;/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map ;n <Plug>(easymotion-next)
map ;N <Plug>(easymotion-prev)


""--------------------------------------------------------------------
"" => Code Style
""--------------------------------------------------------------------

"*****************************************************
""                     Tabularize                    *
"*****************************************************
" Tabularize Key Binding
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

"*****************************************************
""                   vim-easy-align                  *
"*****************************************************
" vim-easy-align Key Binding
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"*****************************************************
""                   indentLine                      *
"*****************************************************
"let g:indentLine_enabled=0
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
"let g:indentLine_concealcursor = 'vc' "(default 'inc')
"let g:indentLine_conceallevel = 0 "(default 2)


""--------------------------------------------------------------------
"" => Code Complete
""--------------------------------------------------------------------
"*****************************************************
""                  Path Complete                    *
"*****************************************************
imap <C-l> <C-X><C-F>

"*****************************************************
""                 Include Complete                  *
"*****************************************************
let g:inccomplete_showdirs=1
let g:inccomplete_appendslash=1
let b:inccomplete_root=1

"*****************************************************
""                     supertab                      *
"*****************************************************
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabRetainCompletionType=2
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose = 1

let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLeadingSpaceCompletion = 0
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>

" open omni completion menu closing previous if open and opening new   menu without changing the text
"inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ?
"'<Esc>i<Right>' : '<Esc>i') : '') .
"        \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\
"        <lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new
" menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ?   '<Esc>i<Right>' : '<Esc>i') : '') .
        \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\  <lt>Down>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"*****************************************************
""                     xptemplate                    *
"*****************************************************
" xptemplate
let g:xptemplate_vars = "SParg=&BRfun="			" 代码紧贴括号,函数名单行
" let g:xptemplate_brace_complete = "[{"		        " 括号引号自动补全	

" Prevent supertab from mapping <tab> to anything.
let g:SuperTabMappingForward = '<Plug>xpt_void'

" Tell XPTemplate what to fall back to, if nothing matches.
" Original SuperTab() yields nothing if g:SuperTabMappingForward was set to
" something it does not know.
let g:xptemplate_fallback = '<C-r>=XPTwrapSuperTab("n")<CR>'

fun! XPTwrapSuperTab(command) "{{{
    let v = SuperTab(a:command)
    if v == ''
        " Change \<Tab> to whatever you want, when neither XPTemplate or
        " supertab needs to do anything.
        return "\<Tab>"
    else
        return v
    end
endfunction "}}}

let g:xptemplate_key = '<Plug>triggerxpt'
inoremap <Plug>closePUM <C-v><C-v><BS>
imap <tab> <Plug>closePUM<Plug>triggerxpt
let g:xptemplate_fallback = 'nore:<TAB>' " Optional. Use this only when you have no other plugin like SuperTab to handle <TAB>.


"*****************************************************
""                  clang_complete                   *
"*****************************************************
set conceallevel=2
set concealcursor=vin
let g:clang_auto_select=1       " 弹出补全列表之后会自动选择第一个选项但不会生效
let g:clang_complete_auto=1 
let g:clang_complete_copen=0    " 该变量控制语法错误检查后是否打开quickfix窗口列表. 默认值是0表示不打开
let g:clang_periodic_quickfix=1
let g:clang_conceal_snippets=1
" let g:clang_user_options='-I~/tools/include -I/usr/include || exit 0'
let g:clang_user_options=''
let g:clang_auto_user_options=".clang_complete"
let g:clang_use_library=1
" let g:clang_library_path="~/etc/lib"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
let g:clang_close_preview=1
let g:clang_hl_errors=1
set pumheight=20              " Limit popup menu height
let g:clang_memory_percent=70 " Limit memory use
" let g:clang_jumpto_back_key="<a-t>"
" let g:clang_jumpto_declaration_key="<a-p>"
"
" For Objective-C, this needs to be active, otherwise multi-parameter methods
" won't be completed correctly
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
" let g:clang_snippets_engine = 'ultisnips'
let g:clang_complete_optional_args_in_snippets = 1

" Complete options (disable preview scratch window, longest removed to aways show menu)
set completeopt=menu,menuone
" set completeopt=menuone,menu,longest,preview

" SuperTab completion fall-back 
" let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

imap <C-k>  <esc><tab>
imap <C-j>  <esc><tab>
" imap <F1>  <esc><tab>

" nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>
ino <a-s> <esc>:call Show_error()<cr>
nno <a-s> <esc>:call Show_error()<cr>
func! Show_error()
   wall
   if &filetype == 'c' || &filetype == 'cpp'
      call g:ClangUpdateQuickFix()
   endif
endfunc


"*****************************************************
""                   AutoComplPop                    *
"*****************************************************
let g:acp_enableAtStartup = 1
let g:acp_ignorecaseOption = 1
let g:AutoComplPop_MappingDriven = 1  
let g:acp_completeOption = '.,w,b,k'
let g:acp_behaviorFileLength = 1
let g:acp_behaviorKeywordCommand = "\<C-n>"
let g:AutoComplPop_CompleteoptPreview = 1
" let g:acp_behaviorSnipmateLength = 2
let g:acp_behaviorFileLength = 2
let g:acp_behaviorKeywordLength = 2
" let g:clang_exec='~/etc/bin/clang'
 "color  
" hi Pmenu guibg=#444444  
" hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff  

" let g:acp_refeed_checkpoints = [2]
let g:acp_behavior = {
      \ 'c':    [],
      \ 'x':    [],
      \ 'php':    [],
      \ 'ruby':   [],
      \ 'python': [],
      \ 'less':   [],
      \ 'scss':   [],
      \ 'go':     [],
      \ }

call add(g:acp_behavior.c, {
      \   'command'      : "\<C-x>\<C-f>",
      \   'meets'        : 'acp#meetsForFile',
      \   'repeat'       : 1,
      \ })
call add(g:acp_behavior.c, {
      \   'command'      : "\<C-x>\<C-u>",
      \   'meets'        : 'acp#meetsForSnipmate',
      \   'repeat'       : 1,
      \ })
call add(g:acp_behavior.c, {
      \   'command'      : "\<C-x>\<C-o>",
      \   'meets'        : 'acp#meetsForKeyword',
      \   'repeat'       : 1,
      \ })
call add(g:acp_behavior.c, {
      \   'command'      : "\<C-x>\<C-n>",
      \   'meets'        : 'acp#meetsForKeyword',
      \   'repeat'       : 1,
      \ })


"*****************************************************
""                 TTrCodeAssistor                   *
"*****************************************************
let g:TTrCodeAssistor_AutoStart=1 
nnoremap <F1> :call TTrCodeAssistor_ToggleComments()<CR>
vnoremap <F1> :call TTrCodeAssistor_ToggleComments()<CR> 

"*****************************************************
""                     syntastic                     *
"*****************************************************
" Show sidebar signs.
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '>>'
let g:syntastic_style_error_symbol = '>>'
let g:syntastic_warning_symbol = '~~'
let g:syntastic_style_warning_symbol = '~~'

" Read the clang complete file
let g:syntastic_objc_config_file = '.clang_complete'
let g:syntastic_c_config_file = '.clang_complete'
let g:syntastic_cpp_config_file = '.clang_complete'

" Status line configuration
set statusline+=%#warningmsg#  " Add Error ruler.
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 2
let g:syntastic_check_on_wq = 0
let g:syntastic_shell = "/bin/bash"
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["c", "cpp", 'objc', 'objcpp'],
    \ "passive_filetypes": ["puppet"] }
nnoremap <silent> ~ :Errors<CR>

" tell it to use clang instead of gcc
let g:SyntasticRegistry = {}
let g:syntastic_c_compiler = 'clang'
if !exists('g:syntastic_objc_checker')
    if exists('g:loaded_youcompleteme')
        let g:syntastic_objc_checker = "ycm"
    else
        let g:syntastic_objc_checker = "gcc"
    endif
endif

if g:syntastic_objc_checker == "ycm"
    " runtime! syntax_checkers/objc/ycm.vim
elseif g:syntastic_objc_checker == "gcc" || g:syntastic_objc_checker == "clang"
    if executable(g:syntastic_objc_checker)
        " runtime! syntax_checkers/objc/gcc.vim
    endif
endif

" Fix syntastic error jumping
function! <SID>LocationPrevious()
    try
        lprev
    catch /^Vim\%((\a\+)\)\=:E553/
        llast
    endtry
endfunction

function! <SID>LocationNext()
    try
        lnext
    catch /^Vim\%((\a\+)\)\=:E553/
        lfirst
    endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> e[  <Plug>LocationPrevious
nmap <silent> e]  <Plug>LocationNext

"*****************************************************
""                      Vundle                       *
"*****************************************************
map <leader>F :FufFile<CR>
map <leader>f :FufTaggedFile<CR>
map <leader>g :FufTag<CR>
map <leader>b :FufBuffer<CR>

"*****************************************************
""                      Conque-Shell                 *
"*****************************************************
let g:ConqueTerm_StartMessages = 0
map <leader>ba :ConqueTermSplit bash<CR>
map <leader>vb :ConqueTermVSplit bash<CR>

"*****************************************************
""                      cscope.vim                   *
"*****************************************************
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>fl :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

"*****************************************************
""                      easygit                      *
"*****************************************************
let g:easygit_enable_command = 1

"*****************************************************
""                      unite-gitlog                 *
"*****************************************************
"call unite#custom#profile('gitlog', 'context', {
"  \  'start_insert': 0,
"  \  'no_quit': 1,
"  \  'vertical_preview': 1,
"  \ })
"nnoremap <Leader>gl :Unite -buffer-name=gitlog   gitlog<cr>

"*****************************************************
""                     vim-scripts/winmanager        *
"*****************************************************
" 设置winmanager
" " 设置界面分割
let g:winManagerWindowLayout = "TagList|FileExplorer"
" "设置winmanager的宽度，默认为25
let g:winManagerWidth = 30
" "定义打开关闭winmanager快捷键为F8
nmap <silent> <F8> :WMToggle<cr>
" "在进入vim时自动打开winmanager
" let g:AutoOpenWinManager = 1

"*****************************************************
""                      Markdown                     *
"*****************************************************
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'csharp=cs']
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

"*****************************************************
""                 vim-instant-markdown              *
"*****************************************************
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0

"*****************************************************
""                 vim-markdown-doc              *
"*****************************************************
"let g:mdtoc_starting_header_level = 2

"*****************************************************
""                 vim-flavored-markdown             *
"*****************************************************
"augroup markdown
"    au!
"    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
"augroup END


"*****************************************************
""                      For Thunderbird              *
"*****************************************************
au FileType mail call FT_mail()
function FT_mail()
    set nocindent
    set noautoindent
    set textwidth=68
    " reformat for 72 char lines
    " normal gggqGgg
    " settings
    setlocal spell spelllang=en
    " setlocal fileencoding=iso8859-1,utf-8
    set fileencodings=iso8859-1,utf-8
    " abbreviations
    iabbr  gd Good Day!
endfunction

"*****************************************************
""                   closetag for html               *
"*****************************************************
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.md,*mkd"

"*****************************************************
""                MatchTagAlway for html             *
"*****************************************************
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'md' : 1,
    \ 'markdown' : 1,
    \}
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 1
nnoremap <leader>% :MtaJumpToOtherTag<cr>
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" let g:html_indent_inctags = "html,body,head,tbody"

"*****************************************************
""                      mattn/emmet-vim              *
"*****************************************************
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global = 0
autocmd FileType html,css,md,markdown EmmetInstall
let g:user_emmet_leader_key='<C-Z>'
" let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/.snippets_custom.json')), "\n"))
  let g:user_emmet_settings = {
    \  'php' : {
    \    'extends' : 'html',
    \    'filters' : 'c',
    \  },
    \  'xml' : {
    \    'extends' : 'html',
    \  },
    \  'haml' : {
    \    'extends' : 'html',
    \  },
    \  'md' : {
    \    'extends' : ['md','mkd'],
    \  },
    \}
let vim_markdown_preview_github=1

"*****************************************************
""                      tComment                     *
"*****************************************************
map <leader>c <c-_><c-_>

"Markdown to HTML
nmap <leader>md :%!~/tools/markdown/Markdown.pl --html4tags <cr>

"*****************************************************
""                      Vundle                       *
"*****************************************************
" Vundle Key Binding
nnoremap <Leader>bl :BundleList<CR> 
nnoremap <Leader>bd :BundleInstall<CR> 
nnoremap <Leader>bu :BundleUpdate<CR> 
nnoremap <Leader>bc :BundleClean<CR> 

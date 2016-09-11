" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
"
highlight clear
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
" hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif
let colors_name = "mydy"

" highlight groups
hi Cursor ctermfg=16 ctermbg=253 guibg=#D74141 guifg=#e3e3e3
hi LineNr guifg=#777777 guibg=Black
hi Normal guifg=#c0c0c0 guibg=#294d4a ctermfg=none ctermbg=none
hi VertSplit guibg=#C0FFFF guifg=#075554 gui=none

" Console Colors
highlight Number     ctermfg=160 cterm=bold
highlight Boolean    ctermfg=173 ctermbg=none cterm=none
highlight Character  ctermfg=173 ctermbg=none cterm=bold
highlight String     ctermfg=red ctermbg=none cterm=none
highlight PreCondit  ctermfg=180 cterm=bold
highlight PreProc    ctermfg=20 cterm=none
highlight Macro      ctermfg=5 cterm=none
highlight Operator   ctermfg=148 cterm=none
highlight Comment    ctermfg=grey
highlight Constant   ctermfg=red cterm=none
highlight Error      ctermfg=red ctermbg=none cterm=bold
highlight Identifier ctermfg=darkgreen cterm=none guifg=palegreen
highlight Statement  ctermfg=29 cterm=bold,underline
highlight Visua      ctermfg=black	ctermbg=grey
highlight PreProc    ctermfg=26
highlight NonText    ctermfg=black	ctermbg=252	cterm=bold
highlight Typedef    ctermfg=253 cterm=bold
highlight Type       cterm=none
highlight kFunction  ctermfg=1 cterm=none
highlight cFunction  ctermfg=87 cterm=none gui=none
highlight uDefined   ctermfg=200 cterm=none gui=none guifg=#ee82ee
highlight uthis      ctermfg=none cterm=underline,bold gui=none guifg=#ee82ee
highlight stKey ctermfg=darkgreen cterm=none gui=none guifg=#ee82ee

" Diff
hi DiffAdd		ctermfg=Green	ctermbg=NONE	cterm=NONE
hi DiffDelete	ctermfg=18	ctermbg=252	cterm=NONE
hi DiffText		ctermfg=NONE	ctermbg=150	cterm=NONE
" hi DiffChange	ctermfg=111	ctermbg=none cterm=NONE

" Search
hi IncSearch cterm=underline,bold ctermbg=grey gui=UNDERLINE,BOLD guifg=#f0f0f8 guibg=#d000d0
hi Search    cterm=underline,bold ctermbg=grey ctermfg=none gui=BOLD guifg=#ffd0ff guibg=#c000c0

" Links
" highlight! link Search		Visual
highlight! link NonText 	Normal
highlight! link Conditional	Statement
highlight! link CursorColumn	CursorLine
highlight! link Debug		PreProc	
highlight! link Define		PreProc
highlight! link Delimiter	Identifier
highlight! link Directory	Statement
highlight! link ErrorMsg	Error
highlight! link Exception	Statement
highlight! link Float		Constant
highlight! link FoldColumn	Folded
highlight! link Ignore		Comment
highlight! link Include		PreProc
highlight! link IncSearch	Search
highlight! link Keyword		Identifier
highlight! link Label		Statement
highlight! link LineNr		Comment
highlight! link MatchParen	Statement
highlight! link MoreMsg		Identifier
highlight! link NonText		Comment
highlight! link Question	MoreMsg
highlight! link PreCondit	PreProc
highlight! link Repeat		Statement
highlight! link SignColumn	Identifier
highlight! link SpecialChar	Special
highlight! link SpecialComment	Special
highlight! link SpecialKey	Special
highlight! link SpellBad	Error
highlight! link SpellCap	Error
highlight! link SpellLocal	Error
highlight! link SpellRare	Error
highlight! link StorageClass	Type
highlight! link Structure	Type
highlight! link Title		Structure
highlight! link Todo		Error
highlight! link WarningMsg	Error

" highlight! link cFunction	Identifier
" highlight! link Function	Identifier
" highlight! link Typedef		Type
" highlight! link Operator	Identifier
" highlight! link String		Constant
" highlight! link Boolean		Constant
" highlight! link Number		Constant
" highlight! link Macro		PreProc
" vim: sw=2

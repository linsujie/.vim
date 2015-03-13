set guioptions-=m
set guioptions-=T
set guioptions-=r
if has("gui_macvim")
  " disable the original Cmd-T (open new tab)
  macmenu &File.New\ Tab key=<nop>
  " map Cmd-T to the CommandT plugin
  map <D-t> :CommandT<CR>
endif

set guifont=monospace\ 12
"set background=dark 
"colors jellybeans
colors rainbow_neon
let g:jellybeans_use_lowcolor_black = 0
"colors vividchalk
set t_Co=256          " 256 color mode
set cursorline        " highlight current line
highlight CursorLine          guibg=#003854 ctermbg=24  gui=none cterm=none

"latex
"if s:extfname ==? "tex" || s:extfname ==? "chap"
"  "缩进规则
"  source /usr/share/vim/vimfiles/indent/tex.vim
"  "补全词典
"  set dictionary+=~/.vim/dict/tex.dict
"
"  imap `o \omega
"  imap `N \nabla
"  imap `. \dfrac{<++>}{<++>}<++><S-Left><NL>
"  imap `' \phantom{<++>}<++><S-Left><NL>
"  imap FMC \mathcal{<++>}<++><S-Left><NL>
"  imap FBF \mathbf{<++>}<++><S-Left><NL>
"  imap FRM \mathrm{<++>}<++><S-Left><NL>
"  imap \|\| \left\|<++>\right\|<++><S-Left><S-Left><S-Left><NL>
"  imap SFG \SysuFig{<+!htpb+>}<CR>        {<+eps file+>}<CR>        {width=<++>}<CR>        {<+caption+>}<CR>        {fig:<+label+>}<NL>
"endif

"输入法设置
"if has('multi_byte_ime')
"未开启IME时光标背景色
hi Cursor guifg=bg guibg=Orange gui=NONE
"开启IME时光标背景色
hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
" 关闭Vim的自动切换IME输入法(插入模式和检索模式)
set iminsert=2 imsearch=0
let g:vimim_map='tab'
let g:vimim_mode='dynamic'
let g:vimim_shuangpin='abc'
" 插入模式输入法状态未被记录时，默认关闭IME
"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"endif
"endif


"endif


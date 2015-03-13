let s:extfname = expand("%:e")

"折叠方式
set foldmethod=indent
"文件识别
"filetype on

"latex
if s:extfname ==? "tex" || s:extfname ==? "chap"
  "缩进规则
  source /usr/share/vim/vimfiles/indent/tex.vim
  "补全词典
  set dictionary+=~/.vim/dict/tex.dict
  set spell
  imap `o \omega
  imap `N \nabla
  imap `. \dfrac{}{<++>}<++><S-Left><NL>
  imap `' \phantom{<++>}<++><S-Left><NL>
  imap FMC \mathcal{<++>}<++><S-Left><NL>
  imap FBF \mathbf{<++>}<++><S-Left><NL>
  imap FRM \mathrm{<++>}<++><S-Left><NL>
  imap \|\| \left\|<++>\right\|<++><S-Left><S-Left><S-Left><NL>
  imap SFG \SysuFig{<+!htpb+>}<CR>        {<+eps file+>}<CR>        {width=<++>}<CR>        {<+caption+>}<CR>        {fig:<+label+>}<NL>

  nmap <leader>sl :call SectionLable()<CR>
  nmap <leader>lc :%s/[^%]$/%/gc<CR>
  fun! SectionLable()
    let sectionline = getline(".")
    let  sectionname = substitute(sectionline, '\\subsection{\(.\+\)}', '\1', "g")
    let  sectionkind = "subsection"
    if sectionname ==? sectionline
      let sectionname = substitute(sectionline, '\\section{\(.\+\)}', '\1', "g")
      let sectionkind = "section"
    endif
    let sectionchname = tolower(sectionname)
    let sectionchname = substitute(sectionchname, ' ', '_', "g")
    :call setline(".", "\\" . sectionkind . "{" . sectionname . "}" . " \\label{" . sectionkind . "_" . sectionchname . "}")
  endfun

  let g:Tex_DefaultTargetFormat = 'pdf'
  let g:Tex_FormatDependency_pdf = 'pdf'
  let g:Tex_CompileRule_pdf = 'xelatex $*'
  let g:Tex_MultipleCompileFormats = 'pdf'
  let g:Tex_ViewRule_pdf = 'mupdf-x11 $*.pdf'

  hi texSuperscript cterm=bold ctermfg=3
  hi texSubscript cterm=bold ctermfg=3
  hi texSection term=bold cterm=bold ctermfg=6 guifg=Blue
  hi texEnvName term=bold cterm=bold ctermfg=6 guifg=Blue
  hi texEnvEnd term=bold cterm=bold ctermfg=6 guifg=Blue
  hi texComment ctermfg=6 guifg=Blue
  hi texCmdBody ctermfg=7
  hi texMath cterm=bold ctermfg=7
  hi texType cterm=bold ctermfg=7
  hi Special cterm=bold ctermfg=5
  hi String cterm=bold ctermfg=1
  hi Statement term=bold cterm=bold ctermfg=2
  hi Delimiter cterm=bold ctermfg=6 
  hi texGreek cterm=bold ctermfg=6
endif

"The Grammar checking
set nocompatible
filetype plugin on
let g:languagetool_jar='~/bin/LanguageTool-2.4.1/languagetool-commandline.jar'
let g:languagetool_disable_rules='WHITESPACE_RULE,EN_QUOTES,COMMA_PARENTHESIS_WHITESPACE,CURRENCY'
set spelllang=en


"字典
set keywordprg=sdcv

"Ruby
let g:rsenseHome = "/home/linsj/bin/rsense-0.3"
let g:rsenseUseOmniFunc = 0

"缩进线设置
set list
set listchars=tab:\..

""vundle
"set nocompatible
"filetype off
"
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"
"" let Vundle manage Vundle
"" required! 
"Bundle 'gmarik/vundle'
"
"" original repos on github
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" " vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" " non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (ie. when working on your own plugin)
" Bundle '/home/linsj/.vim/bundle/Powerline/'

filetype plugin indent on

"set tags for cc
if s:extfname ==? "cc"
  set tags=~/myclass/tags
endif

autocmd BufWrite,BufWrite * execute "%s/\\s\*$//"

"全局缩进设置
"set autoindent

"fortran
"if s:extfname ==? "f" || s:extfname ==? "F90"
"  if s:extfname ==? "f"
"     let b:fortran_fixed_source=1
"  endif

"set expandtab "以空格代替Tab符
"let fortran_more_precise=1
"source ~/.vim/ftplugin/fortran_codecomplete.vim
"source ~/.vim/indent/fortran.vim
""去掉固定格式每行开头的红色填充
"let fortran_have_tabs=1
""允许折叠
"let fortran_fold=1
"let fortran_fold_conditionals=1
"
"endif

"shell
"if s:extfname ==? "sh"
"source ~/.vim/indent/sh.vim
"endif

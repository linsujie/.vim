" Vim indent file
" Language:     Fortran 95, Fortran 90 (free source form)
" Description:  Indentation rules for continued statements and preprocessor
"               instructions
"               Indentation rules for subroutine, function and forall
"               statements
" Installation: Place this script in the $HOME/.vim/after/indent/ directory
"               and use it with Vim 7.1 and Ajit J. Thakkar's Vim scripts
"               for Fortran (http://www.unb.ca/chem/ajit/)
" Maintainer:   S閎astien Burton <sebastien.burton@gmail.com>
" License:      Public domain
" Version:      0.4
" Last Change:  2011 May 25
" Only load this indent file when no other was loaded
if exists("b:did_indent")
  finish
endif
let b:did_indent=1

" Modified indentation rules are used if the Fortran source code is free
" source form, else nothing is done
	setlocal indentexpr=SebuFortranGetFreeIndent()
	setlocal indentkeys+==~subroutine,=~function,=~forall,=~do,=~case,=~select
	setlocal indentkeys+==~endsubroutine,=~endfunction,=~endforall,=~enddo
	setlocal indentkeys+==~else,=~if,=~endif,=~where
	" Only define the functions once
	if exists("*SebuFortranGetFreeIndent")
		finish
	endif

" SebuFortranGetFreeIndent() is modified FortranGetFreeIndent():
" Returns the indentation of the current line
function SebuFortranGetFreeIndent()
	" No indentation for preprocessor instructions
	if getline(v:lnum) =~ '^\s*#'
		return 0
	endif
	" Previous non-blank non-preprocessor line
	let lnum = SebuPrevNonBlankNonCPP(v:lnum-1)
	" No indentation at the top of the file
	if lnum == 0
		return 0
	endif
	" Original indentation rules
	let ind = FortranGetIndent(lnum)
	" Continued statement indentation rule
	" Truth table (kind of)
	" Symbol '&'			|	Result
	" No			0	0	|	0	No change
	" Appearing		0	1	|	1	Indent
	" Disappering	1	0	|	-1	Unindent
	" Continued		1	1	|	0	No change
	let result = -SebuIsFortranContStat(lnum-1)+SebuIsFortranContStat(lnum)
	" One shiftwidth indentation for continued statements
	let ind += result*&sw
	" One shiftwidth indentation for subroutine, function and forall's bodies
	let line = getline(lnum)
	if line =~? '^\s*\(\(recursive\s*\)\=pure\|elemental\)\=\s*subroutine'
				\ || line =~? '^\s*\(\(recursive\s*\)\=pure\|elemental\)\=\s*'
				\ . '\(\(integer\|real\|complex\|logical\|character\|type\)'
				\ . '\((\S\+)\)\=\)\=\s*function'
				\ || line =~? '^\s*\(forall\)'
		let ind += &sw
	endif
	if getline(v:lnum) =~? '^\s*end\s*\(subroutine\|function\|forall\)'
		let ind -= &sw
	endif
	" You shouldn't use variable names begining with 'puresubroutine',
	" 'function', 'endforall', etc. as these would make the indentation
	" collapse: it's easier to pay attention than to implement the exceptions
	return ind
endfunction

" SebuPrevNonBlankNonCPP(lnum) is modified prevnonblank(lnum):
" Returns the line number of the first line at or above 'lnum' that is
" neither blank nor preprocessor instruction.
function SebuPrevNonBlankNonCPP(lnum)
	let lnum = prevnonblank(a:lnum)
	while getline(lnum) =~ '^\s*!.*$'
		let lnum = prevnonblank(lnum-1)
	endwhile
	return lnum
endfunction

" SebuIsFortranContStat(lnum):
" Returns 1 if the 'lnum' statement ends with the Fortran continue mark '&'
" and 0 else.
function SebuIsFortranContStat(lnum)
	let line = getline(a:lnum)
	return substitute(line,'!.*$','','') =~ '&\s*$'
endfunction

function FortranGetIndent(lnum)
  let ind = indent(a:lnum)
  let prevline=getline(a:lnum)
  " Strip tail comment
  let prevstat=substitute(prevline, '!.*$', '', '')

  "Indent do loops only if they are all guaranteed to be of do/end do type
    if prevstat =~? '^\s*do\s\w*=\w*,\w*'
      let ind = ind + &sw
    endif
    if getline(v:lnum) =~? '^\s*end\s*do'
      let ind = ind - &sw
    endif

  "Add a shiftwidth to statements following if, else, case,
  "where and elsewhere statements
  if prevstat =~? '^\s*select\s*case(\w*)'
     let ind = ind + 2*&sw
  endif
  if prevstat =~? '^\s*\(case\|\(else\)\=if\S*\s*then\|else\|\(else\)\=where(\S*)\)'
     let ind = ind + &sw
  endif
  if getline(v:lnum) =~? '^\s*\(case\|else\|endif\|end\s*\(if\|where\)\)'
     let ind = ind - &sw
  endif
  if getline(v:lnum) =~? '^\s*end\s*select'
     let ind = ind - 2*&sw
  endif
  return ind
endfunction

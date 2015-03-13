
" Vim indent file
" Language:     shell script (free source form)
" Description:  Indentation rules for continued statements and preprocessor
"               instructions
"               Indentation rules for function statements
" Installation: Place this script in the $HOME/.vim/after/indent/ directory
" Maintainer:   Lin Sujie
" License:      Public domain
" Last Change:  2013 Apr 25

	setlocal indentexpr=ShellIndent()
	setlocal indentkeys+==~},=~esac,=~fi,=~done,=~else,=~elif
	if exists("*ShellIndent")
	  finish
        endif

" ShellIndent()deal with the indent of shell script
function ShellIndent()
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
	let ind = indent(lnum)
	let longline = getline(lnum)
	let line = substitute(longline,'#.*$','','')
	"Indent do/done {/} and if/fi
    if line =~? '^\s*\(do$\|[{]\|\(el\)\=if\s.*then$\|else$\)'
      let ind = ind + &sw
    endif
    if line =~? '^\s*\(el\)\=if.*\#.*then'
      let ind = ind +&sw
    endif
    if getline(v:lnum) =~? '^\s*\(done\|\}\|fi\|else\|elif\)'
      let ind = ind - &sw
    endif
	"Indent case
	if line=~? '^\s*\(.*)\|case.*in\)'
	  let ind = ind + &sw
	endif
	if line=~? '^\s*.*;;'
	  let ind = ind - &sw
	endif
	if getline(v:lnum) =~? 'esac'
	  let ind= ind - &sw
	endif
	return ind
endfunction

" SebuPrevNonBlankNonCPP(lnum) is modified prevnonblank(lnum):
" Returns the line number of the first line at or above 'lnum' that is
" neither blank nor preprocessor instruction.
function SebuPrevNonBlankNonCPP(lnum)
	let lnum = prevnonblank(a:lnum)
	while getline(lnum) =~ '^\s*#.*$'
		let lnum = prevnonblank(lnum-1)
	endwhile
	return lnum
endfunction

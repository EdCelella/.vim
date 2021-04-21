filetype plugin indent on

" Turns on syntax highlighting and shows line numbers.
syntax on
set relativenumber

" Spell checking.
function! SpellCheck()

	" Vim spell check options.
	setlocal spell
	set spelllang=en_gb

	" Maps command C-l to replace previous spelling mistake with option 1.
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
	
	" Does not spell check acronyms / abbreviations.
	syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

endfunction

" Function which escapes syntax highlighting between latex math environment patterns.
function! MathSyntax()
	
	" Block math - searches for for "$$ ... $$" or "\begin{ ... } ... \end{ ... }".
	syn region math_block start=/\$\$/ end=/\$\$/
	syn region math_env start=/\\begin{.*}/ end=/\\end{.*}/

	" Inline math - searches for "$ ... $".
	syn match math_inline '\$[^$].\{-}\$'

	" PLACEHOLDER UNTIL NESTED REGIONS WORKED OUT
	syn region cases start=/\\begin{cases}/ end=/\\end{cases}/ containedin=math_env

	" Highlights math environments.
	hi link math_block Function
	hi link math_env Function
	hi link cases Function
	hi link math_inline Statement

endfunction

" Calls 'MathSyntax' when a markdown file is opened.
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathSyntax()

" Calls 'SpellCheck' when a markdown, latex or text file is opened.
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown,*.tex,*.bib,*.txt call SpellCheck()

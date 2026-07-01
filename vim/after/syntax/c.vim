" Extra C highlighting layered on top of Vim's built-in c.vim.
" Color function names (Vim's default C syntax leaves them uncolored).

" An identifier immediately followed by '(' — matches calls and definitions.
syntax match cCustomFunc /\<\w\+\ze\s*(/
highlight def link cCustomFunc Function

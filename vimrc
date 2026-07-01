"====================== General ======================
syntax on                       " syntax highlighting
filetype plugin indent on       " filetype-aware plugins + indentation
set encoding=utf-8              " internal encoding
set fileencoding=utf-8         " encoding for written files
set hidden                      " allow switching buffers without saving
set autoread                    " reload files changed outside Vim
set confirm                     " prompt to save instead of failing on :q
set mouse=a                     " enable mouse in all modes

"====================== Appearance ======================
" Enable 24-bit color only when the terminal really supports it; otherwise
" fall back to 256-color mode (avoids grayscale in e.g. macOS Terminal.app).
if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
  set termguicolors
endif
set background=dark
" 'sorbet' ships with Vim 9.1+; fall back gracefully on older Vims.
if !empty(globpath(&runtimepath, 'colors/sorbet.vim'))
  colorscheme sorbet            " dark, vivid built-in scheme (Vim 9.1+)
else
  silent! colorscheme torte     " dark fallback for older Vim
endif
set guifont=Menlo:h14           " GUI font (MacVim/gVim only)
set number                      " line numbers
set ruler                       " cursor position in status line
set showcmd                     " show partial command as typed
set scrolloff=5                 " keep context lines above/below cursor
set sidescrolloff=5

"====================== Indentation (4-space) ======================
set expandtab                   " tabs -> spaces
set smarttab
set autoindent                  " carry indent to new lines
set cindent                     " C-aware indenting (supersedes smartindent)
set tabstop=4
set softtabstop=4
set shiftwidth=4

"====================== Search ======================
set incsearch                   " show matches while typing
set ignorecase                  " case-insensitive...
set smartcase                   " ...unless the pattern has a capital
set hlsearch                    " highlight all matches

"====================== Editing / History ======================
set backspace=indent,eol,start  " backspace over everything in insert mode
set history=1000                " command/search history size
set undolevels=1000             " in-session undo depth
set undofile                    " persist undo across sessions
set undodir=~/.vim/undodir

"====================== Command-line completion ======================
set wildmenu
set wildignorecase
set wildmode=longest:full,list:full

"====================== C: build & run ======================
" <F5> save + build with warnings (errors land in the quickfix list)
" <F6> run the compiled binary
autocmd FileType c setlocal makeprg=clang\ -g\ -Wall\ -Wextra\ -o\ %:r\ %
autocmd FileType c nnoremap <buffer> <F5> :w<CR>:make<CR>
autocmd FileType c nnoremap <buffer> <F6> :!./%:r<CR>

"====================== Autocommands ======================
" Restore last cursor position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

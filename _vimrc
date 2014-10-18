" Enable line numbers
set number

" Indention without hard tabs
set expandtab
set shiftwidth=2
set softtabstop=2

set showmatch           " Show matching brackets.
set incsearch           " Incremental search
set hlsearch            " highlight searched things

" ******************************************************************
" KEY MAPPINGS

" pressing < or > will let you indent/unindent selected lines
vnoremap < <gv
vnoremap > >gv

" Enable undo in insert mode
imap <c-z> <c-o>u

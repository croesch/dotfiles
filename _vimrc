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

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 15 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,15}"Last modified: \).*"#\1' .
          \ strftime('%F') . '"#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre *.man call LastModified()

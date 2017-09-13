execute pathogen#infect()

let mapleader = " "

syntax on
colorscheme candycode_modified

set statusline="STATUS"

" Enable line numbers
set number
set relativenumber

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

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " Mark empty lines to preserve them.
  %s/^\_s*$/<!-- FORMATTER: EMPTY LINE -->/g
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  1s/<?xml .*?>/<?xml version="1.0" encoding="UTF-8"?>/e
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " restore empty lines
  %s/^\_s*<!--\_s*FORMATTER:\_s*EMPTY\_s*LINE\_s*-->\_s*$//g
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

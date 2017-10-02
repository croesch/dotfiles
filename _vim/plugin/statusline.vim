scriptencoding utf-8

set statusline="STATUS"

" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
if has('statusline')
  set statusline=%#LineNr#
  set statusline+=%{statusline#lhs()}
  
  set statusline+=%*
  set statusline+=                                  " Powerline arrow.
  set statusline+=\                                  " Space.
  set statusline+=%<                                 " Truncation point, if not enough width available.
  set statusline+=%{statusline#fileprefix()} " Relative path to file's directory.
  set statusline+=%#StatusLineBold#
  set statusline+=%t                                 " Filename.
  set statusline+=%*
  set statusline+=\                                  " Space.

  " Needs to be all on one line:
  set statusline+=%([%R%{statusline#ft()}%{statusline#fenc()}]%)

  set statusline+=%=   " Split point for left and right groups.

  set statusline+=\               " Space.
  set statusline+=
  set statusline+=%#LineNr#
  set statusline+=%{statusline#rhs()}
  set statusline+=%*              " Reset highlight group.
endif

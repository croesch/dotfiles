set norelativenumber

function RebaseAction(action)
  execute "normal! ^cw" . a:action
  execute "normal! ^"
endfunction

function RebaseActionToggle()
  let line = getline(".")
  let result = matchstr(line, "^\\a")
  let transitions = {'p': 'squash', 's': 'edit', 'e': 'fixup', 'f': 'pick'}
  call RebaseAction(transitions[result])
endfunction

noremap <Cr> :call RebaseActionToggle()<Cr>
noremap p :call RebaseAction('pick')<Cr>
noremap e :call RebaseAction('edit')<Cr>
noremap s :call RebaseAction('squash')<Cr>
noremap f :call RebaseAction('fixup')<Cr>

" lightline-ale, a support plugin for connect lightline and ale
function! config#lightline_ale#hook_add() abort
  let g:airline_theme='oceanicnext'
  let g:lightline.component_expand = {
        \ 'linter_checking': 'lightline#ale#checking',
        \ 'linter_warnings': 'lightline#ale#warnings',
        \ 'linter_errors': 'lightline#ale#errors',
        \ 'linter_ok': 'lightline#ale#ok'
        \ }

  let g:lightline.component_type = {
        \ 'linter_checking': 'left',
        \ 'linter_warnings': 'warning',
        \ 'linter_errors': 'error',
        \ 'linter_ok': 'left'
        \ }
endfunction

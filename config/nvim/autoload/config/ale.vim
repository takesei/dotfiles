function! config#ale#hook_add() abort
    let g:ale_lint_on_enter = 1
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1

    let g:ale_sign_column_always = 1
    let g:ale_sign_infos = "\uf129"
    let g:ale_sign_warning = "\uf071"
    let g:ale_sign_error = "\uf05e"

    highlight clear ALEError
    highlight clear ALEWarning

    let g:ale_linters = {
    \   'c': ['clangd'],
    \   'cpp' : ['clangd'],
    \   'go': ['gofmt'],
    \   'python': ['flake8'],
    \}

    " Only Run Linter named above
    " let g:ale_linters_explicit = 1
endfunction

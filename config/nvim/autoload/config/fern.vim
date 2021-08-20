function! config#fern#hook_add() abort
    nnoremap <silent> <Space>v :<C-u>Fern . -drawer -width=35<CR>
endfunction

function! config#fern#hook_source() abort
    let g:fern#renderer = "nerdfont"
endfunction

function! config#fern#init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  " nnoremap <silent> <Space>v :<C-u>Fern . -drawer -width=35<CR>
  let g:fern#renderer = "nerdfont"
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
endfunction

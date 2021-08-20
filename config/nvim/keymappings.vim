" Map Leader
let mapleader = "\<Space>"

" General
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
nnorem ap <Leader><Leader> i<Space><Esc>

" Insert new line
nnoremap <silent> <Space>o   :<C-u>for i in range(1, v:count1)
  \\| call append(line('.'),   '')
  \\| endfor
  \\| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> <Space>O   :<C-u>for i in range(1, v:count1)
  \\| call append(line('.')-1, '')
  \\| endfor
  \\| silent! call repeat#set("<Space>O", v:count1)<CR>

" Terminal mode
tnoremap <silent> <ESC> <C-\><C-n>

" Denite
nnoremap [denite] <Nop>
nnoremap [coc] <Nop>
nnoremap [defx] <Nop>

map <Leader>u [denite]
map <Leader>c [coc]
" map <Leader>v [defx]

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer><expr> <S-Space>
    \ denite#do_map('toggle_select').'k'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

" mapping for ctags
nnoremap <C-]> g<C-]>

" Golang
autocmd FileType go nmap [vim-go] <Nop>
autocmd FileType go nmap <leader>g [vim-go]

autocmd FileType go nmap [vim-go]t <Plug>(go-test)

function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd FileType go nmap [vim-go]b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap [vim-go]c <Plug>(go-coverage-toggle)

" Python

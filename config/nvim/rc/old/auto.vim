" Quickfix Window Always to the bottom
autocmd FileType qf wincmd J

" Defx
autocmd FileType defx call config#defx#settings()

" terminal mode
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif

" Julia
autocmd BufRead,BufNewFile *.jl set filetype=julia


" for c++
augroup cpp
    autocmd!
    autocmd FileType cpp :highlight cppcoloncolon cterm=bold ctermfg=214
    autocmd FileType cpp :match cppcoloncolon /\:\:/
augroup END

augroup yaml
    autocmd!
    autocmd FileType yaml :setlocal tabstop=2
    autocmd FileType yaml :setlocal shiftwidth=2
augroup END

augroup json
    autocmd!
    autocmd FileType json :setlocal tabstop=2
    autocmd FileType json :setlocal shiftwidth=2
augroup END

augroup denite-windows
    autocmd!
    autocmd FileType denite set winblend=5
    autocmd FileType denite-filter set winblend=5
augroup END

augroup KeepLastPosition
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

if has('persistent_undo')
    set undodir=./.vimundo,~/.vimundo
    augroup SaveUndoFile
        autocmd!
        autocmd BufReadPre ~/* setlocal undofile
    augroup END
endif

if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif

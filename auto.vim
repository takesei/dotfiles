" Quickfix Window Always to the bottom
autocmd FileType qf wincmd J

" Golang
augroup go
  autocmd!
  autocmd FileType go match goErr /\<err\>/
augroup END

" Python
augroup python
    autocmd!
    autocmd FileType python :syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
    autocmd FileType python :syn match pythonDelimiter "\(,\|\.\|:\)"
    autocmd FileType python :syn keyword self self
    autocmd FileType python :hi link pythonOperator Statement
    autocmd FileType python :hi link pythonDelimiter Special
    autocmd FileType python :hi link self Type
    " autocmd FileType python :highlight self cterm=bold ctermfg=214
    " autocmd FileType python :match self /self/
    " autocmd FileType python :highlight colon cterm=bold ctermfg=214
    " autocmd FileType python :match colon /:/
augroup END

" for c++
augroup cpp
    autocmd!
    autocmd FileType cpp :highlight cppcoloncolon cterm=bold ctermfg=214
    autocmd FileType cpp :match cppcoloncolon /\:\:/
augroup END

augroup html
    autocmd!
    autocmd FileType html :setlocal tabstop=2
    autocmd FileType html :setlocal shiftwidth=2
augroup END

augroup javascript
    autocmd!
    autocmd FileType javascript :syn match Operator "\(|\|+\|=\|-\|\^\|\*\)"
    autocmd FileType javascript :syn match Delimiter "\(\.\|:\)"
    autocmd FileType javascript :hi link Operator Statement
    autocmd FileType javascript :hi link Delimiter Special
    autocmd FileType javascript :setlocal tabstop=2
    autocmd FileType javascript :setlocal shiftwidth=2
augroup END

augroup typescript
    autocmd!
    autocmd FileType typescript :syn match Operator "\(|\|+\|=\|-\|\^\|\*\)"
    autocmd FileType typescript :syn match Delimiter "\(\.\|:\)"
    autocmd FileType typescript :hi link Operator Statement
    autocmd FileType typescript :hi link Delimiter Special
    autocmd FileType typescript :setlocal tabstop=2
    autocmd FileType typescript :setlocal shiftwidth=2
augroup END

augroup typescriptreact
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
    autocmd FileType typescript.tsx :syn match Operator "\(|\|+\|=\|-\|\^\|\*\)"
    autocmd FileType typescript.tsx :syn match Delimiter "\(\.\|:\)"
    autocmd FileType typescript.tsx :hi link Operator Statement
    autocmd FileType typescript.tsx :hi link Delimiter Special
    autocmd FileType typescript.tsx :setlocal tabstop=2
    autocmd FileType typescript.tsx :setlocal shiftwidth=2
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

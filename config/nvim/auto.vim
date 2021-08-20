" Quickfix Window Always to the bottom
autocmd FileType qf wincmd J

" Defx
autocmd FileType defx call config#defx#settings()

" Ctags
" function! s:execute_ctags() abort
"   " 探すタグファイル名
"   let tag_name = '.tags'
"   " ディレクトリを遡り、タグファイルを探し、パス取得
"   let tags_path = findfile(tag_name, '.;')
"   " タグファイルパスが見つからなかった場合
"   if tags_path ==# ''
"     return
"   endif
" 
"   " タグファイルのディレクトリパスを取得
"   " `:p:h`の部分は、:h filename-modifiersで確認
"   let tags_dirpath = fnamemodify(tags_path, ':p:h')
"   " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
"   execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
" endfunction
" 
" augroup ctags
"   autocmd!
"   autocmd BufWritePost * call s:execute_ctags()
" augroup END

" augroup fern-custom
"   autocmd! *
"   autocmd FileType fern call config#fern#init_fern()
" augroup END

" Golang
" augroup go
"   autocmd!
"   autocmd FileType go match goErr /\<err\>/
" augroup END

" Python
" augroup python
"     autocmd!
"     autocmd FileType python :syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
"     autocmd FileType python :syn match pythonDelimiter "\(,\|\.\|:\)"
"     autocmd FileType python :syn keyword self self
"     autocmd FileType python :hi link pythonOperator Statement
"     autocmd FileType python :hi link pythonDelimiter Special
"     autocmd FileType python :hi link self Type
    " autocmd FileType python :highlight self cterm=bold ctermfg=214
    " autocmd FileType python :match self /self/
    " autocmd FileType python :highlight colon cterm=bold ctermfg=214
    " autocmd FileType python :match colon /:/
" augroup END

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

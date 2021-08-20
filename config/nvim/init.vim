" Set Python path
let g:pyton3_host_prog = '/usr/local/opt/python@3.9/bin/python3.9'

" Load dein.vim
source $XDG_CONFIG_HOME/nvim/dein.vim

" Colorscheme
source $XDG_CONFIG_HOME/nvim/color.vim

" Keymappkings
source $XDG_CONFIG_HOME/nvim/keymappings.vim

" Autogroup, Autocmd
source $XDG_CONFIG_HOME/nvim/auto.vim

" General
set number

set tabstop=4
set expandtab
set showtabline=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

set ambiwidth=double
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set hidden
set history=200
set virtualedit=block
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start
set wildmenu
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set showcmd
set cursorline
set visualbell
set laststatus=2
set wrapscan
set modeline
set autowrite
set display=lastline
set matchpairs& matchpairs+=<:>
set matchtime=1
set mouse=a
set updatetime=750
set clipboard=unnamed
set fileformats=unix,dos,mac
set modifiable
set verbosefile=$XDG_CACHE_HOME/temp/vim.log
set verbose=20

" Search
set showmatch
set smartcase
set ignorecase
set infercase
set hlsearch
set incsearch

" Folding
set foldmethod=marker
set foldlevel=0
set foldcolumn=1

" disable preview window
set completeopt-=preview

" terminal mode
autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
autocmd BufRead,BufNewFile *.jl set filetype=julia

if has('nvim')
  set pumblend=5
endif

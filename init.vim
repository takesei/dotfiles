filetype plugin indent off

" ENV VAR
let g:vim_home=$XDG_CONFIG_HOME."/nvim"
let g:rc_dir=$XDG_CONFIG_HOME."/nvim/rc"
let g:tex_flavor = "latex"
let g:webdevicons_enable_denite = 1

set nocompatible

" basic settings
set whichwrap=b,s,<,>,[,]
set number
set encoding=UTF-8
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set clipboard=unnamed
set hls
set ambiwidth=double
"set noswapfile
set hidden
set list
"set listchars=tab:>-,trail:\|
set smartindent
set visualbell
set backupdir=~/.config/nvim/tmp
set ignorecase
set smartcase
set wrapscan
set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set fileencodings=ucs-bombs,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac

" Custom Keybind
" Insert new line
nnoremap <silent> <Space>o   :<C-u>for i in range(1, v:count1)
  \\| call append(line('.'),   '')
  \\| endfor
  \\| silent! call repeat#set("<Space>o", v:count1)<CR>
nnoremap <silent> <Space>O   :<C-u>for i in range(1, v:count1)
  \\| call append(line('.')-1, '')
  \\| endfor
  \\| silent! call repeat#set("<Space>O", v:count1)<CR>

nnoremap <C-w>n <Esc>:enew<Return>

runtime! conf/*.vim
filetype plugin indent on

runtime! colorscheme.vim

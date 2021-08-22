" ---------- Dein Script ----------
if &compatible
  set nocompatible "be improved
endif

" Set cache & config dir
let s:dein_cache_dir = $XDG_CACHE_HOME . '/dein'
let s:dein_config_dir = $XDG_CONFIG_HOME . '/nvim/config'

" RuntimePath
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

" Auto Install
let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_cache_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_dir))
endif

" Load Packages
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml      = s:dein_config_dir . '/dein.toml'
  let s:toml_lazy = s:dein_config_dir . '/dein_lazy.toml'
  let s:toml_lang = s:dein_config_dir . '/dein_lang.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})
  call dein#load_toml(s:toml_lang, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
" ---------- End Dein Script ----------
" :call dein#recache_runtimepath()

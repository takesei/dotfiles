let $CACHE = '~/.cache'->expand()
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif

" Install plugin manager automatically.
for s:plugin in [
      \ 'Shougo/dein.vim',
      \ ]->filter({ _, val -> &runtimepath !~# '/' . val })
  " Search from current directory
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    " Search from $CACHE directory
    let s:dir = $CACHE . "/dein/repos/github.com/" . s:plugin
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/' . s:plugin s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endfor


"---------------------------------------------------------------------------
" dein configurations.

" In Windows, auto_recache is disabled.  It is too slow.
let g:dein#auto_recache = !has('win32')

let g:dein#auto_remote_plugins = v:false
let g:dein#enable_notification = v:true
let g:dein#install_check_diff = v:true
let g:dein#install_check_remote_threshold = 24 * 60 * 60
let g:dein#install_progress_type = 'floating'
let g:dein#lazy_rplugins = v:true
let g:dein#types#git#enable_partial_clone = v:true

let $BASE_DIR = '<sfile>'->expand()->fnamemodify(':h')

let s:path = $CACHE . '/dein'
if !dein#min#load_state(s:path)
  finish
endif

let g:dein#inline_vimrcs = [
      \ $BASE_DIR . '/options.rc.vim',
      \ $BASE_DIR . '/mappings.rc.vim',
      \ ]
if has('nvim')
  call add(g:dein#inline_vimrcs, $BASE_DIR . '/neovim.rc.vim')
" elseif has('gui_running')
"   call add(g:dein#inline_vimrcs, $BASE_DIR . '/gui.rc.vim')
" endif
" if has('win32')
"   call add(g:dein#inline_vimrcs, $BASE_DIR . '/windows.rc.vim')
" else
"   call add(g:dein#inline_vimrcs, $BASE_DIR . '/unix.rc.vim')
endif

call dein#begin(s:path, '<sfile>'->expand())

call dein#load_toml($BASE_DIR . '/toml/dein.toml', #{ lazy: 0 })
call dein#load_toml($BASE_DIR . '/toml/deinlazy.toml', #{ lazy: 1 })
call dein#load_toml($BASE_DIR . '/toml/ddc.toml', #{ lazy: 1 })
call dein#load_toml($BASE_DIR . '/toml/ddu.toml', #{ lazy: 1 })

if has('nvim')
  call dein#load_toml($BASE_DIR . '/toml/neovim.toml', #{ lazy : 1 })
else
  call dein#load_toml($BASE_DIR . '/toml/vim.toml', #{ lazy : 1 })
endif

call dein#end()
call dein#save_state()

" NOTE: filetype detection is needed
if '%'->bufname() !=# ''
  silent filetype detect
endif
" ---------- Dein Script ----------
" " Set cache & config dir
" let s:dein_cache_dir = $XDG_CACHE_HOME . '/dein'
" let s:dein_config_dir = $XDG_CONFIG_HOME . '/nvim/config'
" 
" " RuntimePath
" set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim
" 
" " Auto Install
" let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
" if !isdirectory(s:dein_cache_dir)
"   call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_dir))
" endif
" 
" " Load Packages
" if dein#load_state(s:dein_cache_dir)
"   call dein#begin(s:dein_cache_dir)
" 
"   let s:toml      = s:dein_config_dir . '/dein.toml'
"   let s:toml_lazy = s:dein_config_dir . '/dein_lazy.toml'
"   let s:toml_lang = s:dein_config_dir . '/dein_lang.toml'
" 
"   call dein#load_toml(s:toml,      {'lazy': 0})
"   call dein#load_toml(s:toml_lazy, {'lazy': 1})
"   call dein#load_toml(s:toml_lang, {'lazy': 1})
" 
"   call dein#end()
"   call dein#save_state()
" endif
" 
" filetype plugin indent on
" syntax enable
" 
" if dein#check_install()
"   call dein#install()
" endif
" " ---------- End Dein Script ----------
" " :call dein#recache_runtimepath()

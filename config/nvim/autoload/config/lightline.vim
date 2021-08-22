function! config#lightline#hook_add() abort
    set noshowmode

    let g:lightline = {}
    let g:lightline.colorscheme = 'jellybeans'
    let g:lightline.active = {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'readonly', 'filename', 'modified'],
    \   ],
    \   'right': [
    \       ['ale_checking', 'ale_errors', 'ale_warnings', 'ale_infos', 'ale_ok'],
    \       ['lineinfo'],
    \       ['percent'],
    \       ['cocstatus', 'currentfunction'],
    \       ['fileformat', 'fileencoding', 'devicon', 'filetype'],
    \   ]
    \}

    let g:lightline.tabline = {
    \   'left': [ [ 'tabs' ] ],
    \   'right': [ [ 'battery', 'time' ] ]
    \}

    let g:lightline.component = {
    \   'gitbranch': 'GITDUMMY',
    \   'battery': 'BATTERYY',
    \   'cocstatus': 'COCDUMMY',
    \   'currentfunction': 'COCFUNCDUMMY',
    \}

    let g:lightline.component_function = {
    \   'time': 'LightLineTime',
    \   'devicon': 'GetDevicon',
    \}

    let g:lightline.component_expand = {
    \   'ale_checking': 'lightline#ale#checking',
    \   'ale_infos': 'lightline#ale#infos',
    \   'ale_warnings': 'lightline#ale#warnings',
    \   'ale_errors': 'lightline#ale#errors',
    \   'ale_ok': 'lightline#ale#ok',
    \}

    let g:lightline.component_type = {
    \   'ale_checking': 'right',
    \   'ale_infos': 'right',
    \   'ale_warnings': 'warning',
    \   'ale_errors': 'error',
    \   'ale_ok': 'right'
    \}
  
    function! CocCurrentFunction()
      return get(b:, 'coc_current_function', '')
    endfunction

    function! GetDevicon()
        return nerdfont#find()
    endfunction
  
    augroup LightLineOnALE
      autocmd!
      autocmd User ALELint call lightline#update()
    augroup END

    function! LightLineTime()
      return system('date +"%D %H:%M"')[:-2]
    endfunction

    function! LightLineBattery()
      let battery = str2nr(system("battery"), 10)
      let batteryIcon = battery >= 80 ? ' ' :
            \ battery >= 60 ? ' ' :
            \ battery >= 40 ? ' ' :
            \ battery >= 20 ? ' ' :
            \ battery >= 0  ? ' ' : ''
      return printf('%d%% %s', battery, batteryIcon)
    endfunction
endfunction


function! config#lightline#ale_hook_add() abort
    let g:lightline#ale#indicator_checking = "\uf110 "
    let g:lightline#ale#indicator_infos = "\uf129 "
    let g:lightline#ale#indicator_warnings = "\uf071 "
    let g:lightline#ale#indicator_errors = "\uf05e "
    let g:lightline#ale#indicator_ok = "\uf00c "
endfunction

function! config#lightline#hook_add() abort
    set noshowmode

    "let g:webdevicons_enable_airline_statusline = 1
    "let g:webdevicons_enable_airline_tabline = 1

    let g:lightline = {}
    let g:lightline.colorscheme = 'jellybeans'
    let g:lightline.active = {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['gitbranch', 'readonly', 'filename', 'modified'],
    \   ],
    \   'right': [
    \       ['lineinfo'],
    \       ['percent', 'ale'],
    \       ['cocstatus', 'currentfunction'],
    \       ['fileformat', 'fileencoding', 'filetype'],
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
    \   'currentfunction': 'COCFUNCDUMMY'
    \}

    let g:lightline.component_function = {
    \   'time': 'LightLineTime',
    \}
  
    function! CocCurrentFunction()
      return get(b:, 'coc_current_function', '')
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

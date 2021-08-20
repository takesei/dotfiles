function! config#lightline#hook_add() abort
  let g:webdevicons_enable_airline_statusline = 1
  let g:webdevicons_enable_airline_tabline = 1

  let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'active': {
        \   'left':  [['mode', 'paste'],
        \             ['gitbranch', 'readonly', 'filename', 'modified']],
        \   'right': [['lineinfo'], ['percent', 'ale'], ['fileformat', 'fileencoding', 'filetype'],
        \              ['cocstatus', 'currentfunction'] ]
        \   }
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'battery', 'time' ] ]
        \ }

  let g:lightline.component_function = {
        \   'time': 'LightLineTime',
        \   'battery': 'LightLineBattery',
        \   'cocstatus': 'coc#status',
        \   'currentfunction': 'CocCurrentFunction',
        \   'gitbranch': 'gitbranch#name'
        \ }

  let g:lightline.separator = {
        \   'left': "\ue0b0", 'right': "\ue0b2"
        \ }

  let g:lightline.subseparator = {
        \ 'left': "\ue0b1", 'right': "\ue0b3"
        \ }


  function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
  endfunction

  augroup LightLineOnALE
    autocmd!
    autocmd User ALELint call lightline#update()
  augroup END

  function! LightLineTime()
    return system('date +"%H:%M"')[:-2]
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

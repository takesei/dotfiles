function! config#denite#hook_add() abort
    " defined in keymappings.vim
    " Prefix for denite
    " nmap [denite] <Nop>
    " map <Space>u [denite]

    " key mappings for Denite and sources
    nnoremap <silent> [denite]y :<C-u>Denite neoyank <CR>
    nnoremap <silent> [denite]u :<C-u>Denite buffer file/rec <CR>
    nnoremap <silent> [denite]f :<C-u>Denite file/rec <CR>
    nnoremap <silent> [denite]b :<C-u>Denite buffer <CR>
    nnoremap <silent> [denite]m :<C-u>Denite file_mru <CR>
    nnoremap <silent> [denite]a :<C-u>Denite -resume <CR>

    " settings for grep
    nnoremap <silent> [denite]g :<C-u>
    \ Denite grep <CR>
    nnoremap <silent> [denite]r :<C-u>
    \ Denite -resume <CR>
endfunction

function! config#denite#hook_source() abort
    " Change the prompt
    let s:denite_win_width_percent = 0.85
    let s:denite_win_height_percent = 0.7


    call denite#custom#option('default', {
    \   'prompt': '>',
    \   'split': 'floating',
    \   'buffer-name': 'searach-buffer-denite',
    \   'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \   'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \   'winheight': float2nr(&lines * s:denite_win_height_percent),
    \   'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })
endfunction

function! config#denite#hook_post_source() abort
    " Add action keybinds
    call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
    call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>')
    call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>')
    call denite#custom#map('normal', '<C-s>', '<denite:do_action:split>')

    call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
    call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
    call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')

    " Variables
    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endfunction

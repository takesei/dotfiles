---------------------------------------------------------------------------
-- honyamorake's .vimrc
-- ref: https://github.com/Shougo/shougo-s-github/
---------------------------------------------------------------------------

-- local g = vim.g -- Global Variables
local opt = vim.opt -- Options
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Set augroup.
augroup('UserACmd', {clear=true})

-- Minimal options
opt.shortmess='aTIcFoOsSW'
opt.showtabline=0
opt.laststatus=0
opt.ruler = false
opt.showcmd = false
opt.showmode = false

-- Height of the command line.
opt.cmdheight = 0

-- For recording messages
autocmd({'CmdlineEnter', 'RecordingEnter'}, {
    pattern = '*',
    group = 'UserACmd',
    callback = function() opt.cmdheight = 1 end
})
autocmd({'CmdlineLeave', 'RecordingLeave'}, {
    pattern = '*',
    group = 'UserACmd',
    callback = function() opt.cmdheight = 0 end
})

-- Show title.
opt.title = true
opt.titlelen = 95

-- Title string.
vim.opt.titlestring = "%{'%:p:~:.'->expand()}%<\\(%{getcwd()->fnamemodify(':~')}\\)%(%y%m%r%)"

-- Use cursor shape feature
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'


-- Use English interface.
vim.api.nvim_exec('language en_US.UTF-8', true)

-- Load Config
require('core/secret')
require('core/autoload')
require('core/mapping')
require('core/options')

-- Load Plugins
require('core/plugins')

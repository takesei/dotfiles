---------------------------------------------------------------------------
local g = vim.g     -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

---------------------------------------------------------------------------
-- Base:
-- Build encodings.
opt.fileencodings = 'ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932'

if vim.fn.has('multi_byte_ime') then
  opt.iminsert = 0
  opt.imsearch = 0
end

opt.packpath = ''

---------------------------------------------------------------------------
-- Search:
-- Ignore the case of normal letters.
opt.ignorecase = true

-- If the search pattern contains upper case characters, override ignorecaseoption.
opt.smartcase = true

-- Enable incremental search.
opt.incsearch = true

-- Don't highlight search result.
opt.hlsearch = false

-- Searches wrap around the end of the file.
opt.wrapscan = true

-----------------------------------------------------------------------------
-- Edit:

-- Smart insert tab setting.
opt.smarttab = true
-- Exchange tab to spaces.
opt.expandtab = true
-- Substitute <Tab> with blanks.
opt.tabstop = 2
-- Spaces instead <Tab>.
opt.softtabstop = 2
-- Autoindent width.
opt.shiftwidth = 2
-- Round indent by shiftwidth.
opt.shiftround = true

-- Enable smart indent.
opt.autoindent = true

-- Disable modeline.
opt.modelines = 2
opt.modeline = false

-- Enable backspace delete indent and newline.
opt.backspace = 'indent,eol,nostop'

-- Highlight <>.
opt.matchpairs:append '<:>'

-- Display another buffer when current buffer isn't saved.
opt.hidden = true

-- Disable folding.
opt.foldenable = false
opt.foldmethod = 'manual'
-- Show folding level.
opt.foldcolumn = 'auto:1'
opt.fillchars = "vert:|,eob:a"
opt.commentstring = '%s'

-- Keymapping timeout.
opt.timeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 100

-- CursorHold time.
opt.updatetime = 1000

-- Set swap directory.
opt.directory:remove "."

-- Set undofile.
opt.undofile = true
g.undodir = opt.directory:get()

-- Enable virtualedit in visual block mode.
opt.virtualedit = 'block'

-- Set keyword help.
opt.keywordprg = ':help'

-- If true Vim master, use English help file.
opt.spelllang:append 'cjk'
opt.spelloptions:append 'camel'

-- Default fileformat.
opt.fileformat = 'unix'
-- Automatic recognition of a new line cord.
opt.fileformats = 'unix,dos,mac'

-- Disable editorconfig
g.editorconfig = false

-- Copy/paste to system clipboard
opt.clipboard = 'unnamedplus'

-- Enable mouse support
opt.mouse = 'a'

-----------------------------------------------------------------------------
-- View:
-- Show <TAB> and <CR>
opt.list = true
opt.listchars = [[tab:▸\ ,trail:-,precedes:«,nbsp:%]]

-- Disable statusline when command line
--autocmd MyAutoCmd CmdlineEnter * opt.laststatus=0 | redrawstatus
--autocmd MyAutoCmd CmdlineLeave * opt.laststatus=2

-- Does not report lines
opt.report = 1000

-- NOTE: wrap option is very slow!
opt.wrap = false

-- Turn down a long line appointed in 'breakat'
opt.linebreak = true
opt.showbreak = [[\]]
opt.breakat = [[\ \	;:,!?]]

-- Wrap conditions.
opt.whichwrap:append 'h,l,<,>,[,],b,s,~'
opt.breakindent = true

-- Don't create backup.
opt.writebackup = false
opt.backup = false
opt.swapfile = false
opt.backupdir:remove '.'

-- Disable bell.
opt.visualbell = false
opt.belloff = 'all'

-- Display candidates by popup menu.
opt.wildmenu = true
opt.wildmode = 'full'

-- Display all the information of the tag by the supplement of the Insert mode.
opt.showfulltag = true

-- Can supplement a tag in a command-line.
opt.wildoptions:append 'tagfile'

-- Complete all candidates
opt.wildignorecase = true

-- Increase history amount.
opt.history = 1000

-- Disable menu
g.did_install_default_menus = true

-- Completion setting.
opt.completeopt = 'menuone'

-- Don't complete from other buffer.
opt.complete = '.'
-- Set popup menu max height.
opt.pumheight = 5
-- Set popup menu min width.
opt.pumwidth = 0
-- Use "/" for path completion
opt.completeslash = 'slash'

-- Maintain a current line at the time of movement as much as possible.
opt.startofline = false

-- Splitting a window will put the new window below the current one.
opt.splitbelow = true
-- Splitting a window will put the new window right the current one.
opt.splitright = true
-- Set minimal width for current window.
opt.winwidth = 30
-- Set minimal height for current window.
opt.winheight = 1
-- Set maximam maximam command line window.
opt.cmdwinheight = 5
-- No equal window size.
opt.equalalways = false

-- Adjust window size of preview and help.
opt.previewheight = 8
opt.helpheight = 12

opt.ttyfast = true

-- When a line is long, do not omit it in @.
opt.display = 'lastline'
-- Display an invisible letter with hex format.
opt.display:append 'uhex'

-- For conceal.
opt.conceallevel = 2

-- Disable signcolumn
opt.signcolumn = 'yes'
opt.redrawtime = 0

-- Disable builtin message pager
opt.more = false
opt.inccommand = 'nosplit'

opt.pumblend = 20
opt.winblend = 20

-----------------------------------------------------------------------------
-- For UNIX:
-- Use sh.  It is faster
opt.shell = "sh"

-----------------------------------------------------------------------------
-- For CUI:
--

if not vim.fn.has('gui_running') then
  -- Enable 256 color terminal.
  opt.t_Co = 256

  -- Enable the mouse.
  opt.mouse = 'a'
end

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

---------------------------------------------------------------------------
-- Key-mappings:
---------------------------------------------------------------------------

local map = vim.keymap.set
local util = require("core.util")

-- Use ',' instead of '\'.
-- Use <Leader> in global plugin.
vim.g.mapleader = ","

-- Use <LocalLeader> in filetype plugin.
vim.g.maplocalleader = "m"

-- Release keymappings for plug-in.
map("n", ";", "<Nop>")
map("n", "m", "<Nop>")

map("n", ",", ";")

-- Visual mode keymappings:
-- Indent
map("n", ">", ">>")
map("n", "<", "<<")
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Enable undo <C-w> and <C-u>.
map("i", "<C-w>", "<C-g>u<C-w>")
map("i", "<C-u>", "<C-g>u<C-u>")
map("i", "<C-k>", "<C-o>D")

-- Command-line mode keymappings:
-- <C-a>, A: move to head.
map("c", "<C-a>", "<Home>")
-- <C-b>: previous char.
map("c", "<C-b>", "<Left>")
-- <C-d>: delete char.
map("c", "<C-d>", "<Del>")
-- <C-f>: next char.
map("c", "<C-f>", "<Right>")
-- <C-n>: next history.
map("c", "<C-n>", "<Down>")
-- <C-p>: previous history.
map("c", "<C-p>", "<Up>")
-- <C-g>: Exit.
map("c", "<C-g>", "<C-c>")
-- <C-k>: Delete to the end.
map("c", "<C-k>", '<Cmd> call setcmdline getcmdpos() == 1 ? "" : getcmdline():sub(1, getcmdpos() - 1)<CR>')

-- [Space]: Other useful commands
-- Smart space mapping.
map("n", "<Space>", "[Space]", { remap = true })
map("n", "[Space]", "<Nop>")

-- Set autoread.
map("n", "[Space]ar", function()
	util.ToggleOption("autoread")
end)
-- Set spell check.
map("n", "[Space]p", function()
	util.ToggleOption("spell")
end)
map("n", "[Space]w", function()
	util.ToggleOption("wrap")
end)
map("n", "[Space]c", function()
	if vim.opt.conceallevel:get() == 0 then
		vim.opt_local.conceallevel = 3
	else
		vim.opt_local.conceallevel = 0
	end
	vim.notify(tostring(vim.opt_local.conceallevel:get()))
end)

map("n", "[Space]h", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local is_enabled = vim.lsp.inlay_hint.is_enabled({ buf = bufnr })
	vim.lsp.inlay_hint.enable(not is_enabled, { buf = bufnr })
end)

-- Easily edit current buffer
map("n", "[Space]e", function()
	return vim.fn.expand("%") ~= "" and "<Cmd>edit %<CR>" or ""
end, { expr = true })

-- Add Blank line
map("n", "[Space]o", '<Cmd> call append(line("."), "")<CR>')
map("n", "[Space]O", '<Cmd> call append(line(".")-1, "")<CR>')

-- Useful save mappings.
map("n", "<Leader><Leader>", "<Cmd>silent update<CR>")

-- s: Windows and buffers(High priority)
-- The prefix key.
map("n", "s", "<Nop>")
map("n", "sp", function()
	vim.cmd("vsplit")
	vim.cmd("wincmd w")
end)
map("n", "so", function()
	vim.cmd("only")
end)
map("n", "<Tab>", function()
	vim.cmd("wincmd w")
end)

map("n", "q", function()
	if vim.opt_local.filetype:get() ~= "qf" then
		vim.api.nvim_command("cclose")
		vim.api.nvim_command("lclose")
	elseif vim.fn.getbufvar(vim.fn.winbufnr(vim.fn.winnr("#")), "&filetype") ~= "qf" and vim.fn.winnr("$") > 1 then
		vim.api.nvim_command("close")
	end
end)

-- Original search
map("n", "s/", "/")
map("n", "s?", "?")

-- Better x
map("n", "x", '"_x')

-- Disable Ex-mode.
map("n", "Q", "q")

-- Useless command.
map("n", "M", "m")

-- Smart <C-f>, <C-b>.
map("n", "<C-f>", function()
	return math.max(vim.fn.winheight(0) - 2, 1) .. "<C-d>" .. (vim.fn.line("w$") >= vim.fn.line("$") and "L" or "M")
end, { expr = true })
map("n", "<C-b>", function()
	return math.max(vim.fn.winheight(0) - 2, 1) .. "<C-u>" .. (vim.fn.line("w0") <= 1 and "H" or "M")
end, { expr = true })

-- Disable ZZ.
map("n", "ZZ", "<Nop>")

-- Select rectangle.
map("x", "r", "<C-v>")

-- Redraw.
map("n", "<C-l>", "<Cmd>redraw!<CR>")

-- If press l on fold, fold open.
map("n", "l", function()
	return vim.fn.foldclosed(vim.fn.line(".")) ~= -1 and "zo0" or "l"
end, { expr = true })
-- If press l on fold, range fold open.
map("x", "l", function()
	return vim.fn.foldclosed(vim.fn.line(".")) ~= -1 and "zogv0" or "l"
end, { expr = true })

-- Substitute.
map("x", "s", [[:s//g<Left><Left>]])

map("n", "#", "<C-^>")

-- NOTE: Do not overwrite <ESC> behavior
map("t", "jj", "<C-\\><C-n>")
map("t", "j<Space>", "j")
map("t", "<C-y>", "<C-r>+")

-- {visual}p to put without yank to unnamed register
map("x", "p", "P")

-- Tag jump
map("n", "tt", "g<C-]>")

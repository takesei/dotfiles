---------------------------------------------------------------------------
-- autoload functions
---------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Set augroup.
local user_agugroup = augroup("UserACmd", { clear = true })

-- For recording messages
autocmd({ "CmdlineEnter", "RecordingEnter" }, {
	group = user_agugroup,
	callback = function()
		if vim.opt.cmdheight:get() == 0 then
			vim.opt.cmdheight = 1
		end
	end,
})
autocmd({ "CmdlineLeave", "RecordingLeave" }, {
	group = user_agugroup,
	callback = function()
		if vim.opt.cmdheight:get() == 1 then
			vim.opt.cmdheight = 0
		end
	end,
})

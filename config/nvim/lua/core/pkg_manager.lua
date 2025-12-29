-- Package Manager
local cache_path = vim.env.XDG_CACHE_HOME .. "/lazy"
local lazy_path = cache_path .. "/lazy.nvim"
local lazy_repo = "https://github.com/folke/lazy.nvim.git"

-- bootstrap
if not vim.uv.fs_stat(lazy_path) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazy_repo,
		lazy_path,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazy_path)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.api.nvim_echo({
		{ "Package Manager `Lazy` failed to start", "ErrorMsg" },
	}, true, {})
	return
end

lazy.setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = true },
})

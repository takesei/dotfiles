local M = {}

function M.GetGitRoot()
	local dot_git_path = vim.fn.finddir(".git", ".;" .. vim.loop.os_homedir())
	return vim.fn.fnamemodify(dot_git_path, ":h")
end

function M.ToggleOption(option_name)
	if option_name == "laststatus" then
		if vim.opt_local.laststatus:get() == 0 then
			vim.opt_local.laststatus = 2
		else
			vim.opt_local.laststatus = 0
		end
	else
		-- vim.opt_local[option_name] = (1 - vim.opt[option_name]:get())
		vim.opt_local[option_name] = not vim.opt_local[option_name]:get()
	end

	vim.notify(option_name .. ": " .. tostring(vim.opt_local[option_name]:get()), "info", { timeout = 10 })
end

return M

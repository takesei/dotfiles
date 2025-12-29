return {
	-- Colorschema
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		lazy = false,
		priority = 800,
		config = function()
			require("notify").setup({
				render = "compact",
				timeout = 1000,
			})
			vim.notify = require("notify")
		end,
	},
	-- Dial
	{
		"monaqa/dial.nvim",
		-- lazy-load on keys
		-- mode is `n` by default. For more advanced options, check the section on key mappings
		keys = {
			{
				"<C-a>",
				function()
					require("dial.map").manipulate("increment", "normal", "default")
				end,
			},
			{
				"<C-x>",
				function()
					require("dial.map").manipulate("decrement", "normal", "default")
				end,
				mode = "n",
			},
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
					augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
					augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
					augend.constant.alias.bool, -- boolean value (true <-> false)
				},
			})
		end,
	},
}

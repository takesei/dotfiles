local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",

		-- snippets
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"rafamadriz/friendly-snippets",
		"stevearc/vim-vscode-snippets",

		-- builtin
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		-- git emoji
		"Dynge/gitmoji.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local map = cmp.mapping

		local opts = {
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				end,
			},
			window = {
				documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
					max_width = 60,
					max_height = 15,
				}),
			},
			mapping = map.preset.insert({
				["<C-p>"] = map.select_prev_item(),
				["<C-n>"] = map.select_next_item(),
				["<C-l>"] = map.complete(),
				["<C-e>"] = map.abort(),
				["<CR>"] = map.confirm({ select = true }),
				["<Tab>"] = map(function(fallback)
					if vim.fn["vsnip#jumpable"](1) == 1 then
						feedkey("<Plug>(vsnip-jump-next)", "")
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = map(function(fallback)
					if vim.fn["vsnip#jumpable"](-1) == 1 then
						feedkey("<Plug>(vsnip-jump-prev)", "")
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "gitmoji" },
			},
		}
		cmp.setup(opts)
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}

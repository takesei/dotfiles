return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "double",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.set_log_level("info")
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				callback = function()
					vim.lsp.buf.format({ timeout_ms = 2000 })
				end,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf
					if client and client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { buf = bufnr })
					end
				end,
			})

			local capabilities = vim.tbl_extend("error", require("cmp_nvim_lsp").default_capabilities(), {
				semanticTokens = {
					multilineTokenSupport = true,
				},
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("ruff", {
				root_markers = { ".git", "pyproject.toml" },
			})

			vim.lsp.config("pyright", {
				root_markers = { ".git", "pyproject.toml" },
			})

			vim.lsp.config("rust_analyzer", {
				enabled = false,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_enable = true,
			ensure_installed = { "lua_ls", "rust_analyzer", "ruff", "taplo", "marksman", "pyright" },
		},
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufRead", "BufNewFile" },
		keys = {
			{ "gk", vim.lsp.buf.hover, "n" },
			{ "gd", vim.lsp.buf.definition, "n" },
			{ "gf", vim.lsp.buf.format, "n" },
			{ "gr", vim.lsp.buf.references, "n" },
			{ "gn", vim.lsp.buf.rename, "n" },
			{ "ga", vim.lsp.buf.code_action, "n" },
			{ "g]", vim.diagnostic.goto_next, "n" },
			{ "g[", vim.diagnostic.goto_prev, "n" },
			{ "<C-e>", vim.lsp.buf.signature_help, "i" },
		},
	},
}

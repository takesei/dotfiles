return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							enable = true,
						},
						typeHints = {
							enable = true,
						},
						parameterHints = {
							enable = true,
						},
					},
				},
			},
			dap = {
				adapters = {
					{
						type = "executable",
						name = "lldb",
						command = "rust-debug-adapter",
					},
				},
			},
		}
	end,
}

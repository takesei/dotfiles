return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup { border = 'double', ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
      }
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      'hrsh7th/cmp-nvim-lsp',
    },
    lazy = true,
    event = 'BufRead',
    keys = {
      { 'K',        function() vim.lsp.buf.hover() end,         'n' },
      { 'gd',       function() vim.lsp.buf.definition() end,    'n' },
      { 'gf',       function() vim.lsp.buf.format() end,        'n' },
      { 'gr',       function() vim.lsp.buf.references() end,    'n' },
      { 'gn',       function() vim.lsp.buf.rename() end,        'n' },
      { 'ga',       function() vim.lsp.buf.code_action() end,   'n' },
      { '[Space]`', function() vim.diagnostic.open_float() end, 'n' },
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          vim.lsp.buf.format()
        end
      })

      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", 'ruff_lsp', 'taplo', 'marksman' },
        automatic_installation = true,
        handlers = {
          function(server)
            require('lspconfig')[server].setup {
              capabilities = require('cmp_nvim_lsp').default_capabilities()
            }
          end,

          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup {
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } }
                }
              }
            }
          end,
        }
      }
    end
  }
}

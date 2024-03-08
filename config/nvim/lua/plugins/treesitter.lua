-----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter


return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    -- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
    require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", 'python', 'rust', 'yaml', 'toml', 'go', 'csv', 'tsv', 'json'},
      auto_install = true,
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
      },
    }
  end
}

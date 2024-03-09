return {
  -- Colorschema
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "dracula"
    end
  },

  -- Notify
  {
    'rcarriga/nvim-notify',
    lazy = false,
    priority = 800,
    config = function()
      require("notify").setup {
        render = "compact",
        timeout = 1000,
      }
      vim.notify = require("notify")
    end
  },
}

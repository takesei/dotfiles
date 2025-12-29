return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('gitsigns').setup{}
  end
}


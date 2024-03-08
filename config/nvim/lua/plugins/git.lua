return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = "BufRead",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    require('gitsigns').setup{}
  end
}


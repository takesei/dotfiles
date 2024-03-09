return {
  -- Auto paerntheses close
  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require('autoclose').setup {}
    end
  },

  -- Folding
  {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup()
    end
  },
  {
    "anuvyklack/fold-preview.nvim",
    requires = { 'anuvyklack/keymap-amend.nvim' },
    lazy = true,
    evnet = "BufRead",
    config = function()
      require("fold-preview").setup {}
    end

  }
}

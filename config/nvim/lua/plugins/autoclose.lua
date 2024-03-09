return {
  "m4xshen/autoclose.nvim",
  lazy = true,
  event = "InsertEnter",
  config = function()
    require('autoclose').setup {}
  end
}

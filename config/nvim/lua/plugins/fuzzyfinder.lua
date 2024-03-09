return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<Leader>f", function() require('telescope.builtin').find_files() end, 'n' },
    { "<Leader>b", function() require('telescope.builtin').buffers() end,    'n' },
    { "<Leader>h", function() require('telescope.builtin').help_tags() end,  'n' },
    { "<Leader>g", function() require('telescope.builtin').live_grep() end,  'n' },
  },
}

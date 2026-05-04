return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<Leader>b",    function() require('telescope.builtin').buffers() end,     mode = 'n' },
    { "<Leader>h",    function() require('telescope.builtin').help_tags() end,   mode = 'n' },
    { "<Leader>g",    function() require('telescope.builtin').live_grep() end,   mode = 'n' },
    { "<Leader>r",    function() require('telescope.builtin').resume() end,      mode = 'n' },
    { "[Space]<tab>", function() require('telescope.builtin').find_files() end,  mode = 'n' },
    { "[Space]`",     function() require('telescope.builtin').diagnostics() end, mode = 'n' },
  },
}

local fold_config = {
  sections = {
    left = {
      'content',
    },
    right = {
      ' ', 'number_of_folded_lines', ': ', 'percentage', ' ',
      function(config) return config.fill_char:rep(3) end
    }
  },
  fill_char = '•',

  remove_fold_markers = true,
  keep_indentation = true,

  -- Possible values:
  -- "delete" : Delete all comment signs from the fold string.
  -- "spaces" : Replace all comment signs with equal number of spaces.
  -- false    : Do nothing with comment signs.
  process_comment_signs = 'spaces',

  -- Comment signs additional to the value of `&commentstring` option.
  comment_signs = {},

  -- List of patterns that will be removed from content foldtext section.
  stop_words = {
    '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
  },

  add_close_pattern = true, -- true, 'last_line' or false

  matchup_patterns = {
    { '{',  '}' },
    { '%(', ')' }, -- % to escape lua pattern char
    { '%[', ']' }, -- % to escape lua pattern char
  },

  ft_ignore = { 'neorg' },
}

return {
  -- Auto paerntheses close
  {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require('autoclose').setup {
        keys = {
          ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { 'rust' } },
        },
        options = {
          disable_when_touch = true,
          pair_spaces = true
        }
      }
    end
  },

  -- Folding
  {
    'anuvyklack/pretty-fold.nvim',
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    config = function()
      require('pretty-fold').setup(fold_config)
    end
  },
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = { 'anuvyklack/keymap-amend.nvim' },
    lazy = true,
    event = { "BufRead", "BufNewFile" },
    config = function()
      local fp = require('fold-preview')
      local map = require('fold-preview').mapping
      local keymap = vim.keymap
      keymap.amend = require('keymap-amend')
      fp.setup({
        default_keybindings = false
      })
      keymap.amend('n', 'K', function(original)
        if not fp.toggle_preview() then original() end
      end)
      keymap.amend('n', 'h', map.close_preview_open_fold)
      keymap.amend('n', 'l', map.close_preview_open_fold)
      keymap.amend('n', 'zo', map.close_preview)
      keymap.amend('n', 'zO', map.close_preview)
      keymap.amend('n', 'zc', map.close_preview_without_defer)
      keymap.amend('n', 'zR', map.close_preview)
      keymap.amend('n', 'zM', map.close_preview_without_defer)
    end

  }
}

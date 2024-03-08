-----------------------------------------------------------
-- Dial.map configuration file
----------------------------------------------------------

-- Plugin: dial.map
-- url: https://github.com/monaqa/dial.nvim
return {
  'monaqa/dial.nvim',
  lazy = true,
  event = "BufRead",
  keys = {
    -- See https://github.com/monaqa/dial.nvim/blob/master/README_ja.md
    {"<C-a>", function() require("dial.map").manipulate("increment", "normal") end, 'n'},
    {"<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, 'n'},
    {"g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, 'n'},
    {"g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, 'n'},
    {"<C-a>", function() require("dial.map").manipulate("increment", "visual") end, 'v'},
    {"<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, 'v'},
    {"g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, 'v'},
    {"g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, 'v'},
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group{
      default = {
        augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
        augend.constant.alias.bool,     -- boolean value (true <-> false)
      },
    }

  end
}

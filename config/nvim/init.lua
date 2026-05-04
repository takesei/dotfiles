---------------------------------------------------------------------------
-- honyamorake's .vimrc
-- ref: https://github.com/Shougo/shougo-s-github/
---------------------------------------------------------------------------

-- Load Config
require("core.options")
require("core.mapping")
require("core.autoload")
require("core.secret")

if vim.fn.filereadable(vim.fn.expand("~/.personal_vimrc")) == 1 then
	vim.cmd("source " .. vim.fn.expand("~/.personal_vimrc"))
end

-- Load Plugins
require("core.pkg_manager")

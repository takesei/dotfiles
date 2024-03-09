-- Package Manager
local cache_path = vim.env.XDG_CACHE_HOME .. "/lazy"
local lazy_path = cache_path .. "/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
vim.opt.rtp:prepend(lazy_path)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  print("Lazy failed to start")
  return
end

lazy.setup("plugins")

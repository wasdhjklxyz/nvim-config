-- Globals
vim.g.mapleader = " "
vim.g.maxwidth = 80
vim.g.tabwidth = 2

-- Fake netrw being setup already
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Set nvim options
require("core.options")

-- Initialize lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", "--filter=blob:none", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load and configure plugins
require('lazy').setup({
  spec = {
    { import = "plugins" },
    { import = "colorschemes" },
  },
  defaults = {
    lazy = false,   -- Load all plugins at startup
    version = "*",  -- Use stable versions
  },
  checker = {
    enabled = true,
    notify = false,     -- Silent updates
    frequency = 86400,  -- Daily checks
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})

-- Load keymaps and autocmds
require("core.keymaps")
require("core.autocmds")

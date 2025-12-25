-- Neovim Configuration Entry Point
-- Ported from vim configuration with modern Lua enhancements

-- Load core configuration
require("core.options")    -- Editor settings
require("core.keymaps")    -- Key bindings
require("core.autocmds")   -- Autocommands

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("plugins")

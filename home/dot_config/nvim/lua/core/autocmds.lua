-- Autocommands (Ported from .vimrc)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- File type detection
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.php",
  callback = function()
    vim.bo.filetype = "php"
  end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*.php",
  callback = function()
    vim.opt_local.binary = true
    vim.opt_local.eol = true
  end,
})

autocmd({ "BufWritePost" }, {
  pattern = "*.php",
  callback = function()
    vim.opt_local.binary = false
    vim.opt_local.eol = false
  end,
})

-- YAML for fdoc files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.fdoc",
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})

-- Markdown files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
    vim.opt_local.spell = true
  end,
})

-- Ruby cap files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cap", "Capfile" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- File type-specific indentation
autocmd("FileType", {
  pattern = { "ruby", "javascript", "yaml" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt_local.eol = true
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.fixendofline = true
  end,
})

-- Vue syntax sync
autocmd("FileType", {
  pattern = "vue",
  command = "syntax sync fromstart",
})

-- Automatically trim trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = [[:%s/\s\+$//e]],
})

-- Automatically rebalance windows on vim resize
autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- Cursorline only in active window
local cursorline_group = augroup("CursorLine", { clear = true })

autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Open NvimTree on startup (replacing NERDTree behavior)
-- Commented out by default - enable if you want this behavior
-- autocmd("VimEnter", {
--   callback = function()
--     require("nvim-tree.api").tree.open()
--     -- Move cursor to main window if opening a file
--     if vim.fn.argc() > 0 then
--       vim.cmd("wincmd p")
--     end
--   end,
-- })

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Rails.vim custom commands (if using vim-rails)
-- These add custom navigation commands for Rails projects
autocmd("User", {
  pattern = "Rails",
  callback = function()
    vim.cmd([[silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb]])
    vim.cmd([[silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb]])
    vim.cmd([[silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature]])
    vim.cmd([[silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb]])
    vim.cmd([[silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb]])
    vim.cmd([[silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb]])
  end,
})

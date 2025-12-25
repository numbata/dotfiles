-- UI Configuration
-- Colorscheme, statusline, and git signs

local M = {}

-- Colorscheme setup
M.setup_colorscheme = function()
  -- Set termguicolors
  vim.opt.termguicolors = true

  -- Try to load onehalflight (similar to your vim config)
  local status_ok, _ = pcall(vim.cmd, "colorscheme onehalflight")
  if not status_ok then
    -- Fallback to a built-in or alternative colorscheme
    vim.notify("onehalflight colorscheme not found, trying catppuccin", vim.log.levels.WARN)
    pcall(vim.cmd, "colorscheme catppuccin")
  end

  -- Alternatively, you can use:
  -- vim.cmd("colorscheme tokyonight")
  -- vim.cmd("colorscheme solarized")
end

-- Lualine setup (statusline)
M.setup_lualine = function()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",  -- Will match your colorscheme
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "NvimTree" },
        winbar = {},
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree", "fugitive" },
  })
end

-- Gitsigns setup (git integration)
M.setup_gitsigns = function()
  require("gitsigns").setup({
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous hunk" })

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
      map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
      map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  })
end

return M

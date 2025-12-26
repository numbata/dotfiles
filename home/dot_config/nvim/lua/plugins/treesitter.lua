-- Treesitter Configuration
-- Better syntax highlighting and code understanding

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  ok, configs = pcall(require, "nvim-treesitter.config")
end
if not ok then
  return
end

configs.setup({
  -- Auto-install these language parsers
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "ruby",
    "javascript",
    "typescript",
    "tsx",
    "vue",
    "elixir",
    "go",
    "rust",
    "c_sharp",
    "html",
    "css",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "bash",
    "dockerfile",
    "sql",
    "regex",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- Highlighting
  highlight = {
    enable = true,

    -- Disable for very large files (performance)
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Additional vim regex highlighting
    additional_vim_regex_highlighting = false,
  },

  -- Indentation based on treesitter
  indent = {
    enable = true,
    -- Disable for languages where it doesn't work well
    disable = { "ruby", "python" },
  },

  -- Incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },

  -- Textobjects (requires nvim-treesitter-textobjects)
  -- Uncomment if you install nvim-treesitter-textobjects
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --     },
  --   },
  -- },
})

-- Enable folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false  -- Don't fold by default

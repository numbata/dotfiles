-- Plugin Configuration
-- Using lazy.nvim as plugin manager

require("lazy").setup({
  -- Core functionality plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-cmdline",  -- Disabled due to compatibility issues
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.completion")
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view = {
        width = 30,
      },
      filters = {
        dotfiles = false,
      },
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.ui").setup_lualine()
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.ui").setup_gitsigns()
    end,
  },

  -- Git wrapper (keep from vim)
  { "tpope/vim-fugitive" },

  -- Colorscheme
  {
    "sonph/onehalf",
    config = function()
      require("plugins.ui").setup_colorscheme()
    end,
  },
  { "altercation/vim-colors-solarized" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "folke/tokyonight.nvim" },

  -- Editor enhancement
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Which-key (shows keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Keep some vim plugins that work well
  { "tpope/vim-repeat" },
  { "tpope/vim-obsession" },
  { "tpope/vim-dispatch" },
  { "editorconfig/editorconfig-vim" },
  { "easymotion/vim-easymotion" },
  { "github/copilot.vim" },
  { "ConradIrwin/vim-bracketed-paste" },
  { "airblade/vim-gitgutter" },  -- Can keep alongside gitsigns or remove later
  { "bogado/file-line" },
  { "mg979/vim-visual-multi" },
  { "AndrewRadev/linediff.vim" },

  -- Language-specific plugins (keep from vim)
  { "tpope/vim-rails", ft = "ruby" },
  { "tpope/vim-endwise", ft = "ruby" },
  { "slim-template/vim-slim", ft = "ruby" },
  { "elixir-editors/vim-elixir", ft = "elixir" },
  { "c-brenn/phoenix.vim", ft = "elixir" },
  { "slashmili/alchemist.vim", ft = "elixir" },
  { "fatih/vim-go", ft = "go" },
  { "elzr/vim-json" },
  { "pangloss/vim-javascript", ft = "javascript" },
  { "mxw/vim-jsx", ft = "javascript" },
  { "mtscout6/vim-cjsx", ft = "javascript" },
  { "posva/vim-vue", ft = "javascript" },
  { "zah/nim.vim", ft = "nim" },
  { "ekalinin/Dockerfile.vim" },
  { "vim-scripts/confluencewiki.vim" },
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

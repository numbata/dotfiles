-- Telescope Configuration
-- Fuzzy finder (replaces FZF)

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " 🔍 ",
    selection_caret = "  ",
    path_display = { "truncate" },

    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
  },

  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
    },
  },

  extensions = {
    -- Add extensions here if needed
  },
})

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File pickers
map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Git pickers
map("n", "<leader>gc", ":Telescope git_commits<CR>", opts)
map("n", "<leader>gb", ":Telescope git_branches<CR>", opts)
map("n", "<leader>gs", ":Telescope git_status<CR>", opts)

-- LSP pickers
map("n", "<leader>lr", ":Telescope lsp_references<CR>", opts)
map("n", "<leader>ld", ":Telescope lsp_definitions<CR>", opts)
map("n", "<leader>li", ":Telescope lsp_implementations<CR>", opts)
map("n", "<leader>lt", ":Telescope lsp_type_definitions<CR>", opts)
map("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", opts)
map("n", "<leader>lw", ":Telescope lsp_workspace_symbols<CR>", opts)

-- Other pickers
map("n", "<leader>km", ":Telescope keymaps<CR>", opts)
map("n", "<leader>cs", ":Telescope colorscheme<CR>", opts)
map("n", "<leader>of", ":Telescope oldfiles<CR>", opts)
map("n", "<leader>cm", ":Telescope commands<CR>", opts)

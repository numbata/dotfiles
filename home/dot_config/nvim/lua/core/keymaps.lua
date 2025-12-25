-- Key Mappings (Ported from .vimrc)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Window navigation (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- File explorer (will be nvim-tree instead of NERDTree)
map("n", "<leader>d", ":NvimTreeToggle<CR>", opts)

-- Fuzzy finding (will be Telescope instead of FZF)
map("n", "<C-p>", ":Telescope find_files<CR>", opts)

-- FZF mappings (Telescope equivalents)
map("n", "<leader><tab>", ":Telescope keymaps<CR>", opts)

-- EasyMotion leader (using ; as the trigger)
-- Note: We'll keep easymotion for now, can migrate to leap/flash later
vim.g.EasyMotion_leader_key = ";"

-- Additional useful mappings
-- Clear search highlighting
map("n", "<leader><space>", ":nohlsearch<CR>", opts)

-- Save file
map("n", "<leader>w", ":w<CR>", opts)

-- Quit
map("n", "<leader>q", ":q<CR>", opts)

-- Save and quit
map("n", "<leader>x", ":x<CR>", opts)

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

-- Tab navigation
map("n", "<leader>tn", ":tabnext<CR>", opts)
map("n", "<leader>tp", ":tabprevious<CR>", opts)
map("n", "<leader>tc", ":tabclose<CR>", opts)

-- Split windows
map("n", "<leader>sv", ":vsplit<CR>", opts)
map("n", "<leader>sh", ":split<CR>", opts)

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Better indenting in visual mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Paste without yanking in visual mode
map("v", "p", '"_dP', opts)

-- Note: Plugin-specific keymaps will be defined in their respective plugin configs
-- - Telescope keymaps in lua/plugins/telescope.lua
-- - LSP keymaps in lua/plugins/lsp.lua
-- - Git keymaps in lua/plugins/ui.lua

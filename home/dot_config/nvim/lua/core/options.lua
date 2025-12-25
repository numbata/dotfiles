-- Editor Options (Ported from .vimrc)
-- All 'set' commands converted to Lua

local opt = vim.opt

-- General
opt.compatible = false                 -- Be iMproved
opt.encoding = "utf-8"                 -- Default encoding
opt.fileencoding = "utf-8"
opt.hidden = true                      -- Allow hidden buffers

-- UI
opt.number = true                      -- Line numbers
opt.cursorline = false                 -- Don't show cursor line (performance)
opt.wrap = false                       -- Don't wrap lines
opt.showmode = true                    -- Show current mode
opt.title = true                       -- Change terminal title
opt.termguicolors = true               -- True color support
opt.colorcolumn = "85"                 -- Show column ruler

-- Indentation
opt.expandtab = true                   -- Use spaces instead of tabs
opt.tabstop = 2                        -- Tab width
opt.softtabstop = 2                    -- Soft tab width
opt.shiftwidth = 2                     -- Indent width
opt.smartindent = true                 -- Smart auto-indent

-- Search
opt.ignorecase = true                  -- Case insensitive search
opt.smartcase = true                   -- Unless uppercase is used

-- Performance
opt.synmaxcol = 300                    -- Max columns to highlight
opt.updatetime = 250                   -- Faster completion

-- Splits
opt.splitbelow = true                  -- Horizontal splits below
opt.splitright = true                  -- Vertical splits right

-- Backup and Swap
opt.backup = false                     -- No backup files
opt.writebackup = false                -- No backup when overwriting
opt.swapfile = false                   -- No swap files

-- Folding
opt.foldenable = false                 -- Disable folding

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 15                     -- Popup menu height

-- Wildmenu
opt.wildmode = "list:longest,list:full"
opt.wildignore = {
  ".hg", ".git", ".svn",               -- Version control
  "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg",  -- Binary images
  "*.o", "*.obj", "*.exe", "*.dll", "*.manifest", "*.pyc",  -- Compiled
  "tags",
  "log/**", "node_modules/**", "target/**", "tmp/**"
}

-- Listchars (invisible characters)
opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
  eol = "¬",
  nbsp = "_"
}

-- Other
opt.backspace = { "indent", "eol", "start" }
opt.joinspaces = false                 -- Don't add 2 spaces with J

-- Clipboard
if vim.fn.has("clipboard") == 1 then
  opt.clipboard = "unnamed"
  if vim.fn.has("unnamedplus") == 1 then
    opt.clipboard:append("unnamedplus")
  end
end

-- Regular expression engine (for Ruby performance)
vim.cmd("set re=1")

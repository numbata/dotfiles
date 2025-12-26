-- LSP Configuration for all languages
-- Using modern mason-lspconfig handlers (Neovim 0.11+ compatible)

-- Setup Mason for auto-installing LSP servers
require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- LSP keybindings (attached to buffers with active LSP)
local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Navigation
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gr", vim.lsp.buf.references, "Find references")
  map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

  -- Information
  map("n", "K", vim.lsp.buf.hover, "Hover documentation")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  -- Code actions
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, "Format code")

  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
  map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics list")

  -- Workspace
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

-- Capabilities (for nvim-cmp integration)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Diagnostic signs
local signs = { Error = "💣", Warn = "🚩", Hint = "💡", Info = "ℹ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP server-specific settings
local server_settings = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },

  gopls = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },

  rust_analyzer = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

-- Auto-install and configure LSP servers using mason-lspconfig handlers
local mason_lspconfig = require("mason-lspconfig")
local available = {}
if mason_lspconfig.get_available_servers then
  available = mason_lspconfig.get_available_servers()
end
local available_lookup = {}
for _, name in ipairs(available) do
  available_lookup[name] = true
end

local function pick_server(candidates)
  for _, name in ipairs(candidates) do
    if available_lookup[name] then
      return name
    end
  end
  return nil
end

local ensure_installed = {
  "lua_ls",           -- Lua
  "elixirls",         -- Elixir
  "gopls",            -- Go
  "rust_analyzer",    -- Rust
  "ruby_lsp",         -- Ruby (Shopify's Ruby LSP)
  "clangd",           -- C/C++
  "nimls",            -- Nim
}

local ts_server = pick_server({ "ts_ls", "tsserver" })
if ts_server then
  table.insert(ensure_installed, ts_server)
end

local vue_server = pick_server({ "volar", "vuels" })
if vue_server then
  table.insert(ensure_installed, vue_server)
end

mason_lspconfig.setup({
  ensure_installed = ensure_installed,
  automatic_installation = true,

  -- Modern handler approach (avoids lspconfig deprecation warning)
  handlers = {
    -- Default handler for all servers
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = server_settings[server_name] or {},
      })
    end,

    -- Server-specific overrides (if needed)
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = server_settings.lua_ls,
      })
    end,

    ["gopls"] = function()
      require("lspconfig").gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = server_settings.gopls,
      })
    end,

    ["rust_analyzer"] = function()
      require("lspconfig").rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = server_settings.rust_analyzer,
      })
    end,
  },
})

-- Note: For C#, uncomment and install omnisharp manually if needed:
-- require("lspconfig").omnisharp.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "omnisharp" },
-- })

-- Completion Configuration (nvim-cmp)

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    -- Navigate completion menu
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),

    -- Scroll documentation
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- Trigger completion
    ["<C-Space>"] = cmp.mapping.complete(),

    -- Close completion
    ["<C-e>"] = cmp.mapping.abort(),

    -- Accept completion
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- Tab for snippets and completion
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },     -- LSP completions
    { name = "luasnip" },      -- Snippet completions
    { name = "path" },         -- File path completions
  }, {
    { name = "buffer" },       -- Buffer word completions
  }),

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      local kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }

      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,
  },

  experimental = {
    ghost_text = true,  -- Show ghost text for suggestions
  },
})

-- Command line completion (commented out due to compatibility issues)
-- Uncomment if you want command line completion
-- cmp.setup.cmdline(":", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = "path" }
--   }, {
--     { name = "cmdline" }
--   }),
-- })

-- Search completion (commented out due to compatibility issues)
-- cmp.setup.cmdline("/", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" }
--   },
-- })

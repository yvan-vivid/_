---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  -- 'default' = C-y, 'enter' = enter
  keymap = { preset = "enter" },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = { auto_show = true },
    list = { selection = { preselect = false, auto_insert = true } },
  },

  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
}

return {
  "saghen/blink.cmp",
  dependencies = {
    "folke/lazydev.nvim",
    "rafamadriz/friendly-snippets",
  },
  enabled = true,
  version = "1.*",

  opts = opts,
  opts_extend = { "sources.default" },
}

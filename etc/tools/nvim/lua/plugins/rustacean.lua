vim.g.rustaceanvim = {
  tools = {
    test_executor = "background",
  },
  server = {
    on_attach = require("lib.lsp").rust_attach,
    default_settings = {
      ["rust-analyzer"] = {},
    },
  },
  dap = {},
}

return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false, -- The plugin is lazy internally
}

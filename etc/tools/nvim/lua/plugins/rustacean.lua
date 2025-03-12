local function init()
  vim.g.rustaceanvim = {
    tools = {
      test_executor = "background",
    },
    server = {
      on_attach = require "configs.lsp_keys",
      default_settings = {
        ["rust-analyzer"] = {},
      },
    },
    dap = {},
  }
end

return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- The plugin is lazy internally
    init = init,
    server = {
      on_attach = require "configs.lsp_keys",
    },
  },
}

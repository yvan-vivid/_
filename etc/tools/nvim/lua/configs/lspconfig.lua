local servers = { "html", "cssls", "ts_ls", "basedpyright", "bashls" }

local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lsp_keys = require "configs.lsp_keys"
local lspconfig = require "lspconfig"

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_keys,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.ruff.setup {
  on_attach = lsp_keys,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    settings = {},
  },
}

lspconfig.nixd.setup {
  on_attach = lsp_keys,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    nixd = {
      nixpkgs = {
        -- expr = "",
      },
      options = {
        nixos = {
          -- expr = "",
        },
      },
    },
  },
}

local servers = { "html", "cssls", "ts_ls", "basedpyright", "bashls", "yamlls", "marksman" }

local nvchad = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

local defaults = {
  on_attach = require "configs.lsp_keys",
  on_init = nvchad.on_init,
  capabilities = nvchad.capabilities,
}

local function setup(server, settings)
  lspconfig[server].setup(vim.tbl_extend("force", defaults, settings))
end

for _, lsp in ipairs(servers) do
  setup(lsp, {})
end

setup("ruff", {
  init_options = {
    settings = {},
  },
})

setup("nixd", {
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
})

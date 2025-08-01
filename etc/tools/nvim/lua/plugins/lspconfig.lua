local lib = require "lib.lsp"
local base46 = (require "lib.base46")()

local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local server_defaults = {
  on_attach = lib.stardard_attach,
  on_init = on_init,
  capabilities = capabilities,
}

local config = function()
  base46.load_cached "lsp"
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = lib.attach_from_event,
  })

  local lspconfig = require "lspconfig"

  local function setup(server, settings)
    lspconfig[server].setup(vim.tbl_extend("force", server_defaults, settings))
  end

  local servers = { "html", "cssls", "ts_ls", "basedpyright", "bashls", "yamlls", "marksman" }
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

  setup("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "mp" },
        },
      },
    },
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "folke/lazydev.nvim",
  },
  event = "User FilePost",
  config = config,
}

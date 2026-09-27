local lsp = require "lib.lsp"

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

vim.lsp.config("*", {
  on_attach = lsp.standard_attach,
  capabilities = capabilities,
})

-- Custom server configs (overriding nvim-lspconfig defaults)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "mp" },
      },
    },
  },
})

vim.lsp.config("ts_ls", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      nixpkgs = {
        expr = "",
      },
      options = {
        nixos = {
          expr = "",
        },
      },
    },
  },
})

-- nvim-lspconfig provides defaults for these; just enable them
vim.lsp.enable {
  "ty",
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "nixd",
  "ruff",
  "ts_ls",
  "yamlls",
}
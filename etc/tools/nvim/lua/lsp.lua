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

vim.lsp.enable {
  "basedpyright",
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

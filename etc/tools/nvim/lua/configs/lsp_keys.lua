local lspbuf = vim.lsp.buf

local function do_format()
  lspbuf.format { async = true }
end

local function key_mapper(bufnr)
  return function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function key_bindings(bufnr)
  local map = key_mapper(bufnr)

  -- Go to
  map("n", "gD", lspbuf.declaration, { desc = "Go to Declaration" })
  map("n", "gd", lspbuf.definition, { desc = "Go to Definition" })
  map("n", "gi", lspbuf.implementation, { desc = "Go to Implementation" })
  map("n", "gr", lspbuf.references, { desc = "Find References" })

  -- Hover
  map("n", "K", lspbuf.hover, { desc = "Hover Documentation" })

  -- Info
  map("n", "<leader>kt", lspbuf.signature_help, { desc = "Signature Help" })

  -- Refactor
  map("n", "<leader>rr", lspbuf.rename, { desc = "Rename Symbol" })

  -- Actions
  map("n", "<leader>kl", lspbuf.code_action, { desc = "Code Action" })

  -- Module
  map("n", "<leader>=", do_format, { desc = "Format Document" })
end

return function(client, bufnr)
  key_bindings(bufnr)

  -- Optional: Highlight references under the cursor
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = "lsp_document_highlight",
      callback = vim.lsp.buf.clear_references,
    })
  end
end

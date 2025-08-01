local keys = require "lib.lsp.keys"

local function cursor_tricks(client, bufnr)
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

M = {}

function M.stardard_attach(client, bufnr)
  keys.key_bindings(bufnr)
  cursor_tricks(client, bufnr)
end

function M.rust_attach(client, bufnr)
  keys.rust_key_bindings(bufnr)
  cursor_tricks(client, bufnr)
end

function M.attach_from_event(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  M.stardard_attach(client, ev.buf)
end

return M

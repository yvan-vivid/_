local lspbuf = vim.lsp.buf

local function key_mapper(bufnr)
  return function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local M = {}

function M.key_bindings(bufnr)
  local map = key_mapper(bufnr)

  -- Go to
  map("n", "gD", lspbuf.declaration, { desc = "Go to Declaration" })
  map("n", "gd", lspbuf.definition, { desc = "Go to Definition" })
  map("n", "gi", lspbuf.implementation, { desc = "Go to Implementation" })
  map("n", "gr", lspbuf.references, { desc = "Find References" })

  -- Info
  map("n", "<leader>kt", lspbuf.signature_help, { desc = "Signature Help" })

  -- Refactor
  map("n", "<leader>rr", lspbuf.rename, { desc = "Rename Symbol" })

  -- Actions
  map("n", "<leader>kl", lspbuf.code_action, { desc = "Code Action" })

  -- Diagnostics
  map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Format Document" })
end

function M.rust_key_bindings(bufnr)
  local map = key_mapper(bufnr)
  local function rlsp(m)
    return function()
      vim.cmd.RustLsp(m)
    end
  end

  -- Go to
  map("n", "gD", lspbuf.declaration, { desc = "Go to Declaration" })
  map("n", "gd", lspbuf.definition, { desc = "Go to Definition" })
  map("n", "gi", lspbuf.implementation, { desc = "Go to Implementation" })
  map("n", "gr", lspbuf.references, { desc = "Find References" })

  -- Hover
  map("n", "K", rlsp { "hover", "actions" }, { desc = "Hover Documentation" })

  -- Info
  map("n", "<leader>kt", lspbuf.signature_help, { desc = "Signature Help" })

  -- Refactor
  map("n", "<leader>rr", lspbuf.rename, { desc = "Rename Symbol" })

  -- Actions
  map("n", "<leader>kl", rlsp "codeAction", { desc = "Code Action" })

  -- Diagnostics
  map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Format Document" })
end

return M

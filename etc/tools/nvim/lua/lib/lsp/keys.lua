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

  -- Info
  map("n", "<leader>kt", lspbuf.signature_help, { desc = "Signature Help" })

  -- Diagnostics
  map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Diagnostics float" })
end

function M.rust_key_bindings(bufnr)
  local map = key_mapper(bufnr)
  local function rlsp(m)
    return function()
      vim.cmd.RustLsp(m)
    end
  end

  -- Hover (rustaceanvim enhanced)
  map("n", "K", rlsp { "hover", "actions" }, { desc = "Hover Documentation" })

  -- Info
  map("n", "<leader>kt", lspbuf.signature_help, { desc = "Signature Help" })

  -- Actions (rustaceanvim enhanced)
  map("n", "<leader>kl", rlsp "codeAction", { desc = "Code Action" })

  -- Diagnostics
  map("n", "<leader>df", vim.diagnostic.open_float, { desc = "Diagnostics float" })
end

function M.attach_from_event(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  M.standard_attach(client, ev.buf)
end

return M
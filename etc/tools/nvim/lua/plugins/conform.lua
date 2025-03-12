local formatters = {
  lua = { "stylua" },
  python = { "ruff_organize_imports", "ruff_format" },
  rust = { "rustfmt" },
  bash = { "shfmt" },
  sh = { "shfmt" },
  toml = { "taplo" },
  nix = { "alejandra" },
  css = { "prettier" },
  html = { "prettier" },
}

local options = {
  formatters_by_ft = formatters,
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

local function init()
  local conform = require "conform"
  local setkey = vim.keymap.set

  local function format()
    conform.format { lsp_fallback = true }
  end

  setkey("n", "<leader>=", format, { desc = "general format file" })
end

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = options,
    init = init,
  },
}

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format" },
    rust = { "rustfmt" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    toml = { "taplo" },
    nix = { "alejandra" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

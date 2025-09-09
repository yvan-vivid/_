local severity = vim.diagnostic.severity

local signs = {
  text = {
    [severity.ERROR] = "󰅙",
    [severity.WARN] = "",
    [severity.INFO] = "󰋼",
    [severity.HINT] = "󰌵",
  },
}

local float_win = {
  border = "rounded",
  source = true,
  scope = "line",
  focusable = false,
  prefix = "",
  header = "Diagnostics",
}

local M = {}

function M.standard()
  vim.diagnostic.config {
    virtual_lines = false,
    virtual_text = { prefix = "" },
    float = float_win,
    signs = signs,
    underline = true,
    severity_sort = true,
  }
end

function M.lines()
  vim.diagnostic.config {
    virtual_lines = true,
    virtual_text = false,
    float = float_win,
    signs = signs,
    underline = true,
    severity_sort = true,
  }
end

return M

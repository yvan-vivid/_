local M = {
  vivid_date = {},
}

function M.set_treesitter_folds()
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

function M.vivid_date.today()
  return vim.fn.system("~/_/bin/vivid-time today"):gsub("\n$", "")
end

function M.vivid_date.slug(log_date)
  local format = "∆ (%d+): (%d) ∘ (%d) ∘ (%d) ∘ (%d)"
  local year, period, spoke, arc, phase = string.match(log_date, format)
  return year .. "_" .. period .. "-" .. spoke .. "-" .. arc .. "-" .. phase
end

return M

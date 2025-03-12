local o = vim.opt

local M = {
  vivid_date = {},
  insertion = {},
  settings = {},
}

local vivid_date = M.vivid_date
local insertion = M.insertion
local settings = M.settings

function settings.set_treesitter_folds()
  o.foldmethod = "expr"
  o.foldexpr = "nvim_treesitter#foldexpr()"
end

function vivid_date.today()
  return vim.fn.system("~/_/bin/vivid-time today"):gsub("\n$", "")
end

function vivid_date.slug(log_date)
  local format = "∆ (%d+): (%d) ∘ (%d) ∘ (%d) ∘ (%d)"
  local year, period, spoke, arc, phase = string.match(log_date, format)
  return year .. "_" .. period .. "-" .. spoke .. "-" .. arc .. "-" .. phase
end

function settings.writing_settings()
  vim.opt.linebreak = true
  vim.opt.spell = true
end

function insertion.vivid_log_date()
  vim.api.nvim_put({ "# " .. vivid_date.today(), "" }, "l", true, true)
end

function insertion.vivid_date_slug()
  local slug = vivid_date.slug(vivid_date.today())
  vim.api.nvim_put({ "  - " .. slug, "" }, "l", true, true)
end

return M

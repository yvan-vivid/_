local o = vim.opt
local vivid_date = require "lib/vivid_time"

local M = {
  insertion = {},
  settings = {},
}

local insertion = M.insertion
local settings = M.settings

function settings.set_treesitter_folds()
  o.foldmethod = "expr"
  o.foldexpr = "nvim_treesitter#foldexpr()"
end

function settings.writing_settings()
  o.linebreak = true
  o.spell = true
  o.shiftwidth = 2
  o.tabstop = 2
  o.expandtab = true
end

function insertion.vivid_log_date()
  vim.api.nvim_put({ "# " .. vivid_date.today_as_standard(), "" }, "l", true, true)
end

function insertion.vivid_date_slug()
  local vd = vivid_date.today()
  if vd ~= nil then
    local slug = vivid_date.to_slug(vd)
    vim.api.nvim_put({ "  - " .. slug, "" }, "l", true, true)
  end
end

return M

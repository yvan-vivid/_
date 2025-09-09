local vivid_date = require "lib/vivid_time"

local M = {
  insertion = {},
  settings = {},
  fragments = {},
}

local insertion = M.insertion
local settings = M.settings
local fragments = M.fragments

function settings.writing_settings()
  vim.wo.linebreak = true
  vim.wo.spell = true
  vim.bo.shiftwidth = 2
  vim.bo.tabstop = 2
  vim.bo.expandtab = true
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

-- These are just incomplete fragments of things

function fragments.show_capabilities()
  -- This is just a messy fragment
  return vim.lsp.get_clients()[1].server_capabilities
end

return M

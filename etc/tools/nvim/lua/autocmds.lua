local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local function get_vivid_today()
  return vim.fn.system("~/_/bin/vivid-time today"):gsub("\n$", "")
end

local function vivid_date_log()
  local datestr = "#### " .. get_vivid_today()
  vim.api.nvim_put({ datestr, "" }, "l", true, true)
end

local function writing_settings()
  vim.opt.linebreak = true
  vim.opt.spell = true
end

local markdown_settings = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

usercmd("VividLogDate", vivid_date_log, {})

autocmd({ "FileType" }, { pattern = "markdown", group = markdown_settings, callback = writing_settings })

Util = require "lib"
Util.set_treesitter_folds()

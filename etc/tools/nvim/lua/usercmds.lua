local lib = require "lib"
local usercmd = vim.api.nvim_create_user_command
usercmd("VividLogDate", lib.insertion.vivid_log_date, {})
usercmd("VividDateSlug", lib.insertion.vivid_date_slug, {})

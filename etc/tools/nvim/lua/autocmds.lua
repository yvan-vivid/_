local lib = require "lib"
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local markdown_settings = augroup("MarkdownSettings", { clear = true })
autocmd(
  "FileType",
  { pattern = "markdown", group = markdown_settings, callback = lib.settings.writing_settings }
)

lib.settings.set_treesitter_folds()

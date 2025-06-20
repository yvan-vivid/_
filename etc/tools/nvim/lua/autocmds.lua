local settings = (require "lib").settings
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local markdown_settings = augroup("MarkdownSettings", { clear = true })
autocmd(
  "FileType",
  { pattern = "markdown", group = markdown_settings, callback = settings.writing_settings }
)

settings.set_treesitter_folds()

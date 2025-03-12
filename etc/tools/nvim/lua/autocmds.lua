local lib = require "lib"
local autocmd = vim.api.nvim_create_autocmd
local markdown_settings = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })
autocmd(
  { "FileType" },
  { pattern = "markdown", group = markdown_settings, callback = lib.settings.writing_settings }
)

lib.settings.set_treesitter_folds()

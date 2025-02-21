local lib = require "lib"
local vivid_date = lib.vivid_date

local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local function writing_settings()
  vim.opt.linebreak = true
  vim.opt.spell = true
end

local function vivid_log_date()
  vim.api.nvim_put({ "# " .. vivid_date.today(), "" }, "l", true, true)
end

local function vivid_date_slug()
  local slug = vivid_date.slug(vivid_date.today())
  vim.api.nvim_put({ "  - " .. slug, "" }, "l", true, true)
end

local markdown_settings = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })

usercmd("VividLogDate", vivid_log_date, {})
usercmd("VividDateSlug", vivid_date_slug, {})

autocmd({ "FileType" }, { pattern = "markdown", group = markdown_settings, callback = writing_settings })

lib.set_treesitter_folds()

-- TODO: Will find a better place for this
vim.g.rustaceanvim = {
  tools = {
    test_executor = "background",
  },
  server = {
    on_attach = require "configs.lsp_keys",
    default_settings = {
      ["rust-analyzer"] = {},
    },
  },
  dap = {},
}

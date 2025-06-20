local servers = { "html", "cssls", "ts_ls", "basedpyright", "bashls", "yamlls", "marksman" }

local nvchad = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"
local lib = require "lib.lsp"
local vim_lua_path = vim.fn.expand "$VIMRUNTIME/lua"
local vim_data = vim.fn.stdpath "data"

local defaults = {
  on_attach = lib.stardard_attach,
  on_init = nvchad.on_init,
  capabilities = nvchad.capabilities,
}

local function setup(server, settings)
  lspconfig[server].setup(vim.tbl_extend("force", defaults, settings))
end

for _, lsp in ipairs(servers) do
  setup(lsp, {})
end

setup("ruff", {
  init_options = {
    settings = {},
  },
})

setup("nixd", {
  settings = {
    nixd = {
      nixpkgs = {
        -- expr = "",
      },
      options = {
        nixos = {
          -- expr = "",
        },
      },
    },
  },
})

setup("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "mp" },
      },
      workspace = {
        library = {
          vim_lua_path,
          vim_lua_path .. "/vim/lsp",
          vim_data .. "/lazy/ui/nvchad_types",
          vim_data .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- setup("harper_ls", {
--   settings = {
--     ["harper-ls"] = {
--       userDictPath = "",
--       fileDictPath = "",
--       linters = {
--         SpellCheck = true,
--         SpelledNumbers = false,
--         AnA = true,
--         SentenceCapitalization = true,
--         UnclosedQuotes = true,
--         WrongQuotes = true,
--         LongSentences = false,
--         RepeatedWords = true,
--         Spaces = true,
--         Matcher = true,
--         CorrectNumberSuffix = true,
--       },
--       codeActions = {
--         ForceStable = false,
--       },
--       markdown = {
--         IgnoreLinkTitle = false,
--       },
--       diagnosticSeverity = "hint",
--       isolateEnglish = false,
--     },
--   },
-- })

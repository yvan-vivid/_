-- lua/plugins/treesitter.lua
return {
  "romus204/tree-sitter-manager.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = require "configs.treesitter_parsers",
  },
  config = function(_, opts)
    require("tree-sitter-manager").setup(opts)

    -- Native highlighting, indent, folding
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end,
}

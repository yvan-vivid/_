return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = require "configs.treesitter_parsers",
  },
}

local config = function()
  require("nvchad.configs.lspconfig").defaults()
  require "configs.lspconfig"
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "NvChad/NvChad",
  },
  event = "User FilePost",
  config = config,
}

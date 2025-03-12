local config = function()
  local data_dir = vim.fn.stdpath "data"

  local opts = {
    config_path = data_dir .. "/codeium/api_key",
    bin_path = data_dir .. "/codeium/bin",
  }

  require("codeium").setup(opts)
end

return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = config,
  },
}

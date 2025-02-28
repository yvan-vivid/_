require("neotest").setup {
  adapters = {
    require "rustaceanvim.neotest",
    require "neotest-python",
  },
  floating = {
    border = "rounded",
    max_height = 0.6,
    max_width = 0.6,
  },
  quickfix = {
    enabled = true,
  },
}

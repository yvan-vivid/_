local init = function()
  local neotest = require "neotest"
  local setkey = vim.keymap.set

  local function run_file()
    neotest.run.run(vim.fn.expand "%")
  end

  setkey("n", "<leader>tn", neotest.run.run, { desc = "Run nearest test" })
  setkey("n", "<leader>tf", run_file, { desc = "Run all tests in file" })
  setkey("n", "<leader>te", neotest.summary.toggle, { desc = "Toggle test summary" })
end

local opts = function()
  local adapters = {
    require "rustaceanvim.neotest",
    require "neotest-python",
  }

  return {
    adapters = adapters,
    floating = {
      border = "rounded",
      max_height = 0.6,
      max_width = 0.6,
    },
    quickfix = {
      enabled = true,
    },
  }
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  opts = opts,
  init = init,
}

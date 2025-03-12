local function init()
  local builtin = require "telescope.builtin"
  local themes = require "nvchad.themes"
  local setkey = vim.keymap.set
  setkey("n", "<leader>hh", builtin.buffers, { desc = "Telescope Buffers" })
  setkey("n", "<leader>ha", builtin.marks, { desc = "Telescope Marks" })
  setkey("n", "<leader>he", builtin.find_files, { desc = "Telescope Find" })
  setkey("n", "<leader>hg", builtin.git_files, { desc = "Telescope Git" })
  setkey("n", "<leader>hw", builtin.live_grep, { desc = "Telescope Grep" })
  setkey("n", "<leader>h/", builtin.find_files, { desc = "Telescope Fuzzy Find Buffer" })
  setkey("n", "<leader>hU", themes.open, { desc = "Telescope Themes" })
end

local opts = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "◆ ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {},
}

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "Telescope",
  init = init,
  opts = opts,
}

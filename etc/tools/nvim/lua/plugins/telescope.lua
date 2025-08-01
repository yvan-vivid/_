local base46 = (require "lib.base46")()

local function init()
  local builtin = require "telescope.builtin"
  local themes = require "nvchad.themes"
  local setkey = vim.keymap.set
  local function setkt(keys, fun, des)
    setkey("n", "<leader> " .. keys, fun, des)
  end

  -- Editing
  setkt("b", builtin.buffers, { desc = "Telescope Buffers" })
  setkt("m", builtin.marks, { desc = "Telescope Marks" })
  setkt("s", builtin.live_grep, { desc = "Telescope Grep" })

  -- Files
  setkt("f", builtin.find_files, { desc = "Telescope Find" })
  setkt("/", builtin.find_files, { desc = "Telescope Fuzzy Find Buffer" })
  setkt("o", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })

  -- Git
  setkt("gg", builtin.git_files, { desc = "Telescope Git" })
  setkt("gw", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
  setkt("gk", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
  setkt(
    "a",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
  )

  -- Resources
  setkt("h", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })

  -- UI
  setkt("U", themes.open, { desc = "Telescope Themes" })
  setkt("uh", function()
    require("nvchad.themes").open()
  end, { desc = "telescope nvchad themes" })
end

local function opts()
  base46.load_cached "telescope"
  return {
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

    pickers = {
      find_files = {
        theme = "ivy",
      },
    },
  }
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "Telescope",
  init = init,
  opts = opts,
}

local function init()
  local setkey = vim.keymap.set
  local function query()
    vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
  end

  setkey("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
  setkey("n", "<leader>wk", query, { desc = "whichkey query lookup" })
end

return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  init = init,
}

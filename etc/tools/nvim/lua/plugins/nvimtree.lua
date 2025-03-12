local function init()
  local setkey = vim.keymap.set
  setkey("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree Toggle" })
end

return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  init = init,
}

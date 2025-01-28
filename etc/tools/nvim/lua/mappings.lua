require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>fh")
unmap("n", "<leader>fm")
unmap("n", "<leader>fo")
unmap("n", "<leader>fw")
unmap("n", "<leader>fz")
unmap("n", "<leader>fa")
unmap("n", "<leader>ff")
unmap("n", "<leader>fb")

map("n", "<leader>f", "za")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

map("n", ";", ":", { desc = "CMD enter command mode" })

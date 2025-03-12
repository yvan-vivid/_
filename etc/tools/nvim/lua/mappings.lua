local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Insert mode motions
--------------------------------------------------------------------------------
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

--------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

--------------------------------------------------------------------------------
-- Features
--------------------------------------------------------------------------------
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

map("n", "<leader>f", "za")
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

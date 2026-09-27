local map = vim.keymap.set

-------------------------------------------------------------------------------
-- Insert mode motions
-------------------------------------------------------------------------------
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-------------------------------------------------------------------------------
-- Tabs
-------------------------------------------------------------------------------
local tabufline = require "nvchad.tabufline"

-- TODO: Are these good? Do I need to eager load the require?
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<tab>", tabufline.next, { desc = "buffer goto next" })
map("n", "<S-tab>", tabufline.prev, { desc = "buffer goto prev" })
map("n", "<leader>x", tabufline.close_buffer, { desc = "buffer close" })

-------------------------------------------------------------------------------
-- Features
-------------------------------------------------------------------------------
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

map("n", "<leader>f", "za")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-------------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------------
local function open_diagnostics()
  vim.diagnostic.open_float(nil, {
    scope = "cursor",
    focusable = false,
  })
end

map("n", "<leader>ds", open_diagnostics, { desc = "LSP diagnostic loclist" })

-------------------------------------------------------------------------------
-- Snacks picker
-------------------------------------------------------------------------------
local snacks = require "snacks"

-- Files
map("n", "<leader><leader>f", snacks.picker.files, { desc = "Find files" })
map("n", "<leader><leader>b", snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader><leader>o", snacks.picker.recent, { desc = "Recent files" })
map("n", "<leader><leader>a", function()
  snacks.picker.files { hidden = true, no_ignore = true }
end, { desc = "Find all files" })

-- Git
map("n", "<leader><leader>gf", snacks.picker.git_files, { desc = "Git files" })
map("n", "<leader><leader>gl", snacks.picker.git_log, { desc = "Git log" })
map("n", "<leader><leader>gs", snacks.picker.git_status, { desc = "Git status" })

-- Editing
map("n", "<leader><leader>m", snacks.picker.marks, { desc = "Marks" })
map("n", "<leader><leader>g", snacks.picker.grep, { desc = "Grep" })
map("n", "<leader><leader>h", snacks.picker.help, { desc = "Help tags" })

-- Explorer
map("n", "<leader>e", snacks.explorer.open, { desc = "File explorer" })

-- UI
map("n", "<leader>U", function()
  require("nvchad.themes").open()
end, { desc = "Themes" })
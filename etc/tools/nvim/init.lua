vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

require "bootstrap"

-- load lazy
require("lazy").setup(require "configs.lazy")

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "usercmds"
require "autocmds"
require "mappings"

vim.g.mapleader = " "

-- startup
(require "lib.lazy")()

require "options"
require "usercmds"
require "autocmds"
require "mappings"
require "lsp"

require("lib.diagnostics").standard()

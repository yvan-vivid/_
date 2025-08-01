vim.g.mapleader = " "

-- startup
(require "configs.lazy")()

-- load theme
local base46 = (require "lib.base46")()
base46.load_cached "defaults"
base46.load_cached "statusline"

require "options"
require "usercmds"
require "autocmds"
require "mappings"

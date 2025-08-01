local base46 = (require "lib.base46")()

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = function()
    base46.load_cached "devicons"
    return { override = require "nvchad.icons.devicons" }
  end,
}

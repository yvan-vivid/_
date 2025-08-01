local base46 = (require "lib.base46")()

return {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  opts = function()
    base46.load_cached "git"
    return {
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    }
  end,
}

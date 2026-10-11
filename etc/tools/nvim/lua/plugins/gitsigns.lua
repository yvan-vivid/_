return {
  "lewis6991/gitsigns.nvim",
  event = "User FilePost",
  opts = function()
    return {
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    }
  end,
}

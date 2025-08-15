return {
  "chrisgrieser/nvim-origami",
  event = "VeryLazy",
  opts = {}, -- needed even when using default config
  init = function()
    vim.opt.foldlevel = 0
    vim.opt.foldlevelstart = -1
  end,
}

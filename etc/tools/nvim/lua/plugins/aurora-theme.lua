return {
  "ray-x/aurora",
  lazy = false,
  init = function()
    vim.g.aurora_italic = 1
    vim.g.aurora_transparent = 1
    vim.g.aurora_bold = 1
  end,
  config = function()
    vim.cmd.colorscheme "aurora"
  end,
}

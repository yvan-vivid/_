local colors_bg = {
  "#800000",
  "#700050",
  "#300080",
  "#005080",
  "#006000",
  "#606000",
}

local heading_fg_hi = {}
local heading_bg_hi = {}
for i = 1, 6 do
  heading_fg_hi[i] = string.format("HeaderFg%i", i)
  heading_bg_hi[i] = string.format("HeaderBg%i", i)
end

local color_fg = "#FFFFFF"
-- local color_sign = "#ebfafa"

local init = function()
  for index, value in ipairs(colors_bg) do
    vim.api.nvim_set_hl(0, heading_bg_hi[index], {
      fg = color_fg,
      bg = value,
    })
    vim.api.nvim_set_hl(0, heading_fg_hi[index], {
      fg = value,
      bold = true,
    })
  end
end

local options = {
  heading = {
    sign = true,
    icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
    backgrounds = heading_bg_hi,
    foregrounds = heading_fg_hi,
  },
  latex = { enabled = false },
}

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "norg", "org", "rmd" },
  opts = options,
  init = init,
}

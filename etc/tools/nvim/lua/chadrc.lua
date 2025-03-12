---@type ChadrcConfig
local M = {}

M.base46 = {
  -- Used to alter an existing theme
  -- changed_themes = { tokyodark = { ... } },

  theme = "tokyonight",
  theme_toggle = { "tokyonight", "dark_horizon", "one_light", "radium", "rosepine", "rosepine-dawn" },
  transparency = true,

  hl_add = {},
  hl_override = {
    Comment = { fg = "#8090B0", italic = true },
    ["@comment"] = { fg = "#8090B0", italic = true },
    Normal = { fg = "#00FF30" },
    Folded = { fg = "#A696A6", bg = "transparent" },
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
    NvimTreeGitFileIgnoredHL = { fg = "#708060" },
  },
}

M.ui = {
  tabufline = {
    enabled = false,
  },
  lsp_semantic_tokens = true,
}

return M

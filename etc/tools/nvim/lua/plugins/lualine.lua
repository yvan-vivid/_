local options = {
  theme = "auto",
  globalstatus = true,
  section_separators = { left = "", right = "" },
  component_separators = { left = "", right = "" },
  disabled_filetypes = {
    statusline = { "alpha", "dashboard", "Nvdash", "snacks_dashboard" },
  },
}

local sections = {
  lualine_a = { "mode" },
  lualine_b = {
    "branch",
    {
      "diff",
      symbols = { added = " ", modified = " ", removed = " " },
    },
  },
  lualine_c = {
    {
      "filename",
      path = 1,
      symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
    },
    {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
    },
  },
  lualine_x = {
    "encoding",
    "fileformat",
    "filetype",
  },
  lualine_y = { "progress" },
  lualine_z = { "location" },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = function()
    return {
      options = options,
      sections = sections,
    }
  end,
}

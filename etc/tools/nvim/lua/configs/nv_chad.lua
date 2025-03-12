local o = vim.o

local function config()
  require "nvchad.options"
  o.cursorlineopt = "both"
end

return {
  "NvChad/NvChad",
  lazy = false,
  branch = "v2.5",
  import = "nvchad.plugins",
  config = config,
}

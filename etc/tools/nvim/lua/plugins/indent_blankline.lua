local base46 = (require "lib.base46")()
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "User FilePost",
  opts = {
    indent = { char = "│", highlight = "IblChar" },
    scope = { char = "│", highlight = "IblScopeChar" },
  },
  config = function(_, opts)
    base46.load_cached "blankline"
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    require("ibl").setup(opts)
    base46.load_cached "blankline"
  end,
}

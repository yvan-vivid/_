return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  spec = {
    require "configs.nv_chad",
    { import = "plugins" },
  },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = require "configs.disabled_plugins",
    },
  },
}

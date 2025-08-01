local config = {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  spec = {
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

local function boostrap()
  local paths = require "lib.paths"
  local lazypath = paths.data "lazy/lazy.nvim"
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system { "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath }
  end
  vim.opt.rtp:prepend(lazypath)
end

return function()
  boostrap()
  require("lazy").setup(config)
end

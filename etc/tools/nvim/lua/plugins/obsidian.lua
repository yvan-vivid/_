local opts = {
  daily_notes = {
    folder = "log/phased",
    default_tags = { "log-phased" },
  },
  workspaces = {
    {
      name = "discourse",
      path = "/src/repos/me/discourse/notes/discourse",
    },
  },
  picker = {
    name = "telescope.nvim",
    note_mappings = {
      new = "<C-x>",
      insert_link = "<C-l>",
    },
    tag_mappings = {
      tag_note = "<C-x>",
      insert_tag = "<C-l>",
    },
  },
}

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = opts,
    enabled = false,
  },
}

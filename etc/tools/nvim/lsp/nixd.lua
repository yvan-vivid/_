---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        -- expr = "",
      },
      options = {
        nixos = {
          -- expr = "",
        },
      },
    },
  },
}

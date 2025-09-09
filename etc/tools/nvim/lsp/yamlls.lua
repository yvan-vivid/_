---@brief
---
--- https://github.com/redhat-developer/yaml-language-server
---
--- To use a schema for validation, there are two options:
--- 1. Add a modeline to the file. A modeline is a comment of the form:
---
--- ```
--- # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>
--- ```
--- 2. Associated a schema url, relative , or absolute (to root of project, not to filesystem root) path to
--- the a glob pattern relative to the detected project root. Check `:checkhealth vim.lsp` to determine the resolved project root.

---@type vim.lsp.Config
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
  root_markers = { ".git" },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = { enable = true },
      schemas = {},
    },
  },
  on_init = function(client)
    --- https://github.com/neovim/nvim-lspconfig/pull/4016
    --- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
    --- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
    --- autocmd's which check this capability
    client.server_capabilities.documentFormattingProvider = true
  end,
}

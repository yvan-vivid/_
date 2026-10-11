return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require "lint"
    lint.linters_by_ft = {
      python = { "ruff" },
      --javascript = { "eslint_d" },
      --typescript = { "eslint_d" },
      --javascriptreact = { "eslint_d" },
      --typescriptreact = { "eslint_d" },
      --json = { "jsonlint" },
      --yaml = { "yamllint" },
      --markdown = { "markdownlint" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      --dockerfile = { "hadolint" },
      --nix = { "statix" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      lint.try_lint()
    end, { desc = "Trigger linting" })
  end,
}

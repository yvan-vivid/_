# AGENTS.md — Neovim Config Design Notes

## Design Philosophy

**Minimal, modern, native-first.** Prefer built-in Neovim features over plugins. Use plugins only for:
- Package management (lazy.nvim)
- LSP configuration presets (nvim-lspconfig)
- Completion (blink.cmp)
- Formatting/linting (conform.nvim, nvim-lint)
- Git (gitsigns, neogit)
- Testing (neotest)
- UI polish (snacks.nvim, treesitter-textobjects)

## Intentional Choices

| Area | Choice | Rationale |
|------|--------|-----------|
| **Plugin manager** | lazy.nvim | Mature, fast, good lazy-loading |
| **LSP** | nvim-lspconfig + native `vim.lsp.config` | Battle-tested defaults, minimal custom config |
| **Completion** | blink.cmp | Fast Rust backend, LSP + snippet + path sources |
| **File explorer** | snacks.explorer | Built into snacks, replaces nvim-tree |
| **Fuzzy finder** | snacks.picker | Replaces telescope, ivy layout |
| **Terminal FM** | yazi.nvim | Kept for complex file ops (`<leader>E`) |
| **Formatting** | conform.nvim | Format on save, LSP fallback |
| **Linting** | nvim-lint | Async, runs on BufEnter/WritePost/InsertLeave |
| **Treesitter** | nvim-treesitter + manager | Native highlighting, indent, folding; auto-install |
| **Textobjects** | nvim-treesitter-textobjects | `af`/`if`, `ac`/`ic`, `]f`/`[f`, etc. |
| **Git signs** | gitsigns.nvim | Minimal, fast |
| **Git porcelain** | neogit + diffview | Snacks picker integration |
| **Testing** | neotest + adapters | Rust (rustaceanvim), Python |
| **UI theme** | nvchad/base46 + nvchad/ui | Intentional: batteries-included theme + tabline/statusline |
| **Markdown** | render-markdown.nvim | Pretty rendering, disabled latex |

## Keybinding Principles

1. **Double-tap leader for search** — `<leader><leader>f` (files), `<leader><leader>b` (buffers), `<leader><leader>g` (grep)
2. **Single leader for actions** — `<leader>e` (explorer), `<leader>cl` (lint), `<leader>=` (format)
3. **Stick with mostly native LSP defaults where they exist** — `K`, `gd`, `grn`, `gra`, `grr`, `gO`, `[d`/`]d`
4. **Rust-enhanced via rustaceanvim** — `K` (hover+actions), `<leader>kl` (codeAction)

## Rules of Thumb

- **Before adding a plugin:** Is there a native alternative? (snacks, mini.nvim, built-in LSP)
- **Before custom keymap:** Does Neovim 0.11+ provide a default? Check `:help lsp-defaults`
- **LSP config:** Override only what's needed in `lua/lsp.lua` via `vim.lsp.config("name", {})`
- **Formatters/linters:** Define in `conform.lua` / `lint.lua` by filetype; prefer single tools (ruff, biome)
- **Treesitter parsers:** Trim `configs/treesitter_parsers.lua` to only used languages
- **Disabled plugins:** Re-enable `matchit` (for `%`), `syntax` (fallback highlighting)
- **Dependencies:** Audit lazy-lock.json periodically; remove unused

## File Structure

```
init.lua                    # Entry point
lua/
  configs/
    lazy.lua                # lazy.nvim bootstrap + config
    disabled_plugins.lua    # Built-in plugins to disable
    treesitter_parsers.lua  # Ensure-installed parsers
  lib/
    base46.lua              # Theme/highlight loader
    diagnostics.lua         # Diagnostic config (virtual_text + virtual_lines)
    lsp/keys.lua            # LSP keymaps (minimal, custom only)
    paths.lua               # Path helpers
  plugins/
    *.lua                   # One file per plugin
  lsp.lua                   # LSP setup + custom server configs
  mappings.lua              # Global keymaps
  options.lua               # vim.o / vim.opt settings
  autocmds.lua              # Autocommands
  usercmds.lua              # User commands
lsp/                        # Empty (using nvim-lspconfig defaults)
```

## Maintenance

- `:Lazy sync` after plugin changes
- `:checkhealth` for LSP/lint/format issues
- Update parsers: `:TSUpdate`
- Review `lazy-lock.json` for stale deps

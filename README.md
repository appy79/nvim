# nvim

Personal Neovim configuration, organized under the `appy` Lua namespace and
managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim 0.11+
- `git`
- A [Nerd Font](https://www.nerdfonts.com/) (for diagnostic and UI icons)
- `ripgrep` (Telescope live grep)
- Node.js (for `prettier`, `eslint_d`, and `mcp-hub`)
- Python 3 (for `black`, `isort`, `pylint`)

## Install

```bash
git clone <this-repo> ~/.config/nvim
nvim
```

On first launch, lazy.nvim bootstraps itself and installs all plugins, and
Mason auto-installs the configured LSP servers and formatting/linting tools.

## Layout

```
init.lua                  -- entry point
lua/appy/
  core/                   -- options and keymaps
  lazy.lua                -- lazy.nvim bootstrap + setup
  plugins/                -- plugin specs (one file per plugin)
  plugins/lsp/            -- mason + lspconfig
  scripts/                -- custom user commands (e.g. FormatProject)
```

## Highlights

- Leader key is `<Space>`.
- LSP via `nvim-lspconfig` + Mason, completion via `nvim-cmp`.
- Formatting via `conform.nvim` (format on save) and linting via `nvim-lint`.
- `:FormatProject` formats every git-tracked file that has a formatter.
- AI assistance via `avante.nvim` (Cursor ACP provider) and `mcphub.nvim`.

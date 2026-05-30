# Neovim Configuration Guidelines

This document outlines the structure, conventions, and maintenance guidelines for this Neovim configuration.

## Project Structure
- `init.lua`: Main entry point, requires base modules.
- `lua/`: Configuration modules.
  - `options.lua`: Global editor settings (`vim.opt`).
  - `autocmds.lua`: Autocommand definitions.
  - `keymap.lua`: Keybindings.
  - `lazy-setup.lua`: `lazy.nvim` plugin manager setup.
  - `lsp.lua`: Language Server Protocol configuration.
  - `plugins/`: Plugin-specific configurations, automatically imported by `lazy.nvim`.
  - `utils.lua`: Shared utility functions.
  - `gemini.lua`: Gemini CLI integration.
  - `raku.lua`: Raku language terminal integration.

## Development Conventions
- **Plugins:** New plugins should be added as individual files within `lua/plugins/` to maintain modularity.
- **Naming:** Keep filenames in `lua/` descriptive and lowercase.
- **Modularity:** Keep core logic separated: options, mappings, and autocmds should not be cluttered with plugin-specific logic.
- **Utils:** Common helper functions should be placed in `lua/utils.lua` and required where needed, avoiding global (`_G`) variables.
- **Keymaps:** Centralize keybinding definitions in `lua/keymap.lua`. Plugin-specific keybindings should be moved here to keep plugin configurations clean.

## Maintenance
- **Lazy.nvim:** Use `lazy.nvim` for all plugin management.
- **LSP:** Configure new language servers within `lua/lsp.lua`.
- **Validation:** Ensure new configurations are required in `init.lua` if they are core settings, or just added to `lua/plugins/` to be automatically loaded.

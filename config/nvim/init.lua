require("options")
require("neovide")
require("autocmds")
require("keymap")
require("lazy-setup")
require("lsp")
require("gemini_custom").setup()
require("raku").setup()

local utils = require("utils")

-- Run once on startup
utils.sync_theme()

-- Safely load solarized
local status_ok, solarized = pcall(require, "solarized")
if status_ok then
	solarized.setup() -- Removed 'opts' as it was undefined
	vim.cmd.colorscheme 'solarized'
else
	vim.cmd.colorscheme 'default'
end

local status_ok, lualine = pcall(require, "lualine")
if status_ok then
	lualine.setup()
end


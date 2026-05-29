require("options")
require("autocmds")
require("keymap")
require("lazy-setup")
require("lsp")
require("neovide")

-- Shared global function so autocmds.lua can access it later
_G.sync_theme = function()
    local is_mac = vim.fn.has("macunix") == 1
    local background = 'light'

    if is_mac then
        local macos_theme = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if macos_theme:find("Dark") then
            background = 'dark'
        end
    end

    vim.o.background = background
end

-- Run once on startup
_G.sync_theme()

-- Safely load solarized
local status_ok, solarized = pcall(require, "solarized")
if status_ok then
    solarized.setup(opts)
    vim.cmd.colorscheme 'solarized'
else
    vim.cmd.colorscheme 'default'
end

local status_ok, lualine = pcall(require, "lualine")
if status_ok then
  lualine.setup()
end


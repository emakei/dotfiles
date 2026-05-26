require("options")
require("keymap")
require("lazy-setup")
require("lsp")

local status_ok, lualine = pcall(require, "lualine")
if status_ok then
  lualine.setup()
end

vim.g.mapleader = ","

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"

-- Auto-reload files when changed on disk
vim.o.autoread = true
-- Faster update time for CursorHold (default is 4000ms)
vim.o.updatetime = 300

-- Sync nvim buffer with OS
vim.opt.clipboard = "unnamedplus"

-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.o.pumheight = 10

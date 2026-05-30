local map = vim.keymap.set

map("n", "<leader>q", ":q<CR>")
map("n", "<leader>Q", ":q!<CR>")
map("n", "<leader>bn", ":bn<CR>")
map("n", "<leader>bp", ":bp<CR>")

-- NeoTree Keymaps
map("n", "<leader>n", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })

-- LSP Keymaps
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- Flutter Keymaps
map("n", "<leader>fr", ":FlutterRun<CR>", { silent = true, desc = "Flutter Run" })
map("n", "<leader>fh", ":FlutterHotReload<CR>", { silent = true, desc = "Flutter Hot Reload" })
map("n", "<leader>fR", ":FlutterHotRestart<CR>", { silent = true, desc = "Flutter Hot Restart" })
map("n", "<leader>fd", ":FlutterDevices<CR>", { silent = true, desc = "Flutter Devices" })
map("n", "<leader>fq", ":FlutterQuit<CR>", { silent = true, desc = "Flutter Quit" })

-- Telescope Keymaps
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Neoclip Keymaps
map("n", "<leader>p", ":Telescope neoclip<CR>", { silent = true, desc = "Clipboard History" })

-- Diff keymaps
map("n", "<leader>do", ":DiffOrig<CR>", { desc = "Diff buffer with file on disk" })

-- Minty Keymaps
map("n", "<leader>cs", ":Shades<CR>", { silent = true, desc = "Minty Shades" })
map("n", "<leader>ch", ":Huefy<CR>", { silent = true, desc = "Minty Huefy" })

-- Window Management
map("n", "<leader>wv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>ws", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>wc", ":close<CR>", { desc = "Close current window" })
map("n", "<leader>wo", ":only<CR>", { desc = "Close all other windows" })
map("n", "<leader>wh", "<C-w>h", { desc = "Move focus left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Move focus down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Move focus up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Move focus right" })
map("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows" })
map("n", "<leader>wx", "<C-w>x", { desc = "Swap current window" })

-- Diagnostic Keymaps
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
map("n", "<leader>td", builtin.diagnostics, { desc = "Telescope diagnostics" })

-- ToggleTerm Keymaps
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm Horizontal" })
map("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "ToggleTerm Vertical" })
map("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { desc = "ToggleTerm Float" })

-- Terminal Management Keymaps
map("n", "<leader>ts", ":TermSelect<CR>", { desc = "Select Terminal" })

-- Send to Terminal Keymaps
map("n", "<leader>st", "<cmd>ToggleTermSendCurrentLine<cr>", { desc = "Send current line to terminal" })
map("v", "<leader>st", "<cmd>ToggleTermSendVisualSelection<cr>", { desc = "Send visual selection to terminal" })

-- Gemini Keymaps
map("n", "<leader>tg", "<cmd>Gemini<cr>", { desc = "Toggle Gemini" })

-- Raku Keymaps
map("n", "<leader>tr", "<cmd>Raku<cr>", { desc = "Toggle Raku" })

-- Markdown Keymaps
map("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Preview" })

-- Bookmarks Keymaps
map("n", "mm", "<cmd>BookmarksMark<cr>", { desc = "Toggle Bookmark" })
map("n", "ma", "<cmd>BookmarksAnnotate<cr>", { desc = "Annotate Bookmark" })
map("n", "mc", "<cmd>BookmarksClear<cr>", { desc = "Clear Bookmarks" })
map("n", "ml", "<cmd>BookmarksList<cr>", { desc = "List Bookmarks" })

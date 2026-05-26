local map = vim.keymap.set

map("n", "<leader>q", ":q<CR>")
map("n", "<leader>Q", ":q!<CR>")
map("n", "<leader>bn", ":bn<CR>")
map("n", "<leader>bp", ":bp<CR>")

-- NeoTree Keymaps
map('n', '<leader>n', ':Neotree<CR>', { silent = true })
map('n', '<C-b>', ':Neotree toggle<CR>', { silent = true })

-- LSP Keymaps
map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP definition' })
map({'n', 'x'}, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP code action' })

-- Flutter Keymaps
map("n", "<leader>fr", ":FlutterRun<CR>", { silent = true, desc = "Flutter Run" })
map("n", "<leader>fh", ":FlutterHotReload<CR>", { silent = true, desc = "Flutter Hot Reload" })
map("n", "<leader>fR", ":FlutterHotRestart<CR>", { silent = true, desc = "Flutter Hot Restart" })
map("n", "<leader>fd", ":FlutterDevices<CR>", { silent = true, desc = "Flutter Devices" })
map("n", "<leader>fq", ":FlutterQuit<CR>", { silent = true, desc = "Flutter Quit" })

-- Telescope Keymaps
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


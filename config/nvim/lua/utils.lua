local M = {}

M.sync_theme = function()
    local is_mac = vim.fn.has("macunix") == 1
    local background = 'light'

    if is_mac then
        local macos_theme = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if macos_theme:find("Dark") then
            background = 'dark'
        end
    end

    vim.opt.background = background
end

M.set_terminal_keymaps = function()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

return M

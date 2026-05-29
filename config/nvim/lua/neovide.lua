-- lua/neovide.lua

if vim.g.neovide then
    -- Neovide specific settings
    vim.o.guifont = "JetBrains Mono:h14"
    vim.g.neovide_opacity = 0.95
    vim.g.neovide_cursor_animation_length = 0.13
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_hide_mouse_when_typing = true
end


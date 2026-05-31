if vim.g.neovide then
	-- Font settings
	vim.o.guifont = "JetBrains Mono:h14"

	-- Transparency
	vim.g.neovide_opacity = 0.9
	vim.g.transparency = 0.9

	-- Refresh rate
	vim.g.neovide_refresh_rate = 60

	-- Cursor settings
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_animate_in_insert_mode = true

	-- Floating blur
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0

	-- Input settings
	vim.g.neovide_input_use_logo = true -- macOS Cmd key support

	-- Scale
	vim.g.neovide_scale_factor = 1.0
end

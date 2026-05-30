-- lua/raku.lua

local M = {}

M.setup = function()
	local ok, toggleterm = pcall(require, "toggleterm.terminal")
	if not ok then
		vim.notify("toggleterm.nvim not found, Raku command disabled", vim.log.levels.ERROR)
		return
	end

	local Terminal = toggleterm.Terminal
	local raku = Terminal:new({
		cmd = "raku",
		direction = "float",
		float_opts = {
			border = "curved",
		},
		close_on_exit = true,
	})

	vim.api.nvim_create_user_command("Raku", function()
		raku:toggle()
	end, { desc = "Open Raku in a floating window" })
end

return M

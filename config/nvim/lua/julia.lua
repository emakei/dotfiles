-- lua/julia.lua

local M = {}

M.setup = function()
	local ok, toggleterm = pcall(require, "toggleterm.terminal")
	if not ok then
		vim.notify("toggleterm.nvim not found, Julia command disabled", vim.log.levels.ERROR)
		return
	end

	local Terminal = toggleterm.Terminal
	local julia = Terminal:new({
		cmd = "julia",
		direction = "float",
		float_opts = {
			border = "curved",
		},
		close_on_exit = true,
	})

	vim.api.nvim_create_user_command("Julia", function()
		julia:toggle()
	end, { desc = "Open Julia in a floating window" })
end

return M

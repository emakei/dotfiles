return {
	{
		"nvim-flutter/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("flutter-tools").setup({
				lsp = {
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
					},
				},
				debugger = {
					enabled = true,
					run_via_dap = true,
				},
				widget_guides = {
					enabled = true,
				},
				closing_tags = {
					highlight = "Comment",
					prefix = "// ",
					enabled = true,
				},
			})
		end,
	},
}

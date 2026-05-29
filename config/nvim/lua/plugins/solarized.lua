return {
	'maxmx03/solarized.nvim',
	lazy = false,
	priority = 1000,
	---@type solarized.config
	opts = {},
	config = function()
		require("solarized").setup({
                variant = "spring", -- Options: spring, summer, autumn, winter
                styles = {
                    comments = { italic = true },
                    keywords = { bold = true },
                },
            })
    end
}


-- LSP Configuration

-- Helper to set up LSP
if vim.lsp.config then
	-- Neovim 0.11+ API

	-- Diagnostic Configuration
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
	})

	-- Dart
	vim.lsp.config("dartls", {
		cmd = { "dart", "language-server", "--protocol=lsp" },
		init_options = {
			closingLabels = true,
			outline = true,
			flutterOutline = true,
		},
	})
	vim.lsp.enable("dartls")

	-- Go
	vim.lsp.config("gopls", {
		settings = {
			gopls = {
				analyses = { unusedparams = true },
				staticcheck = true,
			},
		},
	})
	vim.lsp.enable("gopls")

	-- Julia
	vim.lsp.config("julials", {})
	vim.lsp.enable("julials")

	-- Node.js/JavaScript/TypeScript
	vim.lsp.config("ts_ls", {})
	vim.lsp.enable("ts_ls")

	-- Fish shell
	vim.lsp.config("fish_lsp", {})
	vim.lsp.enable("fish_lsp")

	-- Rust
	vim.lsp.config("rust_analyzer", {})
	vim.lsp.enable("rust_analyzer")
else
	-- Fallback for Neovim 0.8 - 0.10
	local status_ok, lspconfig = pcall(require, "lspconfig")
	if status_ok then
		-- Dart
		lspconfig.dartls.setup({
			cmd = { "dart", "language-server", "--protocol=lsp" },
			settings = {
				closingLabels = true,
				outline = true,
				flutterOutline = true,
			},
		})

		-- Go
		lspconfig.gopls.setup({
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
				},
			},
		})

		-- Julia
		lspconfig.julials.setup({})

		-- Node.js/JavaScript/TypeScript
		lspconfig.ts_ls.setup({})

		-- Fish shell
		lspconfig.fish_lsp.setup({})
	end
end

-- Включение LSP document_color (conditional support)
if vim.lsp.document_color then
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then
				return
			end

			-- Enable native auto-completion
			if client.supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			local caps = client.server_capabilities
			if caps and caps.colorProvider then
				-- Используем функцию enable, если она есть, иначе просто не включаем
				if type(vim.lsp.document_color.enable) == "function" then
					vim.lsp.document_color.enable(args.buf)
				end
			end
		end,
	})
end

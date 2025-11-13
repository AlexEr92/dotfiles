-- LSP Configuration plugin
-- Provides Language Server Protocol support for various programming languages
return {
	{
		"neovim/nvim-lspconfig",
		-- Load LSP config when opening or creating files, or before writing
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			-- Load custom LSP configuration functions from configs directory
			local on_attach = require("configs.lspconfig").on_attach
			local on_init = require("configs.lspconfig").on_init
			local capabilities = require("configs.lspconfig").capabilities

			-- List of LSP servers to configure
			-- Each server will be set up with the same on_attach, on_init, and capabilities
			local servers = {
				"clangd", -- C/C++ language server
				"cmake", -- CMake language server
				"rust_analyzer", -- Rust language server
				"pyright", -- Python language server
				"gopls", -- Go language server
				"bashls", -- Bash language server
			}

			-- Configure all LSP servers in the list
			-- Using new vim.lsp.config API (replaces deprecated require('lspconfig'))
			for _, lsp in ipairs(servers) do
				vim.lsp.config(lsp, {
					on_attach = on_attach,
					on_init = on_init,
					capabilities = capabilities,
				})
			end

			-- Special configuration for Lua language server
			-- Requires additional settings to recognize Neovim's built-in 'vim' global
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				on_init = on_init,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								"vim", -- Tell lua_ls that 'vim' is a valid global (Neovim API)
							},
						},
					},
				},
			})
		end,
	},
}

-- LSP Configuration plugin for Neovim 0.11+
-- Provides Language Server Protocol support for various programming languages
return {
	{
		"neovim/nvim-lspconfig",
		-- Loaded as dependency of mason-lspconfig (lazy = false)
		-- LSP config is initialized early to ensure servers are configured before files are opened
		dependencies = {
			-- cmp-nvim-lsp is needed for enhanced LSP capabilities with nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("configs.lspconfig").setup()
		end,
	},
}

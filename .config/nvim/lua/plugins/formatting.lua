-- Conform.nvim - Code formatting plugin
-- Provides formatting for various languages
-- Use :Format command (defined in core/usercommands.lua) to format code
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Format on save
	config = function()
		require("conform").setup({
			-- Formatters for each file type
			formatters_by_ft = {
				lua = { "stylua" }, -- Lua formatter
				c = { "clang-format" }, -- C formatter
				cpp = { "clang-format" }, -- C++ formatter
				python = { "black", "isort" }, -- Python formatters
				rust = { "rustfmt" }, -- Rust formatter
				go = { "gofmt", "goimports" }, -- Go formatters
				javascript = { "prettier" }, -- JavaScript formatter
				typescript = { "prettier" }, -- TypeScript formatter
				json = { "prettier" }, -- JSON formatter
				html = { "prettier" }, -- HTML formatter
				css = { "prettier" }, -- CSS formatter
				markdown = { "prettier" }, -- Markdown formatter
				yaml = { "prettier" }, -- YAML formatter
				bash = { "shfmt" }, -- Bash formatter
				sh = { "shfmt" }, -- Shell formatter
			},
			-- Format on save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true, -- Fall back to LSP formatting if formatter not available
			},
		})
	end,
}

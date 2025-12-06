-- LSP Configuration Module for Neovim 0.11+
-- Defines shared configuration for all LSP servers including:
-- - Diagnostic display settings
-- - Client capabilities for enhanced features
-- - LspAttach autocommand for setting up key mappings
-- Uses new vim.lsp.config() API instead of deprecated require('lspconfig')
-- Note: Key mappings are defined in core/mappings.lua
local M = {}

-- Called when LSP client initializes
-- Disables semantic tokens to avoid conflicts with Treesitter highlighting
local function on_init(client, _)
	-- Check if client supports semantic tokens and disable if needed
	-- Use the correct method based on Neovim version
	if vim.fn.has("nvim-0.11") == 1 then
		if client:supports_method("textDocument/semanticTokens") then
			client.server_capabilities.semanticTokensProvider = nil
		end
	else
		if client.supports_method("textDocument/semanticTokens") then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end
end

-- Enhanced LSP client capabilities
-- Start with base capabilities and extend with nvim-cmp support
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add nvim-cmp specific capabilities for better completion integration
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Additional enhanced completion item support
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" }, -- Support both markdown and plaintext docs
	snippetSupport = true,                              -- Support code snippets in completions
	preselectSupport = true,                            -- Support preselecting items
	insertReplaceSupport = true,                        -- Support insert/replace mode
	labelDetailsSupport = true,                          -- Support detailed labels
	deprecatedSupport = true,                            -- Show deprecated items
	commitCharactersSupport = true,                      -- Support commit characters
	tagSupport = { valueSet = { 1 } },                   -- Support completion tags
	resolveSupport = {
		properties = {
			"documentation",        -- Resolve documentation on demand
			"detail",               -- Resolve details on demand
			"additionalTextEdits",  -- Resolve additional edits on demand
		},
	},
}

-- Local function to configure diagnostic display settings
local function diagnostic_config()
	local severity = vim.diagnostic.severity

	-- Configure diagnostic display settings
	vim.diagnostic.config({
		virtual_text = false,      -- Don't show diagnostics inline
		signs = {
			text = {
				[severity.ERROR] = "󰅙",
				[severity.WARN] = "",
				[severity.INFO] = "󰋼",
				[severity.HINT] = "󰌵"
			}
		},
		float = { border = "single" },
		underline = true,         -- Underline errors in buffer
		update_in_insert = false, -- Don't update diagnostics while typing
	})
end

-- Local function to set up LSP key mappings when client attaches
local function on_attach(bufnr)
	-- Set up LSP key mappings (defined in core/mappings.lua)
	local mappings = require("core.mappings")
	if mappings.setup_lsp_keymaps then
		mappings.setup_lsp_keymaps(bufnr)
	end
end

-- setup: Sets up global LSP configuration and LspAttach autocommand
-- This should be called once during Neovim initialization
-- For Neovim 0.11+, we use LspAttach autocommand instead of on_attach in vim.lsp.config()
M.setup = function()
	-- Configure diagnostic display settings
	diagnostic_config()
	-- Create LspAttach autocommand to configure diagnostics and key mappings when LSP client attaches
	-- This is the recommended approach for Neovim 0.11+
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			-- args.buf is the buffer number where LSP attached
			on_attach(args.buf)
		end,
	})

	-- Special configuration for Lua language server
	-- Requires additional settings to recognize Neovim's built-in 'vim' global
	vim.lsp.config("lua_ls", {
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
	-- Configure all LSP servers with default capabilities and on_init
	vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
end

return M

-- LSP Configuration Module
-- Defines shared configuration for all LSP servers including:
-- - Diagnostic display settings
-- - Client capabilities for enhanced features
-- Note: Key mappings are defined in core/mappings.lua
local M = {}

-- on_attach: Called when LSP client attaches to a buffer
-- Configures diagnostic display and triggers LSP key mappings setup
M.on_attach = function(_, bufnr)
	-- Configure diagnostic display settings
	vim.diagnostic.config({
		virtual_text = false,      -- Don't show diagnostics inline
		signs = true,             -- Show diagnostic signs in gutter
		underline = true,         -- Underline errors in buffer
		update_in_insert = false, -- Don't update diagnostics while typing
	})

	-- Set up LSP key mappings (defined in core/mappings.lua)
	local mappings = require("core.mappings")
	if mappings.setup_lsp_keymaps then
		mappings.setup_lsp_keymaps(bufnr)
	end
end

-- on_init: Called when LSP client initializes
-- Disables semantic tokens to avoid conflicts with Treesitter highlighting
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- capabilities: Enhanced LSP client capabilities
-- Extends default capabilities with additional features for better completion
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enhanced completion item support
M.capabilities.textDocument.completion.completionItem = {
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

return M

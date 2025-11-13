-- FzfLua plugin
-- Fast and powerful fuzzy finder using fzf
-- Provides file search, live grep, buffers, and more
-- Key mappings are defined in core/mappings.lua
return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icon support
	lazy = false,
	config = function()
		local fzf_lua = require("fzf-lua")
		-- Basic configuration
		-- FzfLua works out of the box, but you can customize here if needed
		fzf_lua.setup({
			-- Add custom configuration here if needed
			-- Most settings work well with defaults
		})

		-- Key mappings are set up in core/mappings.lua
		local mappings = require("core.mappings")
		if mappings.setup_fzflua_keymaps then
			mappings.setup_fzflua_keymaps()
		end
	end,
}

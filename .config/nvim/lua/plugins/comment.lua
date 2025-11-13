-- Comment.nvim plugin
-- Provides easy commenting and uncommenting of code
-- Key mappings are defined in core/mappings.lua
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("Comment").setup({
			-- Enable basic configuration
			-- Most features work well with defaults
			padding = true, -- Add space between comment and line
			sticky = true, -- Keep cursor on current line when toggling
			ignore = "^$", -- Don't comment empty lines
			-- Operator-pending mappings
			-- These are used internally by the plugin
			toggler = {
				line = "gcc", -- Toggle comment for current line
				block = "gbc", -- Toggle comment for current block
			},
			-- Extra mappings (used in visual mode)
			opleader = {
				line = "gc", -- Comment operator for lines
				block = "gb", -- Comment operator for blocks
			},
		})

		-- Key mappings are set up in core/mappings.lua
		local mappings = require("core.mappings")
		if mappings.setup_comment_keymaps then
			mappings.setup_comment_keymaps()
		end
	end,
}

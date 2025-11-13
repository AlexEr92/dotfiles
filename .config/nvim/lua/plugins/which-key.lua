-- Which-key plugin
-- Displays keybindings popup when pressing keys with descriptions
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		-- Enable timeout for key sequences (required for which-key to work)
		vim.o.timeout = true
		-- Time to wait for next keypress in a sequence (in milliseconds)
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- Default options for which-key
		-- You can customize appearance and behavior here if needed
	},
}

-- Navigation plugins
-- Provides enhanced navigation capabilities for faster movement in buffers
return {
	-- Hop.nvim - EasyMotion-like navigation
	-- Jump to any word or line in the buffer with visual hints
	-- Key mappings are defined in core/mappings.lua:
	--   <leader><leader>w - Hop word after cursor
	--   <leader><leader>b - Hop word before cursor
	{
		"smoka7/hop.nvim",
		cmd = { "HopWordAC", "HopWordBC" }, -- Load when commands are used
		version = "*",
		config = function()
			require("hop").setup({
				-- Basic configuration
				-- Most settings work well with defaults
				-- You can customize keys, colors, and behavior here if needed
			})
		end,
	},

	-- vim-unimpaired - Additional useful mappings
	-- Provides pairs of mappings for common operations
	-- Key mappings (work automatically, no configuration needed):
	--   [b / ]b - previous/next buffer
	--   [q / ]q - previous/next quickfix item
	--   [<Space> / ]<Space> - add blank line above/below
	--   [e / ]e - exchange with line above/below
	--   [t / ]t - previous/next tag
	--   [c / ]c - previous/next change (jump list)
	--   [f / ]f - previous/next file (in directory)
	--   And many more useful pairs
	{
		"tpope/vim-unimpaired",
		event = "VeryLazy", -- Load very late (mappings work automatically)
	},
}

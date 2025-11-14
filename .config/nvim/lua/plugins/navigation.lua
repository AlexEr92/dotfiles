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

	-- cscope_maps.nvim - Cscope integration for code navigation
	-- Provides code navigation for C/C++ projects using cscope database
	-- Key mappings are automatically created with prefix <leader>cs
	-- Commands: :Cs db build (to build cscope database)
	-- Features: find symbol definition, find functions calling a function, etc.
	{
		"dhananjaylatkar/cscope_maps.nvim",
		cmd = "Cs", -- Load when :Cs command is used
		dependencies = {
			"folke/which-key.nvim", -- For key mapping hints
			"ibhagwan/fzf-lua", -- For fuzzy finder (picker)
		},
		opts = {
			prefix = "<leader>cs", -- Prefix for all cscope key mappings
			cscope = {
				picker = "fzf-lua", -- Use fzf-lua as picker
				skip_picker_for_single_result = true, -- Jump directly if only one result
			},
		},
		config = function(_, opts)
			require("cscope_maps").setup(opts)
		end,
	},
}

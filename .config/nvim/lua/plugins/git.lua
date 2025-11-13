-- Git plugins
-- Provides Git integration and visualization
-- Key mappings are defined in core/mappings.lua
return {
	-- vim-fugitive - Powerful Git wrapper
	-- Provides Git commands like :Git, :Gstatus, :Gdiff, etc.
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},

	-- vim-merginal - Branch management for fugitive
	-- Extends fugitive with branch management features
	{
		"idanarye/vim-merginal",
		cmd = "Merginal",
		dependencies = { "tpope/vim-fugitive" },
	},

	-- lazygit.nvim - Terminal UI for Git
	-- Provides a beautiful terminal UI for Git operations
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- Key mapping (<leader>lg) is set in core/mappings.lua
	},

	-- gitsigns.nvim - Git signs and highlights
	-- Shows git changes in the gutter and provides git operations
	-- Key mappings are set up in core/mappings.lua via exported function
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "│" }, -- Sign for added lines
				change = { text = "│" }, -- Sign for changed lines
				delete = { text = "󰍵" }, -- Sign for deleted lines
				topdelete = { text = "‾" }, -- Sign for top deleted lines
				changedelete = { text = "~" }, -- Sign for changed and deleted lines
				untracked = { text = "│" }, -- Sign for untracked lines
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)

			-- Set up key mappings via mappings.lua
			local mappings = require("core.mappings")
			if mappings.setup_gitsigns_keymaps then
				mappings.setup_gitsigns_keymaps()
			end
		end,
	},
}

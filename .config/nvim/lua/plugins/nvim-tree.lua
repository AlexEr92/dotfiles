-- NvimTree file explorer plugin
-- Provides a tree file explorer sidebar for Neovim
-- Key mappings are defined in core/mappings.lua:
--   <leader>e - Toggle explorer
--   <leader>r - Refresh explorer
-- Configuration is defined in configs/nvim-tree-config.lua
return {
	"kyazdani42/nvim-tree.lua",
	dependencies = { "kyazdani42/nvim-web-devicons" }, -- For file icons
	cmd = { "NvimTreeToggle", "NvimTreeOpen" },
	config = function()
		-- Custom highlight for modified files
		vim.cmd([[highlight NvimTreeModifiedFile guifg=#FFA500]])

		-- Load configuration from configs directory
		local nvim_tree_config = require("configs.nvim-tree-config")
		require("nvim-tree").setup(nvim_tree_config.config())
	end,
}

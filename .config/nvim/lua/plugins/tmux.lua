-- Tmux navigation plugin
-- Seamless navigation between Neovim and tmux panes
return {
	"alexghergh/nvim-tmux-navigation",
	lazy = false, -- Load immediately for seamless navigation
	config = function()
		local nvim_tmux_nav = require("nvim-tmux-navigation")

		nvim_tmux_nav.setup({
			disable_when_zoomed = true, -- Disable navigation when window is zoomed
		})

		-- Key mappings are set up in core/mappings.lua
		local mappings = require("core.mappings")
		if mappings.setup_tmux_navigation then
			mappings.setup_tmux_navigation()
		end
	end,
}

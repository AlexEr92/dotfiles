-- Tokyo Night colorscheme plugin
-- Beautiful and customizable colorscheme for Neovim
-- Available styles: night (default), storm, day, moon
return {
	"folke/tokyonight.nvim",
	lazy = false, -- Load immediately (colorscheme should be available on startup)
	priority = 1000, -- High priority to load before other plugins
	config = function()
		require("tokyonight").setup({
			-- Available styles: "night", "storm", "day", "moon"
			style = "night", -- The theme style (default: "night")
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true }, -- Italic comments
				keywords = { italic = false }, -- Non-italic keywords
				functions = {}, -- Style for function names
				variables = {}, -- Style for variable names
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- Style for sidebars, see below
				floats = "dark", -- Style for floating windows
			},
			sidebars = { "qf", "help" }, -- Set a different background style for sidebar-like windows
			day_brightness = 0.3, -- Adjusts the brightness of the day style colors
			hide_inactive_statusline = false, -- Enabling this option will hide inactive statuslines
			dim_inactive = false, -- Dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		})

		-- Load the colorscheme
		vim.cmd("colorscheme tokyonight")
	end,
}

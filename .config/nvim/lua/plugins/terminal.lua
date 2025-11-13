-- ToggleTerm plugin
-- Provides a toggleable terminal window in Neovim
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- Terminal size configuration
			size = 20,
			-- Key mapping to toggle terminal
			-- VSCode-style: Ctrl+` (configured in core/mappings.lua)
			-- Note: open_mapping is not set here to avoid conflicts
			hide_numbers = true, -- Hide line numbers in terminal
			shade_filetypes = {}, -- Files that should be shaded
			autochdir = false, -- Don't change directory when opening terminal
			highlights = {
				-- Customize highlights if needed
			},
			direction = "float", -- "vertical" | "horizontal" | "tab" | "float"
			float_opts = {
				border = "curved", -- "single" | "double" | "shadow" | "curved" | ... other options supported by win open
				width = function()
					return math.ceil(vim.o.columns * 0.8)
				end,
				height = function()
					return math.ceil(vim.o.lines * 0.8)
				end,
			},
		})
	end,
}

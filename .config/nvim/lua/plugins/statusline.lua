-- Lualine statusline plugin
-- Provides a configurable and beautiful statusline for Neovim
return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- For icons support
	config = function()
		-- Custom function to show directory name when opening nvim with "nvim ."
		-- Based on NvChad's approach: show directory name when buffer represents a directory
		local function smart_filename()
			local filename = vim.fn.expand("%:t")
			local buftype = vim.bo.buftype
			local filetype = vim.bo.filetype
			
			-- Check if this is a directory buffer (opened with "nvim .")
			-- Conditions: filename is "." or empty, and it's not a special buffer type
			if (filename == "." or filename == "") and buftype == "" and filetype == "" then
				-- Show current directory name
				return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			end
			
			-- For netrw or other directory explorers, also show directory name
			if filetype == "netrw" or (filename == "." and buftype == "") then
				return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			end
			
			-- Otherwise show regular filename (or "No Name" if empty)
			return filename ~= "" and filename or "[No Name]"
		end

		require("lualine").setup({
			options = {
				icons_enabled = true, -- Show icons in statusline
				theme = "auto", -- Auto-detect theme from colorscheme
				-- Separators between components within a section
				component_separators = {
					left = "",
					right = "",
				},
				-- Separators between different sections
				section_separators = {
					left = "",
					right = "",
				},
				disabled_filetypes = {
					statusline = {}, -- Filetypes to disable statusline for
					winbar = {}, -- Filetypes to disable winbar for
				},
				ignore_focus = {}, -- Windows to ignore focus events for
				always_divide_middle = true, -- Always divide middle section
				always_show_tabline = true, -- Always show tabline
				globalstatus = false, -- Show statusline in all windows or just active
				refresh = {
					statusline = 100, -- Refresh rate for statusline (ms)
					tabline = 100, -- Refresh rate for tabline (ms)
					winbar = 100, -- Refresh rate for winbar (ms)
				},
			},
			-- Active window sections
			sections = {
				-- Left sections
				lualine_a = { "mode" }, -- Current vim mode (normal, insert, etc.)
				lualine_b = {
					"branch", -- Git branch name
					"diff", -- Git diff status (added, modified, removed)
					{
						"diagnostics", -- LSP diagnostics (errors, warnings, etc.)
						sources = {
							"nvim_diagnostic",
						},
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰌵 ",
						},
					},
				},
				lualine_c = { smart_filename }, -- Current file name (or directory name if opened with "nvim .")
				-- Right sections
				lualine_x = { "encoding", "fileformat", "filetype" }, -- File encoding, format (unix/dos), and type
				lualine_y = { "progress" }, -- Cursor position percentage
				lualine_z = { "location" }, -- Cursor line and column
			},
			-- Inactive window sections (simplified view for non-active windows)
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { smart_filename }, -- Show only filename (or directory name) in inactive windows
				lualine_x = { "location" }, -- Show only location in inactive windows
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {}, -- Tabline configuration (disabled by default)
			winbar = {}, -- Winbar configuration (top bar, disabled by default)
			inactive_winbar = {}, -- Inactive winbar configuration
			extensions = {
				"nvim-tree", -- Integration with nvim-tree file explorer
			},
		})
	end,
}

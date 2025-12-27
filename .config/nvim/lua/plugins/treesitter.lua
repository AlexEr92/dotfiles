-- Treesitter configuration
-- Provides advanced syntax highlighting and parsing using Tree-sitter
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.config").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
			-- Enable syntax highlighting
			highlight = {
				enable = true,
				-- Disable vim regex highlighting in favor of treesitter
				additional_vim_regex_highlighting = false,
			},

			-- Enable indentation based on syntax tree
			indent = {
				enable = true,
			},

			-- Text objects and selection
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can customize these keymaps if needed
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				lsp_interop = {
					enable = true,
				},
			},
		})
		-- Install parsers
		require("nvim-treesitter").install({
			"bash",
			"c",
			"cpp",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"python",
			"rust",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		})
	end,
}

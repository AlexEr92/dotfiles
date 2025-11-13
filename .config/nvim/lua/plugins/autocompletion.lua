-- Autocompletion plugins
-- Provides intelligent code completion, snippets, and signature help
return {
	-- nvim-cmp - Core completion engine
	-- Modern completion menu for Neovim with multiple sources
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- Load when entering insert mode
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Main completion configuration
			cmp.setup({
				-- Snippet support using LuaSnip
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- Completion behavior settings
				completion = {
					completeopt = "menu,menuone", -- Show menu even with one item
					keyword_length = 3, -- Minimum characters to trigger completion
				},

				-- Window appearance configuration
				window = {
					completion = {
						side_padding = 1, -- Padding on sides of completion menu
						border = "rounded", -- Border style for completion menu
						scrollbar = false, -- Hide scrollbar in completion menu
					},
					documentation = {
						border = "rounded", -- Border style for documentation popup
					},
				},

				-- Formatting of completion items
				formatting = {
					fields = { "menu", "abbr", "kind" }, -- Order of fields in menu
					format = function(entry, item)
						-- Icons to distinguish completion sources
						local menu_icon = {
							nvim_lsp = "λ", -- LSP completions
							luasnip = "⋗", -- Snippet completions
							buffer = "Ω", -- Buffer text completions
							path = "🖫", -- File path completions
						}

						item.menu = menu_icon[entry.source.name] or entry.source.name
						return item
					end,
				},

				-- Key mappings for completion navigation
				mapping = {
					-- Navigation in completion menu
					["<C-n>"] = cmp.mapping.select_next_item(), -- Next item
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous item
					["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down

					-- Completion control
					["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
					["<C-e>"] = cmp.mapping.close(), -- Close completion menu

					-- Confirm selection
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert, -- Insert selected item
						select = true, -- Automatically select first item if none selected
					}),

					-- Tab key: completion navigation or snippet expansion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- Navigate to next item in completion menu
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							-- Expand or jump to next snippet placeholder
							luasnip.expand_or_jump()
						else
							-- Default Tab behavior
							fallback()
						end
					end, { "i", "s" }), -- Works in insert and select modes

					-- Shift+Tab: previous item or snippet jump
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							-- Navigate to previous item in completion menu
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							-- Jump to previous snippet placeholder
							luasnip.jump(-1)
						else
							-- Default Shift+Tab behavior
							fallback()
						end
					end, { "i", "s" }), -- Works in insert and select modes
				},

				-- Completion sources (priority order)
				-- Sources are checked from top to bottom
				sources = {
					{ name = "nvim_lsp" }, -- LSP completions (highest priority)
					{ name = "luasnip" }, -- Snippet completions
					{ name = "path" }, -- File system path completions
					{ name = "buffer" }, -- Text from open buffers
				},
			})

			-- Command line completion for / (search)
			-- Provides buffer completions when searching
			cmp.setup.cmdline("/", {
				sources = cmp.config.sources({
					{ name = "buffer" }, -- Search through buffer text
				}),
			})
		end,

		-- Dependencies loaded only when cmp loads (lazy-loaded)
		dependencies = {
			-- LuaSnip - Snippet engine
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets", -- VSCode-style snippets
				opts = {
					history = true, -- Remember snippet choices
					updateevents = "TextChanged,TextChangedI", -- Update on text changes
				},
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					-- Load VSCode-compatible snippets (from friendly-snippets)
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"hrsh7th/cmp-nvim-lsp", -- LSP source for cmp
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua API source
			"hrsh7th/cmp-path", -- File path source
			"hrsh7th/cmp-buffer", -- Buffer text source
			"hrsh7th/cmp-cmdline", -- Command line source
			"saadparwaiz1/cmp_luasnip", -- LuaSnip source for cmp
		},
	},

	-- nvim-autopairs - Auto pair brackets, quotes, etc.
	-- Automatically closes brackets, quotes, and other pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Load when entering insert mode
		opts = {
			fast_wrap = {}, -- Fast wrap configuration (press key to wrap)
			disable_filetype = { "TelescopePrompt", "vim" }, -- Disable for specific filetypes
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			-- Integrate with cmp: close pairs when completing with cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- lsp_signature.nvim - LSP signature help
	-- Shows function signatures and parameter hints as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy", -- Load very late
		opts = {
			bind = true, -- Bind signature help to function call
			handler_opts = {
				border = "rounded", -- Border style for signature popup
			},
			hint_enable = false, -- Disable inline hints (can be enabled if preferred)
			hint_prefix = "💡 ", -- Prefix for hints (if enabled)
			-- Alternative hint prefixes per position:
			-- hint_prefix = {
			-- 	above = "↙ ", -- Hint on line above
			-- 	current = "← ", -- Hint on same line
			-- 	below = "↖ ", -- Hint on line below
			-- },
			hi_parameter = "LspSignatureActiveParameter", -- Highlight active parameter
			toggle_key = "<M-x>", -- Toggle signature help (Alt+x)
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}

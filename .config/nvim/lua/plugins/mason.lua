-- Mason plugins
-- Package manager for LSP servers, DAP adapters, linters, and formatters
return {
	-- Mason.nvim - Core package manager
	{
		"williamboman/mason.nvim",
		lazy = false, -- Load immediately to ensure LSP servers are available
		opts = {
			ui = {
				icons = {
					package_pending = " ", -- Icon for pending packages
					package_installed = "󰄳 ", -- Icon for installed packages
					package_uninstalled = " 󰚌", -- Icon for uninstalled packages
				},
				border = "rounded", -- Border style for Mason UI
				-- Keymaps for Mason UI window (internal mappings, not global)
				keymaps = {
					toggle_server_expand = "<CR>", -- Expand/collapse server details
					install_server = "i", -- Install selected server
					update_server = "u", -- Update selected server
					check_server_version = "c", -- Check server version
					update_all_servers = "U", -- Update all servers
					check_outdated_servers = "C", -- Check for outdated servers
					uninstall_server = "X", -- Uninstall selected server
					cancel_installation = "<C-c>", -- Cancel installation
				},
			},
			max_concurrent_installers = 10, -- Max parallel installations
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	-- mason-lspconfig - Integration with nvim-lspconfig
	-- Automatically installs and configures LSP servers
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				-- LSP servers to ensure are installed
				-- These should match the servers configured in lsp.lua
				ensure_installed = {
					"lua_ls", -- Lua language server
					"clangd", -- C/C++ language server
					"cmake", -- CMake language server
					"rust_analyzer", -- Rust language server
					"pyright", -- Python language server
					"gopls", -- Go language server
					"bashls", -- Bash language server
				},
			})
		end,
	},

	-- mason-nvim-dap - Integration with nvim-dap for debugging
	-- Provides debug adapters that can be installed via Mason
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-nvim-dap").setup({
				-- Debug adapters to ensure are installed
				ensure_installed = {
					"cppdbg", -- C/C++ debugger (Windows/Linux)
					"codelldb", -- C/C++/Rust debugger (LLDB-based)
					"delve", -- Go debugger
				},
				automatic_installation = true, -- Auto-install missing adapters
				handlers = {}, -- Custom handlers for adapters
			})
		end,
	},
}

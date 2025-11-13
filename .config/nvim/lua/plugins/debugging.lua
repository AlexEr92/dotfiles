-- DAP (Debug Adapter Protocol) plugins
-- Provides debugging capabilities for various programming languages
-- Key mappings are defined in core/mappings.lua
return {
	-- nvim-dap - Core DAP implementation
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui", -- UI for debugger
			"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Configure DAP UI
			dapui.setup()

			-- Auto-open DAP UI when debugging starts
			dap.listeners.after.event_initialized.dapui_config = function()
				dapui.open()
			end

			-- Auto-close DAP UI when debugging ends
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Define custom highlight for breakpoints
			vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ff869a", bg = "#212432" })

			-- Define breakpoint sign (shown in gutter)
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})

			-- Define stopped sign (shows where execution paused)
			vim.fn.sign_define("DapStopped", {
				text = "▶",
				texthl = "DapStopped",
				linehl = "",
				numhl = "DapStopped",
			})

			-- Set up key mappings via mappings.lua
			local mappings = require("core.mappings")
			if mappings.setup_dap_keymaps then
				mappings.setup_dap_keymaps()
			end
		end,
	},
}

-- User-defined commands for Neovim
-- Custom commands that can be called with :CommandName
local cmd = vim.cmd

--------------------------------------------------
-- Utility Commands
--------------------------------------------------

-- Quick quit command
-- Usage: :Q (same as :qall but shorter)
cmd("command! Q qall")

--------------------------------------------------
-- Formatting Commands
--------------------------------------------------

-- Format command for conform.nvim plugin
-- Usage:
--   :Format           - Format entire buffer
--   :Format           - Format current line (when used as operator)
--   :'<,'>Format      - Format selected lines (visual mode)
--   :1,10Format       - Format lines 1 to 10
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil

	-- If a range is specified (via line numbers or visual selection)
	if args.count ~= -1 then
		-- Get the end line content to calculate its length
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		-- Create range for formatting
		-- start: line1, column 0
		-- end: line2, last column of that line
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line and end_line:len() or 0 },
		}
	end

	-- Format using conform.nvim
	-- async = true: don't block UI during formatting
	-- lsp_format = "fallback": use LSP formatting if conform formatter not available
	-- range = range: format only specified range (nil means entire buffer)
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true }) -- range = true allows using line numbers and visual selection
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Set indentation
local setIndentGroup = augroup("setIndent", { clear = true })

autocmd("FileType", {
	group = setIndentGroup,
	pattern = {
		"xml",
		"html",
		"xhtml",
		"css",
		"scss",
		"javascript",
		"typescript",
		"yaml",
		"lua",
		"cmake",
		"bash",
		"sh",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd("FileType", {
	group = setIndentGroup,
	pattern = {
		"c",
		"cpp",
		"python",
		"rust",
	},
	command = "setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab",
})

autocmd("FileType", {
	group = setIndentGroup,
	pattern = {
		"go",
	},
	command = "setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0",
})

autocmd("FileType", {
	group = setIndentGroup,
	pattern = {
		"make",
		"*.mk",
	},
	command = "setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0",
})

-- Remove format options for all files
-- Disables automatic comment continuation:
--   "r" - automatically inserts comment leader when pressing Enter in insert mode
--         (if the line starts with a comment)
--   "o" - automatically inserts comment leader when using 'o' or 'O' in normal mode
--         (if the current line is a comment)
-- This gives you more control over when comments are created
local formatOptionsGroup = augroup("formatOptions", { clear = true })
autocmd("FileType", {
	group = formatOptionsGroup,
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- Remove whitespace on save
local whitespaceGroup = augroup("whitespace", { clear = true })
autocmd("BufWritePre", {
	group = whitespaceGroup,
	pattern = "*",
	command = ":%s/\\s\\+$//e",
})

-- Highlight trailing whitespaces
local highlightGroup = augroup("highlightWhitespace", { clear = true })

-- Track match IDs to avoid duplicates
local match_ids = {}

-- Define highlight group
-- Use bg and fg instead of guibg/ctermbg (works with termguicolors)
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000" })

-- Update highlight on ColorScheme change
autocmd("ColorScheme", {
	group = highlightGroup,
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000" })
	end,
})

-- Set up match for trailing whitespace in each window
autocmd({ "BufWinEnter", "WinEnter" }, {
	group = highlightGroup,
	pattern = "*",
	callback = function()
		local win = vim.api.nvim_get_current_win()
		local win_id = vim.api.nvim_win_get_number(win)

		-- Clear existing match for this window if any
		-- Use pcall to safely delete match (it may have been already deleted)
		if match_ids[win_id] then
			pcall(vim.fn.matchdelete, match_ids[win_id])
			-- Clear from table regardless of success (match may have been auto-deleted)
			match_ids[win_id] = nil
		end

		-- Add new match
		match_ids[win_id] = vim.fn.matchadd("ExtraWhitespace", "\\s\\+$")
	end,
})

-- Show diagnostic messages
local diagnosticsGroup = augroup("diagnostics", { clear = true })

local show_diagnostics_on_hover = function()
	if vim.diagnostic.is_enabled() then
		local opts = {
			focusable = false,
			close_events = { "CursorMoved", "InsertEnter" },
			source = "always",
			prefix = " ",
		}
		vim.diagnostic.open_float(nil, opts)
	end
end

autocmd("CursorHold", {
	group = diagnosticsGroup,
	callback = function()
		show_diagnostics_on_hover()
	end,
})

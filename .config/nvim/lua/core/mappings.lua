-- Key mappings configuration for Neovim
-- Centralized location for all key bindings
-- Some mappings are set up via exported functions called from plugin configs
-- Note: Leader key is set in core/options.lua (must be before lazy.nvim loads)

local map = vim.keymap.set

--------------------------------------------------
-- General Shortcuts
--------------------------------------------------

-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("i", "kj", "<ESC>", { desc = "Escape insert mode" })

--------------------------------------------------
-- Tab Management
--------------------------------------------------

map("n", "<leader>te", ":tabedit<CR>", { desc = "Open new tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprev<CR>", { desc = "Previous tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

--------------------------------------------------
-- Buffer Management
--------------------------------------------------

map("n", "<leader>bo", "<cmd>enew<CR>", { silent = true, noremap = true, desc = "New buffer" })
map("n", "<leader>bc", "<cmd>bdelete<CR>", { silent = true, noremap = true, desc = "Close buffer" })

--------------------------------------------------
-- Window Management
--------------------------------------------------

-- Resize windows using Ctrl + Arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

--------------------------------------------------
-- UI Toggles
--------------------------------------------------

-- Toggle visibility of whitespace characters (spaces, tabs, EOL, etc.)
map("n", "<leader>sw", ":set list!<CR>", { desc = "Toggle whitespace visibility" })

--------------------------------------------------
-- File Explorer (NvimTree)
--------------------------------------------------

map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true, desc = "Toggle file explorer" })
map("n", "<leader>r", ":NvimTreeRefresh<CR>", { silent = true, noremap = true, desc = "Refresh file explorer" })

--------------------------------------------------
-- Search & Navigation
--------------------------------------------------

-- Clear search highlight
map("n", "<leader>nh", ":noh<cr>", { silent = true, desc = "Clear search highlight" })

--------------------------------------------------
-- Quickfix & Location Lists
--------------------------------------------------

map("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix list" })
map("n", "<leader>lo", "<cmd>lopen<CR>", { noremap = true, silent = true, desc = "Open location list" })

-- Add LSP diagnostics to quickfix list
map(
	"n",
	"<leader>dq",
	"<cmd>lua vim.diagnostic.setqflist()<CR>",
	{ noremap = true, silent = true, desc = "Add LSP diagnostics to quickfix" }
)

--------------------------------------------------
-- Hop Navigation (Word Jumping)
--------------------------------------------------

-- Shows hints on words to jump quickly
map("n", "<leader><leader>w", ":HopWordAC<CR>", { noremap = true, silent = true, desc = "Hop word after cursor" })
map("n", "<leader><leader>b", ":HopWordBC<CR>", { noremap = true, silent = true, desc = "Hop word before cursor" })

--------------------------------------------------
-- Git Operations
--------------------------------------------------

map("n", "<leader>gs", "<cmd>:tab Git <CR>", { desc = "Git status (fugitive)" })
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

--------------------------------------------------
-- Code Formatting
--------------------------------------------------

-- Format code using conform.nvim (see :Format command)
map({ "n", "v" }, "<leader>fm", "<cmd>Format<CR>", { desc = "Format code" })

--------------------------------------------------
-- Diagnostics & Terminal
--------------------------------------------------

-- Toggle LSP diagnostics on/off
map("n", "<leader>dt", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
		-- Close any floating diagnostic windows
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				vim.api.nvim_win_close(win, true)
			end
		end
	else
		vim.diagnostic.enable()
	end
end, { desc = "Toggle diagnostics" })

-- Terminal toggle (VSCode-style: Ctrl+`)
map("n", "<C-`>", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
map("t", "<C-`>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle terminal (from terminal mode)" })

--------------------------------------------------
-- Git Signs Key Mappings
--------------------------------------------------
-- Setup gitsigns keymaps
-- Called from git.lua when gitsigns is configured
local function setup_gitsigns_keymaps()
	local status_ok, gs = pcall(require, "gitsigns")
	if not status_ok then
		return
	end

	map("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
	map("n", "[h", gs.prev_hunk, { desc = "Previous git hunk" })
	map("n", "<leader>rh", gs.reset_hunk, { desc = "Reset git hunk" })
	map("n", "<leader>ph", gs.preview_hunk, { desc = "Preview git hunk" })
	map("n", "<leader>gb", gs.blame_line, { desc = "Git blame line" })
end

--------------------------------------------------
-- LSP Key Mappings
--------------------------------------------------
-- Function to set up LSP key mappings for a buffer
-- Called from lspconfig.lua when LSP attaches to a buffer
local function setup_lsp_keymaps(bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	-- Navigation key mappings
	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
	map("n", "gr", vim.lsp.buf.references, opts("Show references"))

	-- Signature help
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))

	-- Workspace folder management
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	-- Code actions and renaming
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
end

--------------------------------------------------
-- DAP (Debug Adapter Protocol) Key Mappings
--------------------------------------------------
-- Setup DAP keymaps
-- Requires nvim-dap plugin to be loaded
-- Called from debugging.lua plugin config
local function setup_dap_keymaps()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end

	local dapui_status_ok, dapui = pcall(require, "dapui")
	if not dapui_status_ok then
		return
	end

	-- Debug control
	map("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
	map("n", "<F6>", dap.step_over, { desc = "Debug: Step Over" })
	map("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
	map("n", "<S-F7>", dap.step_out, { desc = "Debug: Step Out" })
	map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
end

--------------------------------------------------
-- FzfLua Key Mappings
--------------------------------------------------
-- Setup FzfLua keymaps
-- Requires fzf-lua plugin to be loaded
-- Called from fzflua.lua plugin config
local function setup_fzflua_keymaps()
	local status_ok, fzf_lua = pcall(require, "fzf-lua")
	if not status_ok then
		return
	end

	-- File finder and search mappings
	map("n", "<leader>ff", fzf_lua.files, { desc = "Find files (fzf)" })
	map("n", "<leader>fg", fzf_lua.live_grep, { desc = "Live grep (fzf)" })
	map("n", "<leader>fw", fzf_lua.grep_curbuf, { desc = "Grep current buffer (fzf)" })
	map("n", "<leader>fb", fzf_lua.buffers, { desc = "Find buffers (fzf)" })
	map("n", "<leader>fh", fzf_lua.oldfiles, { desc = "Recent files (fzf)" })
	map("v", "<leader>fg", fzf_lua.grep_visual, { desc = "Live grep selected text (fzf)" })
end

--------------------------------------------------
-- Comment Key Mappings
--------------------------------------------------
-- Setup Comment.nvim keymaps
-- Requires Comment.nvim plugin to be loaded
-- Called from comment.lua plugin config
local function setup_comment_keymaps()
	-- These mappings use Comment.nvim's built-in operators
	-- gcc - toggle comment for current line
	-- gc - comment operator (works with motions in visual mode)
	-- remap = true allows these to work with Comment.nvim's operators
	map("n", "<leader>/", "gcc", { desc = "Toggle comment (line)", remap = true })
	map("v", "<leader>/", "gc", { desc = "Toggle comment (selection)", remap = true })
end

--------------------------------------------------
-- Tmux Navigation Key Mappings
--------------------------------------------------
-- Setup tmux navigation keymaps
-- Requires nvim-tmux-navigation plugin to be loaded
-- Called from tmux.lua plugin config
local function setup_tmux_navigation()
	local status_ok, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
	if not status_ok then
		return
	end

	map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Navigate left (tmux)" })
	map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "Navigate down (tmux)" })
	map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Navigate up (tmux)" })
	map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Navigate right (tmux)" })
	map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = "Navigate to last active (tmux)" })
	map("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext, { desc = "Navigate next (tmux)" })
end

--------------------------------------------------
-- Grug-far Key Mappings
--------------------------------------------------
-- Setup grug-far keymaps
-- Requires grug-far.nvim plugin to be loaded
-- Called from grug-far.lua plugin config
local function setup_grug_far_keymaps()
	local status_ok, grug = pcall(require, "grug-far")
	if not status_ok then
		return
	end

	map({ "n", "x" }, "<leader>sr", function()
		grug.open({
			transient = true,
		})
	end, { desc = "Find and Replace (grug-far)" })
end

-- Export function for use in other modules (e.g., lspconfig.lua, tmux.lua, git.lua, debugging.lua, comment.lua, fzflua.lua, grug-far.lua)
-- Return module with exported function to avoid polluting global namespace
local mappings_module = {}
mappings_module.setup_lsp_keymaps = setup_lsp_keymaps
mappings_module.setup_tmux_navigation = setup_tmux_navigation
mappings_module.setup_gitsigns_keymaps = setup_gitsigns_keymaps
mappings_module.setup_dap_keymaps = setup_dap_keymaps
mappings_module.setup_comment_keymaps = setup_comment_keymaps
mappings_module.setup_fzflua_keymaps = setup_fzflua_keymaps
mappings_module.setup_grug_far_keymaps = setup_grug_far_keymaps
return mappings_module

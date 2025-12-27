local g = vim.g
local o = vim.o
local opt = vim.opt

-- Set leader key to space
-- Must be set BEFORE lazy.nvim loads (for proper key binding resolution)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----------------------------------------------------------
-- General
-----------------------------------------------------------
o.mouse = "a" -- Enable mouse support
o.clipboard = "unnamedplus" -- Use system clipboard
o.swapfile = false -- Don't use swapfile
o.undofile = true -- Enable persistent undo
opt.listchars = { --
	tab = "→ ",
	space = "·",
	eol = "↲",
	nbsp = "␣",
	trail = "$",
}
o.fixendofline = false

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
o.expandtab = true -- Uses spaces instead of tabs
o.tabstop = 4 -- 1 tab == 4 spaces
o.shiftwidth = 4 -- Number of spaces for indent
o.smartindent = true -- Do smart autoindenting

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
o.termguicolors = true -- Enable 24-bit RGB colors
o.number = true -- Show line numbers
o.relativenumber = false -- Relative line numbers
o.cursorline = false -- Highlight current line (can enable if preferred)
o.showmatch = true -- Highlight matching parenthesis
o.splitright = true -- Vertical splits open to the right
o.splitbelow = true -- Horizontal splits open below
o.ignorecase = true -- Ignore case in search
o.smartcase = true -- Case sensitive if uppercase in search
o.wrap = false -- Don't wrap lines by default

------------------------------------------------------
-- Memory, CPU
------------------------------------------------------
o.hidden = true -- Allow hidden buffers
o.history = 1000 -- Command line history
o.synmaxcol = 240 -- Max column for syntax highlighting
o.updatetime = 750 -- Update time for CursorHold event

------------------------------------------------------
-- Startup
------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")

-- Disable builtin plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwFileHandlers",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- Disable some default providers
local disabled_providers = {
	"node_provider",
	"python3_provider",
	"perl_provider",
	"ruby_provider",
}

for _, provider in pairs(disabled_providers) do
	g["loaded_" .. provider] = 0
end

-- Disable vim diagnostics by default
vim.diagnostic.enable(false)

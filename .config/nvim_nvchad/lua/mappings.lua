require "nvchad.mappings"

-- Unused keys
vim.keymap.del("n", "<Tab>")
vim.keymap.del("n", "<S-Tab>")
vim.keymap.del("n", "<leader>x")
vim.keymap.del("n", "<leader>b")
vim.keymap.del("n", "<leader>n")

local map = vim.keymap.set

-- Map Esc to jk or kj
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Show non-displayable characters
map("n", "<leader>sl", ":set list!<CR>", { desc = "show non-displayable characters" })

-- Clear search highlighting with <leader> and c
map("n", "<leader>nh", ":nohl<CR>", { silent = true })

-- Tabs
map("n", "<leader>to", "<cmd>:tabedit<CR>", { silent = true, noremap = true, desc = "Tab open" })
map("n", "<leader>tc", "<cmd>:tabclose<CR>", { silent = true, noremap = true, desc = "Tab close" })
map("n", "<leader>tn", "<cmd>:tabnext<CR>", { silent = true, noremap = true, desc = "Tab next" })
map("n", "<leader>tp", "<cmd>:tabprevious<CR>", { silent = true, noremap = true, desc = "Tab previous" })

-- Buffers
map("n", "<leader>bo", "<cmd>:enew<CR>", { silent = true, noremap = true, desc = "New buffer" })
map("n", "<leader>bc", "<cmd>:bdelete<CR>", { silent = true, noremap = true, desc = "Close buffer" })

-- Telescope
map("n", "<leader>fg", "<cmd>Telescope live_grep_args<CR>", { desc = "telescope live grep with args" })

map("v", "<leader>fv", function()
  require("telescope-live-grep-args.shortcuts").grep_visual_selection()
end,
{ desc = "telescope find visual selected" })

map("n", "<leader>fu", function()
  require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
end,
{ desc = "telescope find under cursor" })

-- Git
map("n", "<leader>gs", "<cmd>:tab Git<CR>", { desc = "Git status" })
map("n", "[h", "<cmd>Gitsign prev_hunk<CR>", { desc = "Previous hunk" })
map("n", "]h", "<cmd>Gitsign next_hunk<CR>", { desc = "Next hunk" })
map("n", "<leader>hp", "<cmd>Gitsign preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>hr", "<cmd>Gitsign reset_hunk<CR>", { desc = "Reset hunk" })

-- Dap
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle Debug UI" })

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Debug: Continue" })

map("n", "<F6>", function()
  require("dap").step_over()
end, { desc = "Debug: Step Over" })

map("n", "<F7>", function()
  require("dap").step_into()
end, { desc = "Debug: Step Into" })

map("n", "<S-F7>", function()
  require("dap").step_out()
end, { desc = "Debug: Step Out" })

-- Hop
map("", "<leader><leader>w", "<cmd>HopWordAC<CR>", { desc = "Go to word after cursor", remap = true })
map("", "<leader><leader>b", "<cmd>HopWordBC<CR>", { desc = "Go to word before cursor", remap = true })

-- LSP
map("n", "<leader>sh", function()
  vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "Show signature help" })

map("n", "<leader>lh", function()
  vim.lsp.buf.hover()
end, { silent = true, noremap = true, desc = "LSP Hover" })

-- Toggle Diagnostics
map("n", "<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = "Toggle diagnostics" })

-- Send diagnostic messages to quick fix list
map("n", "<leader>dq", function()
  vim.diagnostic.setqflist()
end, { desc = "Send LSP diagnostics to Quickfix List" })

-- Quick fix list open/close
map("n", "<leader>co", "<cmd>copen<CR>", { silent = true, noremap = true, desc = "Open Quick fix list" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { silent = true, noremap = true, desc = "Close Quick fix list" })

-- Tmux Navigator
map("n", "<c-l>", "<cmd>:TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-h>", "<cmd>:TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-k>", "<cmd>:TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-j>", "<cmd>:TmuxNavigateDown<cr>", { desc = "Tmux Down" })

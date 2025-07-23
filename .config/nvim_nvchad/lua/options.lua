require "nvchad.options"

local opt = vim.opt
local cmd = vim.cmd

-- list of non-displayable characters
opt.listchars = {
  eol = "↲",
  tab = "→ ",
  trail = "·",
  space = "·",
  nbsp = "+",
}

-- highlight trailing whitespaces
cmd [[highlight ExtraWhitespace ctermbg=red guibg=red]]

cmd [[
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
]]

-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    DiffChange = {
      bg = "#464414",
      fg = "none",
    },
    DiffText = {
      bg = "#703C2F",
      fg = "#FFA500",
    },
    DiffAdd = {
      bg = "#103507",
      fg = "none",
    },
    DiffRemoved = {
      bg = "#461414",
      fg = "none",
    },
    DiffChanged = {
      bg = "#705C2F",
      fg = "#CCA500",
    },
  },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    enabled = false,
  },

  telescope = {
    style = "bordered",
  },
}

return M

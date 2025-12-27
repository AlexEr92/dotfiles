-- Search plugins
-- Provides file search, live grep, find and replace functionality
-- Key mappings are defined in core/mappings.lua
return {
    -- FzfLua - Fast and powerful fuzzy finder using fzf
    -- Provides file search, live grep, buffers, and more
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icon support
        lazy = false,
        config = function()
            local fzf_lua = require("fzf-lua")
            -- Basic configuration
            -- FzfLua works out of the box, but you can customize here if needed
            fzf_lua.setup({
                -- Add custom configuration here if needed
                -- Most settings work well with defaults
            })

            -- Key mappings are set up in core/mappings.lua
            local mappings = require("core.mappings")
            if mappings.setup_fzflua_keymaps then
                mappings.setup_fzflua_keymaps()
            end
        end,
    },

    -- Grug-far.nvim - Find And Replace plugin for neovim
    -- Provides powerful search and replace functionality using ripgrep
    {
        "MagicDuck/grug-far.nvim",
        cmd = { "GrugFar" }, -- Load when command is used
        keys = {
            { "<leader>sr", mode = { "n", "x" }, desc = "Find and Replace (grug-far)" },
        },                            -- Load when keys are pressed (mappings are defined in core/mappings.lua)
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- Optional: for better syntax highlighting
        },
        config = function()
            local grug_far = require("grug-far")

            -- Basic configuration
            -- Most settings work well with defaults
            -- You can customize here if needed
            grug_far.setup({
                -- Add custom configuration here if needed
                -- See :help grug-far for available options
            })

            -- Key mappings are set up in core/mappings.lua
            local mappings = require("core.mappings")
            if mappings.setup_grug_far_keymaps then
                mappings.setup_grug_far_keymaps()
            end
        end,
    },
}

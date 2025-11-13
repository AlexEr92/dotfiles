-- nvim-bqf plugin
-- Enhances the quickfix window with better navigation and preview
return {
	"kevinhwang91/nvim-bqf",
	config = function()
		require("bqf").setup({
			auto_enable = true, -- Automatically enable bqf for quickfix windows
			preview = {
				auto_preview = false, -- Disable automatic preview (enable manually with 'p' key)
			},
		})
	end,
}

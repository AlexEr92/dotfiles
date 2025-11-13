-- NvimTree Configuration Module
-- Defines configuration for nvim-tree file explorer
-- Note: Key mappings are defined in core/mappings.lua
local M = {}

-- Returns the complete configuration for nvim-tree
M.config = function()
	return {
		-- Core settings
		auto_reload_on_write = true, -- Auto reload when files are written
		-- disable_netrw = false, -- Already disabled in core/options.lua
		hijack_cursor = false, -- Keep cursor in tree when opening files
		hijack_netrw = true, -- Replace netrw with nvim-tree
		hijack_unnamed_buffer_when_opening = false, -- Don't hijack unnamed buffers
		sort_by = "name", -- Sort files by name
		root_dirs = {}, -- Root directories to explore
		prefer_startup_root = false, -- Don't prefer startup root
		sync_root_with_cwd = false, -- Don't sync root with current directory
		reload_on_bufenter = false, -- Don't reload on buffer enter
		respect_buf_cwd = false, -- Don't respect buffer's cwd
		on_attach = "disable", -- Disable default keybindings (use custom ones)
		select_prompts = false, -- Don't select prompts

		-- View configuration
		view = {
			centralize_selection = false, -- Don't centralize selection
			cursorline = true, -- Highlight current line
			debounce_delay = 15, -- Delay for cursor movements
			width = 34, -- Width of tree window
			side = "left", -- Side to open tree (left/right)
			preserve_window_proportions = false, -- Don't preserve window proportions
			number = false, -- Don't show line numbers
			relativenumber = false, -- Don't show relative line numbers
			signcolumn = "yes", -- Show sign column
			float = {
				enable = false, -- Don't use float window
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 30,
					height = 30,
					row = 1,
					col = 1,
				},
			},
		},

		-- Renderer configuration
		renderer = {
			add_trailing = false, -- Don't add trailing slash to folders
			group_empty = false, -- Don't group empty folders
			highlight_git = "all", -- Highlight all git files
			highlight_modified = "all", -- Highlight all modified files
			full_name = false, -- Don't show full file path
			highlight_opened_files = "none", -- Don't highlight opened files
			root_folder_label = ":~:s?$?/..?", -- Root folder label format
			indent_width = 2, -- Indentation width
			indent_markers = {
				enable = false, -- Disable indent markers
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true, -- Use web devicons colors
				git_placement = "before", -- Git icons before file name
				modified_placement = "after", -- Modified indicator after file name
				padding = " ", -- Padding between icons
				symlink_arrow = " ➛ ", -- Arrow for symlinks
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
				},
				glyphs = {
					default = "",
					symlink = "",
					bookmark = "",
					modified = "●",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" }, -- Special files to highlight
			symlink_destination = true, -- Show symlink destination
		},

		-- Directory hijacking
		hijack_directories = {
			enable = true, -- Hijack directory buffers
			auto_open = true, -- Auto open tree when opening a directory
		},

		-- File tracking
		update_focused_file = {
			enable = true, -- Update tree when file is focused
			update_root = true, -- Update root when file is focused
			ignore_list = {}, -- Files to ignore when updating
		},

		-- System integration
		system_open = {
			cmd = "", -- Command to open files externally (empty = auto-detect)
			args = {}, -- Arguments for system open command
		},

		-- Diagnostics display
		diagnostics = {
			enable = false, -- Show LSP diagnostics in tree
			show_on_dirs = false, -- Show diagnostics on directories
			show_on_open_dirs = true, -- Show diagnostics on open directories
			debounce_delay = 50, -- Delay for diagnostics updates
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},

		-- File filters
		filters = {
			dotfiles = false, -- Show dotfiles
			git_clean = false, -- Show git clean files
			no_buffer = false, -- Show files without buffers
			custom = {}, -- Custom filters
			exclude = {}, -- Files/directories to exclude
		},

		-- Filesystem watchers
		filesystem_watchers = {
			enable = true, -- Watch filesystem for changes
			debounce_delay = 50, -- Delay for filesystem events
			ignore_dirs = {}, -- Directories to ignore
		},

		-- Git integration
		git = {
			enable = true, -- Enable git integration
			ignore = true, -- Respect .gitignore
			show_on_dirs = true, -- Show git status on directories
			show_on_open_dirs = true, -- Show git status on open directories
			timeout = 400, -- Timeout for git operations (ms)
		},

		-- Modified files indicator
		modified = {
			enable = true, -- Show modified file indicators
			show_on_dirs = true, -- Show on directories
			show_on_open_dirs = true, -- Show on open directories
		},

		-- Actions configuration
		actions = {
			use_system_clipboard = true, -- Use system clipboard for copy/paste
			change_dir = {
				enable = true, -- Allow changing directory
				global = false, -- Don't change global directory
				restrict_above_cwd = false, -- Don't restrict above cwd
			},
			expand_all = {
				max_folder_discovery = 300, -- Max folders to discover
				exclude = {}, -- Folders to exclude from expansion
			},
			file_popup = {
				open_win_config = {
					col = 1,
					row = 1,
					relative = "cursor",
					border = "shadow",
					style = "minimal",
				},
			},
			open_file = {
				quit_on_open = false, -- Don't quit tree when opening file
				resize_window = true, -- Resize window when opening file
				window_picker = {
					enable = true, -- Enable window picker
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", -- Characters for window picker
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true, -- Close window when removing file
			},
		},

		-- Trash configuration
		trash = {
			cmd = "gio trash", -- Command to move files to trash (Linux)
		},

		-- Live filter
		live_filter = {
			prefix = "[FILTER]: ", -- Prefix for filter mode
			always_show_folders = true, -- Always show folders when filtering
		},

		-- Tab synchronization
		tab = {
			sync = {
				open = false, -- Don't sync tree opening across tabs
				close = false, -- Don't sync tree closing across tabs
				ignore = {}, -- Tabs to ignore
			},
		},

		-- Notification settings
		notify = {
			threshold = vim.log.levels.INFO, -- Notification threshold
		},

		-- Logging
		log = {
			enable = false, -- Disable logging
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				dev = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
	}
end

return M


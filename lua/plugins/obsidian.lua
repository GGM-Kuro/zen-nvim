return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "KuroMind", -- Name of the workspace
				path = os.getenv("HOME") .. "/.config/obsidian/Vaults/KuroMind", -- Path to the notes directory
				-- path = "/mnt/e/Obsidian/Vaults/KuroMind/", -- Path to the notes directory
			},
		},
		completion = {
			cmp = true,
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
			name = "snacks.pick",
		},
		-- Optional, define your own callbacks to further customize behavior.

		-- Settings for templates
		templates = {
			subdir = "99-Archivo/Templates", -- Subdirectory for templates
			date_format = "%Y-%m-%d-%a", -- Date format for templates
			gtime_format = "%H:%M", -- Time format for templates
			tags = "", -- Default tags for templates
		},
	},
}

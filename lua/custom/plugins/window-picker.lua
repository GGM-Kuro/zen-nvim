return {
	-- Default with no branch will build from source
	"MarcusGrass/nvim_winpick",
	-- If not wanting to build from source, specify your architecture here
	-- prebuilds are available for `x86_64-unknown-linux-gnu-latest`, `aarch64-unknown-linux-gnu-latest`, and `aarch64-apple-darwin-latest`
	-- Since I'm using `x86_64-unknown-linux-gnu`, only that one is field-tested.
	branch = "x86_64-unknown-linux-gnu-latest",
    keys = {
        {
            '<M-w>',function ()
                require("nvim_winpick").pick_focus_window(opts)
            end
        }
    },
	lazy = false,
	opts = {
		-- Which chars should be used as visual prompts, no repetitions allowed.
		-- Some chars are not rendered for the hint 'floating-big-letter', those will
		-- cause an if used (same with repetitions).
		selection_chars = "aoeuhtns",
		filter_rules = {
			-- If there's only one window to choose after filtering, immediately pick it
			autoselect_one = true,
			-- Include the currently focused window
			include_current_win = false,
			-- Include windows that cannot be focused
			include_unfocusable_windows = true,
			-- Bufferoptions that should be filtered on
			bo = {
				filetype = {
					-- filetype exactly matches
					"NvimTree",
					"neo-tree",
					"notify",
					"snacks_notif",
				},
				buftype = {
					-- buftype exactly matches
					-- "terminal",
					-- "nofile",
					"prompt",
				},
			},
			file_path_contains = {
				-- This is an array of excluding sub-strings of a file-path
				-- Ex: /home/me/docs/my-file.md would be matched by 'docs/my'
			},
			file_name_contains = {
				-- This is an array of excluding sub-strings of a filename
				-- Ex: /home/me/docs/my-file.md would be matched by 'my-file' but not 'docs'
			},
		},
		-- "floating-big-letter" or "floating-letter" is valid here
		hint = "floating-big-letter",

		-- characters that control multiselect
		-- both or none must be present
		multiselect = {

			-- Not set by default, character that triggers a multiselect (if available on the action)
			trigger_char = "m",
			-- Not set by default, character that triggers a commit of the selected windows (if available on the action)
			commit_char = "c",
		},
	},
}

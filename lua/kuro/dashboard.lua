return {
	enable = true,
	preset = {
		header = [[

      █████╗  ██████╗ ███╗   ███╗
    ██╔════╝ ██╔════╝ ████╗ ████║
    ██║  ███╗██║  ███╗██╔████╔██║
    ██║   ██║██║   ██║██║╚██╔╝██║
    ╚██████╔╝╚██████╔╝██║ ╚═╝ ██║
     ╚═════╝  ╚═════╝ ╚═╝     ╚═╝
	███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
	████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
	██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
	██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
	██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
	╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]],
		keys = {
			{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
			{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
			{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
			{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
			{
				icon = "",
				key = "c",
				desc = "Config",
				action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
			},
			{
				icon = " ",
				key = ".",
				desc = "Config",
				action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.expand('$HOME/.dotfiles')})",
			},
			{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
		},
	},
	-- formats = {
	-- 	key = function(item)
	-- 		return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
	-- 	end,
	-- },
	sections = {
		{ section = "terminal", cmd = "echo 'hola kuro' | cowsay ", hl = "header", padding = 1, indent = 3 },
		{ section = "keys" },
		{ title = "Recen Files", padding = { 0, 2 } },
		{ section = "recent_files", indent = 6, limit = 4, padding = { 2, 0 } },
		{ title = "/CWD", file = vim.fn.fnamemodify(".", ":~"), padding = { 0, 0 } },
		{ section = "recent_files", indent = 6, cwd = true, limit = 4, padding = { 2, 0 } },
	},
}

local harpoon = require("harpoon")
local key = require("which-key")

harpoon:setup({})

key.add({
	-- =========================
	-- HARPOON CORE
	-- =========================
	{
		"<C-a>",
		function()
			harpoon:list():add()
		end,
		desc = "Add harpoon",
		icon = "",
	},

	{
		"<C-e>",
		function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		desc = "Quick Menu Harpoon",
		icon = "󰍜",
	},

	-- =========================
	-- HARPOON SELECT
	-- =========================
	{
		"<C-h>",
		function()
			harpoon:list():select(1)
		end,
		desc = "Harpoon file 1",
		icon = "󰛢",
	},
	{
		"<C-t>",
		function()
			harpoon:list():select(2)
		end,
		desc = "Harpoon file 2",
		icon = "󰛢",
	},
	{
		"<C-n>",
		function()
			harpoon:list():select(3)
		end,
		desc = "Harpoon file 3",
		icon = "󰛢",
	},
	{
		"<C-s>",
		function()
			harpoon:list():select(4)
		end,
		desc = "Harpoon file 4",
		icon = "󰛢",
	},

	-- =========================
	-- HARPOON NAV
	-- =========================
	{
		"<leader>hp",
		function()
			harpoon:list():prev()
		end,
		desc = "Harpoon prev",
		icon = "󰛢",
	},
	{
		"<leader>hn",
		function()
			harpoon:list():next()
		end,
		desc = "Harpoon next",
		icon = "󰛢",
	},
})

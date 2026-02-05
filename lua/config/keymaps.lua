local harpoon = require("harpoon")
local key = require("which-key")

harpoon:setup({})

key.add({
	-- =========================
	-- BUFFER NAVIGATION
	-- =========================
	{
		"<S-Tab>",
		vim.cmd.bprevious,
		desc = "Buffer previous",
		icon = "⬅️",
	},
	{
		"<Tab>",
		vim.cmd.next,
		desc = "Buffer next",
		icon = "➡️",
	},

	-- =========================
	-- EDITING
	-- =========================
	{
		"<leader>o",
		"o<Esc>k",
		desc = "Insert line below (stay normal)",
		icon = "⤵️",
	},
	{
		"<leader>x",
		vim.cmd.bdelete,
		desc = "Delete buffer",
		icon = "",
	},
	{
		"<leader>a",
		"ggVG",
		desc = "Select all",
		icon = "󰒆",
	},

	-- =========================
	-- CLIPBOARD
	-- =========================
	{
		"<leader>y",
		'"+yy',
		desc = "Yank line to system clipboard",
		icon = "",
	},

	-- =========================
	-- DIAGNOSTICS
	-- =========================
	{
		"<leader>dy",
		function()
			vim.diagnostic.open_float()
		end,
		desc = "Show diagnostics (float)",
	},
    {
		"<s-r>",
		function()
			vim.cmd.LspRestart()
		end,
		desc = "LSP restart",
		icon = "🔄",
	},

	-- =========================
	-- SEARCH
	-- =========================
	{
		"<leader>fi",
		"/",
		desc = "Search forward",
		icon = "",
	},
})

return {
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{ "nvzone/volt", lazy = true },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"junegunn/vim-easy-align",

		keys = {

			{ "ga", "<plug>(EasyAlign)", desc = "Easy Align", mode = { "n", "x" } },
		},
	},
	{
		"nvzone/Typr",
		lazy = true,
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"nvim-mini/mini.splitjoin",
		keys = { { "<leader>cs" } },
		config = function()
			require("mini.splitjoin").setup({ mappings = { toggle = "<leader>cs" } })
		end,
	},
	{
		"nvim-mini/mini.cursorword",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
		config = function()
			require("mini.cursorword").setup()
		end,
	},
}

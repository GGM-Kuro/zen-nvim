return {
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({})
		end,
	},
	{ "nvzone/volt", lazy = true },
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
	{ "nvim-mini/mini.splitjoin", config = true },
}

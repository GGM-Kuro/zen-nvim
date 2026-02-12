return {
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "eandrju/cellular-automaton.nvim",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
	    "nvim-mini/mini.splitjoin",
	    keys = { { "gs" } },
	    config = function() require("mini.splitjoin").setup({ mappings = { toggle = "gs" } }) end,
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{ "nvzone/volt", lazy = true },
	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
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

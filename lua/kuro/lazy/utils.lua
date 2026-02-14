return {
	"eandrju/cellular-automaton.nvim",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"nvim-mini/mini.splitjoin",
		keys = { { "gs" } },
		config = function()
			require("mini.splitjoin").setup({ mappings = { toggle = "gs" } })
		end,
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
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		conifg = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 300,
				},
			})
		end,
	},
}

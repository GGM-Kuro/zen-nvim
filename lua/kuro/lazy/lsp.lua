return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"onsails/lspkind.nvim",
		"windwp/nvim-autopairs",
	},

	config = function()
		require("kuro.configs.lsp")
	end,
}

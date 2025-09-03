local formatters = {
	lua = { "stylua", lsp_format = "fallback" },
	nix = { "nixfmt" },
	json = { "jq" },
	python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
}

if require("nixCatsUtils").enableForCategory("go") then
	formatters.go = { "gofmt", "goimports" }
end

return {
	"stevearc/conform.nvim",

	opts = {
		formatters_by_ft = formatters,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	keys = {

		{
			"<leader>vf",
			function()
				require("conform").format({ lsp_format = "fallback" })
			end,
			desc = "Format with Conform",
		},
	},
}

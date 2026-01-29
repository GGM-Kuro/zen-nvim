return {
	"saghen/blink.cmp",
	opts = {
		function(_, opts)
			opts.appearance = opts.appearance or {}
			opts.appearance.kind_icons =
				vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
		end,
		keymap = {
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_signature_up", "fallback" },
			["<C-f>"] = { "scroll_signature_down", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<C-c>"] = { "cancel", "fallback" },
			["<C-e>"] = { "accept" },
		},
	},
	{
		"rafamadriz/friendly-snippets",
		-- add blink.compat to dependencies
		{
			"saghen/blink.compat",
			optional = true, -- make optional so it's only enabled if any extras need it
			opts = {},
			version = not vim.g.lazyvim_blink_main and "*",
		},
	},
}

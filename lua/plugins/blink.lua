return {
	"saghen/blink.cmp",
	opts = {
		keymap = {
			--  preset = "none", -- desactiva el preset para tener control total

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_signature_up", "fallback" },
			["<C-f>"] = { "scroll_signature_down", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<C-c>"] = { "cancel", "fallback" },
			["<C-e>"] = { "accept" },
		},
	},
}

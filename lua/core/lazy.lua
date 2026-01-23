local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- Add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- Import any extra modules here
		-- Editor plugins
		-- { import = "lazyvim.plugins.extras.editor.harpoon2" },
		-- { import = "lazyvim.plugins.extras.editor.mini-files" },
		-- -- { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
		-- { import = "lazyvim.plugins.extras.editor.snacks_picker" },

		-- Debgugging plugins
		-- { import = "lazyvim.plugins.extras.dap.core" },

		-- Formatting plugins
		-- { import = "lazyvim.plugins.extras.formatting.biome" },
		-- { import = "lazyvim.plugins.extras.formatting.prettier" },

		-- Linting plugins
		-- { import = "lazyvim.plugins.extras.linting.eslint" },

		-- Language support plugins
		-- { import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.lang.markdown" },
		--
		-- -- Coding plugins
		-- { import = "lazyvim.plugins.extras.coding.mini-surround" },
		-- { import = "lazyvim.plugins.extras.editor.mini-diff" },
		-- { import = "lazyvim.plugins.extras.coding.blink" },
		--
		-- -- Utility plugins
		-- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		--
		-- -- AI plugins
		-- { import = "lazyvim.plugins.extras.ai.copilot" },
		{ import = "plugins" },
	},
	default = {
		lazy = true,
	},
	checker = { enabled = true, notify = false },
	dev = {
		path = "~/code/plugins",
		fallback = true,
		patterns = { "adalessa" },
	},
	ui = {
		border = "rounded",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

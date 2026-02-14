return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"python",
					"c",
					"lua",
					"rust",
					"jsdoc",
					"bash",
					"go",
				},
				sync_install = false,
				auto_install = true,
				indent = { enable = true },
				highlight = {
					enable = true,
					disable = function(lang, buf)
						if lang == "html" then
							return true
						end
						local max_filesize = 100 * 1024
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify(
								"File larger than 100KB treesitter disabled for performance",
								vim.log.levels.WARN,
								{ title = "Treesitter" }
							)
							return true
						end
					end,
					additional_vim_regex_highlighting = { "markdown" },
				},
			})

			local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			treesitter_parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}
			vim.treesitter.language.register("templ", "templ")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			local keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
			}

			for key, query in pairs(keymaps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end)
			end

			local move_keymaps = {
				["]f"] = { fn = move.goto_next_start, query = "@function.outer" },
				["]F"] = { fn = move.goto_next_end, query = "@function.outer" },
				["[f"] = { fn = move.goto_previous_start, query = "@function.outer" },
				["[F"] = { fn = move.goto_previous_end, query = "@function.outer" },
				["]c"] = { fn = move.goto_next_start, query = "@conditional.outer" },
				["[c"] = { fn = move.goto_previous_start, query = "@conditional.outer" },
				["]l"] = { fn = move.goto_next_start, query = "@loop.outer" },
				["[l"] = { fn = move.goto_previous_start, query = "@loop.outer" },
			}

			for key, opts in pairs(move_keymaps) do
				vim.keymap.set("n", key, function()
					opts.fn(opts.query, "textobjects")
				end)
			end

			local swap_keymaps = {
				["<c-p>"] = { fn = swap.swap_next, query = "@parameter.inner" },
				["<c-s-p>"] = { fn = swap.swap_previous, query = "@parameter.inner" },
			}

			for key, opts in pairs(swap_keymaps) do
				vim.keymap.set("n", key, function()
					opts.fn(opts.query, "textobjects")
				end)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
}

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		-- "nvimtools/hydra.nvim",
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		{ "williamboman/mason.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
		{ "jay-babu/mason-nvim-dap.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
	},
	config = function()
		local dap, dapui, hydra = require("dap"), require("dapui"), require("hydra")

		vim.fn.sign_define("DapBreakpoint", {
			text = " ",
			texthl = "DiagnosticSignError",
		})
		vim.fn.sign_define("DapBreakpointCondition", {
			text = " ",
			texthl = "DiagnosticSignWarn",
		})
		vim.fn.sign_define("DapStopped", {
			text = " ",
			texthl = "DiagnosticSignInfo",
		})
		vim.fn.sign_define("DapLogPoint", {
			text = " ",
			texthl = "DiagnosticSignInfo",
		})

		-- NOTE: nixCats: dont use mason on nix. We can already download stuff just fine.
		if not require("nixCatsUtils").isNixCats then
			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
				},
			})
		end

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
			--- A callback that determines how a variable is displayed or whether it should be omitted
			--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
			--- @param buf number
			--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
			--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
			--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
			--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
			display_callback = function(variable, buf, stackframe, node, options)
				-- by default, strip out new line characters
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value:gsub("%s+", " ")
				else
					return variable.name .. " = " .. variable.value:gsub("%s+", " ")
				end
			end,
			-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

			-- experimental features:
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
			-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
		})

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		-- vim.keymap.set("n", "<leader>d", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
			},
			layouts = {
				{
					elements = { "scopes", "watches", "stacks", "breakpoints" },
					size = 60,
					position = "right",
				},
				{ elements = { "console", "repl" }, size = 0.25, position = "bottom" },
			},
			render = { indent = 2 },
			tray = {
				open_on_start = true,
				elements = { "repl" },
				size = 10,
				position = "right", -- Can be "left", "right", "top", "bottom"
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
		})
-- 		-- Menu
-- 		local hint = [[
--  Nvim DAP
--  _d_: Start/Continue  _j_: StepOver _k_: StepOut _l_: StepInto ^
--  _bp_: Toggle Breakpoint  _bc_: Conditional Breakpoint ^
--  _?_: log point ^
--  _c_: Run To Cursor ^
--  _h_: Show information of the variable under the cursor ^
--  _x_: Stop Debbuging ^
--  ^^                                                      _<Esc>_
-- ]]
--
-- 		hydra({
-- 			name = "dap",
-- 			hint = hint,
-- 			mode = "n",
-- 			config = {
-- 				color = "blue",
-- 				invoke_on_body = true,
-- 				hint = {
-- 					position = "bottom",
-- 				},
-- 			},
-- 			body = "<M-d>",
-- 			heads = {
-- 				{ "d", dap.continue },
-- 				{ "bp", dap.toggle_breakpoint },
-- 				{ "l", dap.step_into },
-- 				{ "j", dap.step_over },
-- 				{ "k", dap.step_out },
-- 				{ "h", dapui.eval },
-- 				{ "c", dap.run_to_cursor },
-- 				{
-- 					"bc",
-- 					function()
-- 						vim.ui.input({ prompt = "Condition: " }, function(condition)
-- 							dap.set_breakpoint(condition)
-- 						end)
-- 					end,
-- 				},
-- 				{
-- 					"?",
-- 					function()
-- 						vim.ui.input({ prompt = "Log: " }, function(log)
-- 							dap.set_breakpoint(nil, nil, log)
-- 						end)
-- 					end,
-- 				},
-- 				{
-- 					"x",
-- 					function()
-- 						dap.terminate()
-- 						dapui.close({})
-- 						dap.clear_breakpoints()
-- 					end,
-- 				},
--
-- 				{ "<Esc>", nil, { exit = true } },
-- 			},
-- 		})
--
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F8>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.adapters.dart = {
			type = "executable",
			-- As of this writing, this functionality is open for review in https://github.com/flutter/flutter/pull/91802
			command = "flutter",
			args = { "debug_adapter" },
		}
		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch Flutter Program",
				-- The nvim-dap plugin populates this variable with the filename of the current buffer
				program = "${workspaceFolder}/lib/main.dart",
				-- The nvim-dap plugin populates this variable with the editor's current working directory
				cwd = "${workspaceFolder}",
				-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
				-- toolArgs = { "-d", "Android" },
			},
		}
	end,
}

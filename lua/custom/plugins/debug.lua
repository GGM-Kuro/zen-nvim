return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
        'theHamsta/nvim-dap-virtual-text',
		{ "williamboman/mason.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
		{ "jay-babu/mason-nvim-dap.nvim", enabled = require("nixCatsUtils").lazyAdd(true, false) },
	},
	config = function()
		local dap = require("dap")

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

		local dap = require("dap")
		local dapui = require("dapui")

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

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader><leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
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
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

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
				program = "${file}",
				-- The nvim-dap plugin populates this variable with the editor's current working directory
				cwd = "${workspaceFolder}",
				-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
				-- toolArgs = { "-d", "linux" },
			},
		}
	end,
}

-- ============================================================================
-- DAP Main Plugin File
-- Este archivo define los plugins y carga las configuraciones desde configs/dap/
-- ============================================================================

return {
	-- ========================================================================
	-- DAP Core
	-- ========================================================================
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
			{ "<F8>", function() require("dap").continue() end, desc = "Debug: Continue" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
			{ "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
			{ "<leader>B", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, desc = "Debug: Set Conditional Breakpoint" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
		},
		config = function()
			require("kuro.configs.dap.init")
		end,
	},

	-- ========================================================================
	-- DAP Python
	-- ========================================================================
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		keys = {
			{ "<leader>dpm", function() require("dap-python").test_method() end, desc = "Debug: Python Test Method" },
			{ "<leader>dpc", function() require("dap-python").test_class() end, desc = "Debug: Python Test Class" },
			{ "<leader>dps", function() require("dap-python").debug_selection() end, desc = "Debug: Python Selection", mode = "v" },
		},
		config = function()
			require("kuro.configs.dap.python")
		end,
	},

	-- ========================================================================
	-- DAP UI
	-- ========================================================================
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
			{ "<leader>de", function() require("dapui").eval() end, desc = "Debug: Eval", mode = { "n", "v" } },
			{ "<leader>dr", function() require("dapui").float_element("repl") end, desc = "Debug: Toggle REPL" },
			{ "<leader>ds", function() require("dapui").float_element("stacks") end, desc = "Debug: Toggle Stacks" },
			{ "<leader>dw", function() require("dapui").float_element("watches") end, desc = "Debug: Toggle Watches" },
			{ "<leader>db", function() require("dapui").float_element("breakpoints") end, desc = "Debug: Toggle Breakpoints" },
			{ "<leader>dS", function() require("dapui").float_element("scopes") end, desc = "Debug: Toggle Scopes" },
			{ "<leader>dc", function() require("dapui").float_element("console") end, desc = "Debug: Toggle Console" },
		},
		config = function()
			require("kuro.configs.dap.ui")
		end,
	},

	-- ========================================================================
	-- Mason DAP
	-- ========================================================================
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		cmd = { "DapInstall", "DapUninstall" },
		config = function()
			require("kuro.configs.dap.mason")
		end,
	},
}

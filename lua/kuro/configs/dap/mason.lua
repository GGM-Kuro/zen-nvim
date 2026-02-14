-- ============================================================================
-- Mason DAP Configuration
-- Instalación y configuración automática de debug adapters
-- ============================================================================

require("mason-nvim-dap").setup({
	-- ========================================================================
	-- Adapters a instalar automáticamente
	-- ========================================================================
	ensure_installed = {
		"python", -- debugpy para Python
		-- Descomenta los que necesites:
		-- "delve",              -- Go
		-- "codelldb",           -- Rust, C, C++
		-- "js-debug-adapter",   -- JavaScript/TypeScript
		-- "php-debug-adapter",  -- PHP
		-- "bash-debug-adapter", -- Bash
	},

	-- Instalación automática cuando se abre un archivo del lenguaje
	automatic_installation = true,

	-- ========================================================================
	-- Handlers para configuración específica por lenguaje
	-- ========================================================================
	handlers = {
		-- Handler por defecto para todos los adapters
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,

		-- Handler específico para Delve (Go)
		delve = function(config)
			config.configurations = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug with arguments",
					request = "launch",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +")
					end,
				},
				{
					type = "delve",
					name = "Debug test",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			require("mason-nvim-dap").default_setup(config)
		end,

		-- Handler para JavaScript/TypeScript
		["js-debug-adapter"] = function(config)
			-- Configuración específica para JS/TS si la necesitas
			require("mason-nvim-dap").default_setup(config)
		end,

		-- Handler para Rust/C/C++ (CodeLLDB)
		codelldb = function(config)
			config.configurations = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

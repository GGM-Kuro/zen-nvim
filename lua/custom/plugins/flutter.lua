return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = function()
		-- Configuración de flutter-tools
		require("flutter-tools").setup({
			ui = {
				border = "rounded",
				notification_style = "plugin",
			},
			decorations = {
				statusline = {
					app_version = false,
					device = false,
					project_config = false,
				},
			},
			debugger = {
				enabled = false,
				exception_breakpoints = {},
				evaluate_to_string_in_debug_views = true,
			},
			closing_tags = {
				highlight = "ErrorMsg",
				prefix = ">",
				priority = 10,
				enabled = true,
			},
			dev_log = {
				enabled = true,
				filter = nil,
				notify_errors = false,
				open_cmd = "15split",
				focus_on_open = true,
			},
			dev_tools = {
				autostart = false,
				auto_open_browser = true,
			},
			widget_guides = {
				enabled = true,
			},
			outline = {
				open_cmd = "30vnew",
				auto_open = false,
			},
		})

		-- Funcionalidad extendida para seleccionar y ejecutar comandos Flutter
		local M = {}
		local commands = require("flutter-tools.commands")
		local devices = require("flutter-tools.devices")

		-- Lista de comandos disponibles
		function M.get_flutter_commands()
			return {
				{ label = "Flutter Run", command = commands.run },
				{ label = "Flutter Debug", command = "FlutterDebug" },
				{ label = "Flutter Reload", command = commands.reload },
				{ label = "Flutter Restart", command = commands.restart },
				{ label = "Flutter Quit", command = commands.quit },
				{ label = "Flutter Attach", command = commands.attach },
				{ label = "Flutter Detach", command = commands.detach },
				{ label = "Flutter Outline Toggle", command = "FlutterOutlineToggle" },
				{ label = "Flutter DevTools", command = "FlutterDevTools" },
				{ label = "Flutter DevTools Activate", command = "FlutterDevToolsActivate" },
				{ label = "Flutter Copy Profiler Url", command = commands.copy_profiler_url },
				{ label = "Flutter LSP Restart", command = "FlutterLspRestart" },
				{ label = "Flutter Super", command = "FlutterSuper" },
				{ label = "Flutter Reanalyze", command = "FlutterReanalyze" },
				{ label = "Flutter Rename", command = "FlutterRename" },
				{ label = "Flutter Log Clear", command = "FlutterLogClear" },
				{ label = "Flutter Log Toggle", command = "FlutterLogToggle" },
				{ label = "Flutter Devices", command = devices.list_devices },
				{ label = "Flutter Emulators", command = devices.list_emulators },
			}
		end

		-- Selector de comandos con vim.ui.select
		function M.select_flutter_command()
			local cmds = M.get_flutter_commands()

			vim.ui.select(cmds, {
				prompt = "Selecciona un comando Flutter:",
				format_item = function(item)
					return item.label
				end,
			}, function(selected_command)
				if selected_command then
					local cmd = selected_command.command

					if type(cmd) == "function" then
						local success, msg = pcall(cmd)
						if not success then
							vim.notify(msg, vim.log.levels.ERROR)
						end
					elseif type(cmd) == "string" then
						vim.cmd(cmd)
					else
						vim.notify("Tipo de comando no soportado.", vim.log.levels.ERROR)
					end
				else
					vim.notify("No se seleccionó ningún comando.", vim.log.levels.WARN)
				end
			end)
		end

		-- Mapear tecla para abrir el selector
		vim.keymap.set({ "n" }, "<leader>mm", function()
			M.select_flutter_command()
		end, { desc = "Seleccionar y ejecutar un comando Flutter" })
	end,
}

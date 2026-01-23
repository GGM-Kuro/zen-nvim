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
				enabled = true,
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
				enabled = false,
				filter = nil,
				notify_errors = false,
				open_cmd = "15split",
				focus_on_open = false,
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

		--- Obtiene todos los comandos de Neovim que empiecen por "Flutter"
		function M.get_flutter_commands()
			local cmds = vim.api.nvim_get_commands({})
			local flutter_cmds = {}

			for name, _ in pairs(cmds) do
				if name:match("^Flutter") then
					table.insert(flutter_cmds, name)
				end
			end

			table.sort(flutter_cmds)
			return flutter_cmds
		end

		--- Muestra el menú con vim.ui.select
		function M.select_flutter_command()
			local cmds = M.get_flutter_commands()

			if #cmds == 0 then
				vim.notify("No se encontraron comandos Flutter registrados.", vim.log.levels.WARN)
				return
			end

			vim.ui.select(cmds, {
				prompt = "Selecciona un comando Flutter:",
				format = "file",
			}, function(selected)
				if selected then
					vim.cmd(selected)
				else
					vim.notify("No se seleccionó ningún comando.", vim.log.levels.WARN)
				end
			end)
		end

		-- Mapeo de tecla para abrir el selector
		vim.keymap.set("n", "<M-f>", M.select_flutter_command, {
			desc = "Seleccionar y ejecutar un comando Flutter",
		})
	end,
}

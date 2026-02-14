-- ============================================================================
-- DAP UI Configuration - Versión Mejorada
-- Configuración de la interfaz de usuario para DAP con controles estables
-- ============================================================================

-- Crear autogroup para eventos de DAP
vim.api.nvim_create_augroup("DapGroup", { clear = true })

-- ============================================================================
-- Función para navegar automáticamente a ventanas de DAP
-- ============================================================================

local function navigate_to_dap_window(args)
	local buffer = args.buf
	local target_window = nil

	-- Buscar la ventana que contiene el buffer
	for _, win_id in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win_id) == buffer then
			target_window = win_id
			break
		end
	end

	if not target_window then
		return
	end

	-- Cambiar a la ventana encontrada
	vim.schedule(function()
		if vim.api.nvim_win_is_valid(target_window) then
			vim.api.nvim_set_current_win(target_window)
		end
	end)
end

-- ============================================================================
-- Setup de DAP UI
-- ============================================================================

local dapui = require("dapui")

dapui.setup({
	-- ========================================================================
	-- Configuración de Controles (los botones que ves en la UI)
	-- ========================================================================
	controls = {
		enabled = true,
		-- Elemento donde aparecerán los controles
		-- Opciones: "repl", "console", o cualquier otro elemento
		element = "repl",
		icons = {
			disconnect = "󱘖",
			pause = "",
			play = "",
			run_last = "󰑙",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},

	-- ========================================================================
	-- Configuración de Elementos
	-- ========================================================================
	element_mappings = {
		-- Mapeos personalizados por elemento si los necesitas
	},
	expand_lines = true,

	-- ========================================================================
	-- Configuración de Ventanas Flotantes
	-- ========================================================================
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
		max_height = 0.9,
		max_width = 0.9,
	},

	force_buffers = true,

	-- ========================================================================
	-- Iconos para el árbol de elementos
	-- ========================================================================
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},

	-- ========================================================================
	-- Layouts - Distribución de las ventanas
	-- ========================================================================
	layouts = {
		-- Layout 1: Panel lateral izquierdo
		{
			elements = {
				-- Variables en scope actual (muy útil)
				{ id = "scopes", size = 0.40 },
				-- Lista de breakpoints
				{ id = "breakpoints", size = 0.20 },
				-- Call stack
				{ id = "stacks", size = 0.20 },
				-- Variables watcheadas manualmente
				{ id = "watches", size = 0.20 },
			},
			position = "left",
			size = 45,  -- Ancho del panel
		},

		-- Layout 2: Panel inferior
		{
			elements = {
				-- REPL interactivo (aquí aparecen los controles)
				{ id = "repl", size = 0.50 },
				-- Console output
				{ id = "console", size = 0.50 },
			},
			position = "bottom",
			size = 15,  -- Altura del panel (aumentado para ver controles)
		},
	},

	-- ========================================================================
	-- Mapeos de teclado dentro de DAP UI
	-- ========================================================================
	mappings = {
		edit = "e",                      -- Editar valor
		expand = { "<CR>", "<2-LeftMouse>" }, -- Expandir elemento
		open = "o",                      -- Abrir
		remove = "d",                    -- Remover watch
		repl = "r",                      -- Abrir REPL
		toggle = "t",                    -- Toggle expand/collapse
	},

	-- ========================================================================
	-- Configuración de Renderizado
	-- ========================================================================
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})

-- ============================================================================
-- Autocmds para Mejorar la Experiencia
-- ============================================================================

-- Navegación automática al REPL
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "DapGroup",
	pattern = "*dap-repl*",
	callback = navigate_to_dap_window,
})

-- Navegación automática a Watches
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "DapGroup",
	pattern = "*DAP Watches*",
	callback = navigate_to_dap_window,
})

-- Habilitar wrap en el REPL para mejor lectura
vim.api.nvim_create_autocmd("BufEnter", {
	group = "DapGroup",
	pattern = "*dap-repl*",
	callback = function()
		vim.wo.wrap = true
		vim.wo.linebreak = true
		-- Asegurar que el buffer no sea readonly para poder interactuar
		vim.bo.modifiable = true
	end,
})

-- Configurar opciones cuando se entra a la consola
vim.api.nvim_create_autocmd("BufEnter", {
	group = "DapGroup",
	pattern = "*DAP Console*",
	callback = function()
		vim.wo.wrap = true
		vim.wo.linebreak = true
	end,
})

-- ============================================================================
-- Listeners de Eventos DAP
-- ============================================================================

local dap = require("dap")

-- Abrir UI automáticamente cuando inicia el debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

-- Cerrar UI cuando termina el debugging
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

-- Cerrar UI cuando sale del programa
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Redirigir output de consola a la ventana Console
dap.listeners.after.event_output["dapui_config"] = function(_, body)
	if body.category == "console" or body.category == "stdout" or body.category == "stderr" then
		-- Abrir console si hay output, pero sin robar el foco
		vim.schedule(function()
			-- Solo mostrar la console, no cambiar el foco
			local wins = vim.api.nvim_list_wins()
			local console_visible = false

			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				local bufname = vim.api.nvim_buf_get_name(buf)
				if bufname:match("DAP Console") then
					console_visible = true
					break
				end
			end

			-- Si la console no está visible, mostrarla como flotante brevemente
			if not console_visible then
				dapui.float_element("console", { enter = false })
			end
		end)
	end
end

-- ============================================================================
-- Función Helper para Debugging del UI (opcional)
-- ============================================================================

-- Comando para recargar el UI si algo sale mal
vim.api.nvim_create_user_command("DapUIReload", function()
	dapui.close()
	vim.defer_fn(function()
		dapui.open()
	end, 100)
end, { desc = "Reload DAP UI" })

-- Comando para verificar estado de los controles
vim.api.nvim_create_user_command("DapUIDebug", function()
	local info = {
		controls_enabled = true,
		layouts_count = 2,
		current_session = dap.session() ~= nil,
	}
	print(vim.inspect(info))
end, { desc = "Debug DAP UI state" })

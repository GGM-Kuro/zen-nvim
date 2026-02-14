-- ============================================================================
-- DAP Python Configuration
-- Configuración específica para debugging de Python con debugpy
-- ============================================================================

-- Path a debugpy instalado por Mason
local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

-- Setup dap-python
require("dap-python").setup(debugpy_path)

-- ============================================================================
-- Función helper para detectar Python en entornos virtuales
-- ============================================================================

local function get_python_path()
	local cwd = vim.fn.getcwd()

	-- Buscar venv en el directorio actual
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	elseif vim.fn.executable(cwd .. "/env/bin/python") == 1 then
		return cwd .. "/env/bin/python"
	else
		-- Fallback a python del sistema
		return "/usr/bin/python3"
	end
end

-- ============================================================================
-- Configuraciones de Python para DAP
-- ============================================================================

local dap = require("dap")

dap.configurations.python = {
	-- Configuración básica: ejecutar archivo actual
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = get_python_path,
	},

	-- Ejecutar con argumentos
	{
		type = "python",
		request = "launch",
		name = "Launch file with arguments",
		program = "${file}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " +")
		end,
		pythonPath = get_python_path,
	},

	-- Django development server
	{
		type = "python",
		request = "launch",
		name = "Django",
		program = "${workspaceFolder}/manage.py",
		args = {
			"runserver",
			"--noreload",
		},
		justMyCode = true,
		django = true,
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},

	-- Flask application
	{
		type = "python",
		request = "launch",
		name = "Flask",
		module = "flask",
		env = {
			FLASK_APP = "app.py",
			FLASK_DEBUG = "1",
		},
		args = {
			"run",
			"--no-debugger",
			"--no-reload",
		},
		jinja = true,
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},

	-- FastAPI con uvicorn
	{
		type = "python",
		request = "launch",
		name = "FastAPI",
		module = "uvicorn",
		args = {
			"main:app",
			"--reload",
		},
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},

	-- Pytest: ejecutar archivo actual
	{
		type = "python",
		request = "launch",
		name = "Pytest: Current File",
		module = "pytest",
		args = {
			"${file}",
			"-v",
			"-s",
		},
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},

	-- Pytest: ejecutar todos los tests
	{
		type = "python",
		request = "launch",
		name = "Pytest: All",
		module = "pytest",
		args = {
			"-v",
			"-s",
		},
		console = "integratedTerminal",
		pythonPath = get_python_path,
	},

	-- Debugging remoto
	{
		type = "python",
		request = "attach",
		name = "Attach remote",
		connect = function()
			local host = vim.fn.input("Host [127.0.0.1]: ")
			host = host ~= "" and host or "127.0.0.1"
			local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
			return { host = host, port = port }
		end,
		pythonPath = get_python_path,
	},

	-- Debugging de módulo Python
	{
		type = "python",
		request = "launch",
		name = "Module",
		module = function()
			return vim.fn.input("Module name: ")
		end,
		pythonPath = get_python_path,
	},
}

-- ============================================================================
-- Configuración adicional para testing
-- ============================================================================

-- Configurar pytest para usar el interprete correcto
require("dap-python").test_runner = "pytest"

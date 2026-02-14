-- ============================================================================
-- DAP Core Configuration
-- Configuración base de DAP: signos, log level, etc.
-- ============================================================================

local dap = require("dap")

-- Set log level para debugging
dap.set_log_level("INFO")

-- ============================================================================
-- Signos personalizados para breakpoints
-- ============================================================================

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "◆",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "○",
	texthl = "DapBreakpoint",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	text = "→",
	texthl = "DapStopped",
	linehl = "DapStoppedLine",
	numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
	text = "◉",
	texthl = "DapLogPoint",
	linehl = "",
	numhl = "",
})

-- ============================================================================
-- Colores para los signos (opcional, ajusta según tu tema)
-- ============================================================================

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2b2b2b" })

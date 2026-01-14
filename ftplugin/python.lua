-- Indentación para Python (PEP 8 recomienda 4 espacios)
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

vim.bo.autoindent = true
vim.bo.smartindent = true

-- Color de guía de columnas en 79 caracteres (PEP 8)
vim.wo.colorcolumn = "79"

-- ftplugin/python.lua

-- local bufnr = vim.api.nvim_get_current_buf()
--
-- -- Evita reiniciar TS múltiples veces
-- if vim.b[bufnr].treesitter_started then
--   return
-- end
--
-- local ok = pcall(vim.treesitter.start, bufnr)
-- if ok then
--   vim.b[bufnr].treesitter_started = true
-- end
--
--
--

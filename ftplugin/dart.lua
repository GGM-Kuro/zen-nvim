-- Indentación estándar de Dart/Flutter
vim.bo.tabstop = 2          -- Un tab = 2 espacios
vim.bo.shiftwidth = 2       -- Nivel de indentación = 2 espacios
vim.bo.softtabstop = 2      -- Insertar 2 espacios cuando presiones tab
vim.bo.expandtab = true     -- Reemplaza tabs con espacios

-- Opciones de formato automático
vim.bo.autoindent = true
vim.bo.smartindent = true

-- Opcional: eliminar espacios al final automáticamente (requiere autocommand)
-- vim.cmd [[autocmd BufWritePre *.dart %s/\s\+$//e]]

-- Usa el LSP 'dartls' si lo tienes configurado
-- flutter-tools.nvim lo configura automáticamente si está instalado

-- Opcional: activar el formato al guardar si el LSP lo soporta
-- Esto se hace mejor como autocomando global, pero puede hacerse aquí también:
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.dart",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Opcional: setea colorcolumn a 80 (línea guía de estilo de Dart)
vim.wo.colorcolumn = "80"


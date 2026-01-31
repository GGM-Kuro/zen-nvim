vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*" },
	callback = function()
		vim.b.autoformat = false
	end,
})

local augroup = vim.api.nvim_create_augroup("TrimWhitespaceAndEOL", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    -- Guardamos solo la línea actual
    local row = vim.api.nvim_win_get_cursor(0)[1]

    -- Elimina espacios en blanco al final de cada línea
    vim.cmd([[silent! %s/\s\+$//e]])

    -- Elimina saltos de línea extra al final del archivo
    vim.cmd([[silent! %s/\n\+\%$//e]])

    -- Coloca el cursor al final de la línea original
    vim.api.nvim_win_set_cursor(0, { row, math.max(vim.fn.col("$") - 1, 0) })
  end,
})

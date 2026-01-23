---@ vim.lsp.config
return {
    cmd = { 'ruff-lsp'},
    filetypes = { 'python'},
    root_markers = { 'pyprojects.toml', 'ruff.toml', '.git'},
    settings = {},
}

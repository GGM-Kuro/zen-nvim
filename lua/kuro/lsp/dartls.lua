---@type table

return {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
  single_file_support = true,

  on_new_config = function(new_config, new_root_dir)
    -- Código al cambiar configuración
  end,
}


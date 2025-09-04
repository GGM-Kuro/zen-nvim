---@type vim.lsp.Config
return {
  cmd = { "pylsp" }, -- fallback global
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".venv",
  },
  single_file_support = true,

  on_new_config = function(new_config, new_root_dir)
    -- Detectar venv local
    local venv_path = new_root_dir .. "/.venv/bin/python"
    if vim.fn.executable(venv_path) == 1 then
      new_config.cmd = { venv_path, "-m", "pylsp" }
    elseif vim.env.VIRTUAL_ENV then

      -- Si tienes $VIRTUAL_ENV activo
      new_config.cmd = { vim.env.VIRTUAL_ENV .. "/bin/python", "-m", "pylsp" }
    end
  end,
}


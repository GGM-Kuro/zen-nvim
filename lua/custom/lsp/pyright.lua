---@type vim.lsp.Config
return {
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
    local venv = new_root_dir .. "/.venv/bin/python"
    if vim.fn.executable(venv) == 1 then
      new_config.settings = {
        python = {
          pythonPath = venv,
        },
      }
    elseif vim.env.VIRTUAL_ENV then
      new_config.settings = {
        python = {
          pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python",
        },
      }
    else
      new_config.settings = {
        python = {
          pythonPath = "python",
        },

      }
    end
  end,
}


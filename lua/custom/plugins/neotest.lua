local dependencies = {
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-neotest/neotest-plenary",
  "nvim-neotest/neotest-python",
}

if require("nixCatsUtils").enableForCategory("go") then
  table.insert(dependencies, "fredrikaverpil/neotest-golang")
end

-- función que busca la raíz del proyecto
local function get_project_root()
  local cwd = vim.fn.getcwd()
  local pyproject = vim.fn.findfile("pyproject.toml", cwd .. ";")
  if pyproject ~= "" then
    return vim.fn.fnamemodify(pyproject, ":h")
  end

  local pytest_ini = vim.fn.findfile("pytest.ini", cwd .. ";")
  if pytest_ini ~= "" then
    return vim.fn.fnamemodify(pytest_ini, ":h")
  end

  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    return git_root
  end

  return cwd
end

return {
  "nvim-neotest/neotest",
  dependencies = dependencies,
  keys = {
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>tm",
      function()
        require("neotest").summary.run_marked()
      end,
      desc = "Run marked tests",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run tests in current file",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Open test output",
    },
    {
      "<leader>ti",
      function()
        require("neotest").output.open({ enter = true, last_run = true })
      end,
      desc = "Open last test output",
    },
    {
      "<leader>tpo",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>tpl",
      function()
        require("neotest").output_panel.clear()
      end,
      desc = "Clear output panel",
    },
  },
  config = function()
    local adapters = {
      require("neotest-plenary"),
    }

    if require("nixCatsUtils").enableForCategory("python") then
      table.insert(adapters, require("neotest-python")({
        dap = { justMyCode = false },
        runner = "pytest",
        python = ".venv/bin/python",
        args = { "-v" },
        cwd = get_project_root, -- 👈 root dinámico
      }))
    end

    if require("nixCatsUtils").enableForCategory("go") then
      table.insert(adapters, require("neotest-golang")({
        go_test_args = { "-v", "-count=1" },
      }))
    end

    require("neotest").setup({
      adapters = adapters,
    })
  end,
}

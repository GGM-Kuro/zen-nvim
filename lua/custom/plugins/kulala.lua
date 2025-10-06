return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },

  config = function()
    -- Asegura que el filetype .http sea correctamente interpretado
    vim.filetype.add({
      extension = {
        http = "http",
      },
    })

    -- Redirige la instalación de parsers a un path escribible
    require("nvim-treesitter.install").set_custom_parser_install_dir(
      vim.fn.stdpath("data") .. "/parsers"
    )

    -- Asegura que el path esté en runtimepath
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/parsers")

    -- Si quieres seguir usando opts, los puedes aplicar manualmente aquí
    require("kulala").setup({
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    })
  end,
}


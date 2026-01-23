return{
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = true,
  keys = {
    {"-","<CMD>Oil <CR>", desc = "Oil Float"},
    {"_", "<CMD>lua require('oil').open(vim.fn.expand('$PWD'))<CR>", desc = "Oil Float"}

  },
}

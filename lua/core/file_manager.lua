return{
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = require('nixCatsUtils').enableForCategory('fileManager'),
  config = true,
  keys = {
    {"-","<CMD>Oil <CR>", desc = "Oil Float"},
    {"_", "<CMD>lua require('oil').open(vim.fn.expand('$PWD'))<CR>", desc = "Oil Float"}

  },
}

return{
    'EdenEast/nightfox.nvim',
    priority = 1000,
    lazy = false,
    enabled = require('nixCatsUtils').enableForCategory('fileManager'),
    config = function()
      vim.cmd.colorscheme "nightfox"
    end,
}

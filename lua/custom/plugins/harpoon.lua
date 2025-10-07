return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>sa", function() require("harpoon"):list():add() end, desc = "Add to Harpoon" },
    { "<leader>ss", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon Menu" },
    { "<M-h>",  function() require("harpoon"):list():select(1) end, desc = "Select Harpoon 1" },
    { "<M-t>",  function() require("harpoon"):list():select(2) end, desc = "Select Harpoon 2" },
    { "<M-n>",  function() require("harpoon"):list():select(3) end, desc = "Select Harpoon 3" },
    { "<M-s>",  function() require("harpoon"):list():select(4) end, desc = "Select Harpoon 4" },
  },
  config = true,
}

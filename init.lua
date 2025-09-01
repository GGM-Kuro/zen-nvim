require("nixCatsUtils").setup({
  non_nix_value = true,
})

require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
  -- require("core.treesitter"),
  -- require("core.file_manager"),
  -- require("core.completion"),
    'tpope/vim-sleuth',

  { import = "custom.plugins" },
}, lazyOptions)



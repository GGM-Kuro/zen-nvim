require("nixCatsUtils").setup({
  non_nix_value = true,
})

require("core.options")
require("core.epic_replace")
require("core.diagnostic")
require("custom.utilitymaps")
require("custom.quickfixmaps")

local function getlockfilepath()
  if require("nixCatsUtils").isNixCats and type(require("nixCats").settings.unwrappedCfgPath) == "string" then
    return require("nixCats").settings.unwrappedCfgPath .. "/lazy-lock.json"
  else
    return vim.fn.stdpath("config") .. "/lazy-lock.json"
  end
end


local lazyOptions = {
  lockfile = getlockfilepath(),
}

require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
    require("core.completion"),
    require('core.treesitter'),
    require('core.file_manager'),

  { import = "custom.plugins" },
}, lazyOptions)



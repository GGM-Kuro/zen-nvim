local wk = require("which-key")

-- Configuración principal de which-key
wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
    },
  },
  key_labels = {},
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 1, 2, 1, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = true,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  show_keys = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

-- GRUPO DE REEMPLAZO (epic_replace.lua)
wk.register({
  ["<leader>r"] = {
    name = "🔄 Replace", -- Icono y nombre del grupo principal
    
    -- Reemplazos rápidos
    S = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "󰬲 Replace all occurrences in buffer"
    },
    l = {
      [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "🔁 Replace in current line"
    },
    ["?"] = {
      [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]],
      "❓ Replace all with confirmation"
    },
    f = {
      [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
      "⬇️ Replace from cursor to end"
    },
    
    -- Opcional: atajos adicionales comunes
    a = {
      [[:%s//<C-r><C-w>/gI<Left><Left><Left>],
      "📝 Replace last search pattern"
    },
    w = {
      [[:%s/<<C-r><C-w>>//gI<Left><Left><Left>]],
      "🗑️ Delete all occurrences"
    }
  }
})

-- GRUPOS ADICIONALES (puedes expandir estos después)
-- Ejemplos de grupos comunes que podrías querer agregar:
wk.register({
  ["<leader>f"] = { name = "🔍 Find" },
  ["<leader>g"] = { name = "📊 Git" },
  ["<leader>b"] = { name = "📁 Buffer" },
  ["<leader>w"] = { name = "🪟 Window" },
  ["<leader>q"] = { name = "❌ Quit" },
})
local wk = require("which-key")

-- Configuración del grupo de atajos para reemplazo
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
      [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>],
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

-- NOTA: Los atajos originales de epic_replace.lua ya no son necesarios
-- ya que which-key los registra automáticamente. Podés comentarlos o borrarlos.
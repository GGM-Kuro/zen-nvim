local wk = require("which-key")

wk.add({
  {
    "<leader>r",
    group = "Replace",
    icon = "󰬲",
  },

  {
    "<leader>rS",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    desc = "Replace all occurrences",
    icon = "󰬲",
    mode = "n",
  },
  {
    "<leader>rl",
    [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    desc = "Replace in current line",
    icon = "󰞷",
    mode = "n",
  },
  {
    "<leader>r?",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]],
    desc = "Replace all with confirmation",
    icon = "❓",
    mode = "n",
  },
  {
    "<leader>rf",
    [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    desc = "Replace from cursor to end",
    icon = "⬇️",
    mode = "n",
  },
})


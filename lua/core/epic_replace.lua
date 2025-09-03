vim.keymap.set("n", "<leader>sS", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Epic replace' })

vim.keymap.set("n", "<leader>sl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace in current line' })

vim.keymap.set("n", "<leader>s?", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]],
  { desc = 'Replace all with confirmation' })

vim.keymap.set("n", "<leader>sf", [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace from cursor to end of file' })

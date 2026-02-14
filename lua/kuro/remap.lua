local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "
map("n", "<leader>pv", vim.cmd.Ex)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "=ap", "ma=ap'a")

map("n", "<leader>lt", function()
    vim.cmd [[ PlenaryBustedFile % ]]
end)

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>D", "\"_d")

-- This is going to get me cancelled
map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
map("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<c-x>", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)

map("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Kuro


map("n", "<leader>o", "o<Esc>k", vim.tbl_extend("force", opts, { desc = "Insert line below" }))
map("n", "<leader>x", vim.cmd.bdelete , vim.tbl_extend("force", opts, { desc = "Delete buffer" }))
map("n", "<leader>a", "ggVG" , vim.tbl_extend("force", opts, { desc = "Select all" }))
map("n", "<s-r>", function() vim.cmd.LspRestart() end)


-- Replace all occurrences
map("n", "<leader>rs",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  vim.tbl_extend("force", opts, { desc = "Replace all occurrences" })
)

-- Replace in current line
map("n", "<leader>rl",
  [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  vim.tbl_extend("force", opts, { desc = "Replace in current line" })
)

-- Replace all with confirmation
map("n", "<leader>r?",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]],
  vim.tbl_extend("force", opts, { desc = "Replace all with confirmation" })
)

-- Replace from cursor to end
map("n", "<leader>rf",
  [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  vim.tbl_extend("force", opts, { desc = "Replace from cursor to end" })
)


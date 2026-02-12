local harpoon = require("harpoon")

harpoon:setup({})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =========================
-- HARPOON CORE
-- =========================

map("n", "<C-a>", function()
	harpoon:list():add()
end, vim.tbl_extend("force", opts, { desc = "Add harpoon" }))

map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, vim.tbl_extend("force", opts, { desc = "Quick Menu Harpoon" }))

-- =========================
-- HARPOON SELECT
-- =========================

map("n", "<C-h>", function()
	harpoon:list():select(1)
end, vim.tbl_extend("force", opts, { desc = "Harpoon file 1" }))

map("n", "<C-t>", function()
	harpoon:list():select(2)
end, vim.tbl_extend("force", opts, { desc = "Harpoon file 2" }))

map("n", "<C-n>", function()
	harpoon:list():select(3)
end, vim.tbl_extend("force", opts, { desc = "Harpoon file 3" }))

map("n", "<C-s>", function()
	harpoon:list():select(4)
end, vim.tbl_extend("force", opts, { desc = "Harpoon file 4" }))

-- =========================
-- HARPOON NAV
-- =========================

map("n", "<leader>hp", function()
	harpoon:list():prev()
end, vim.tbl_extend("force", opts, { desc = "Harpoon prev" }))

map("n", "<leader>hn", function()
	harpoon:list():next()
end, vim.tbl_extend("force", opts, { desc = "Harpoon next" }))


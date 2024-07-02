require "nvchad.mappings"
local map = vim.keymap.set

-- add yours here
map("n", ";", ":", { desc = "CMD enter command mode" })
map({"i","v","c"}, "jk", "<ESC>", { desc = "enter normal mode" })
map("n", "<leader>wq", ":wq<CR>", { desc = "write and quit" })
map("n", "<Leader>qq", ":q!<CR>", { desc = "quit with force" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- snippets
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })

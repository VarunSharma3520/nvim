require "nvchad.mappings"
local map = vim.keymap.set

-- add yours here
map("n", ":", ":", { desc = "CMD enter command mode" })
map({"i","v","c"}, "jk", "<ESC>", { desc = "enter normal mode" })
map("n", "<leader>wq", ":wq<CR>", { desc = "write and quit" })
map("n", "<Leader>qq", ":q!<CR>", { desc = "quit with force" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr><ESC>", { desc = "quit with force" })

--selects all content of a file
map( "n", "<leader>sa", "gg0vG$", { desc = "selects all text in a file" })

-- remove highlighted text
map("n", "<ESC>", ":nohl", { desc = "remove selected text" })

-- open vscode
map("n", "<leader>vsc", ":!code .<CR>", { desc = "open vs code in current directory" })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- snippets
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- insert mode editing
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

-- these keymaps allow you to take highlighted text and then move it up and down with JK
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- these keep the cursor in the middle when scrolling with ctrl d and u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")




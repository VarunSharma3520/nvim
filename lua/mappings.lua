require "nvchad.mappings"
local map = vim.keymap.set

local ls = require("luasnip")
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
map("n", "<leader>ww", function() harpoon:list():add() end, { desc = "window add in harpoon" })
map("n", "<leader>wv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "window view toggle harpoon" })
map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "1st window via harpoon" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "2st window via harpoon" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "3rd window via harpoon" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "4th window via harpoon" })
map("n", "<leader>wp", function() harpoon:list():prev() end, { desc = "prev window via harpoon" })
map("n", "<leader>wn", function() harpoon:list():next() end, { desc = "next window via harpoon" })

-- these keymaps allow you to take highlighted text and then move it up and down with JK
map("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- add yours here
map("n", ":", ":", { desc = "CMD enter command mode" })
map({"i","v","c"}, "jk", "<ESC>", { desc = "enter normal mode" })
map("n", "<leader>wq", ":wq<CR>", { desc = "write and quit" })
map("n", "<Leader>qq", ":q!<CR>", { desc = "quit with force" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr><ESC>", { desc = "quit with force" })

--selects all content of a file
map( "n", "<leader>sa", "gg0vG$", { desc = "selects all text in a file" })

-- remove highlighted text
map("n", "<leader><ESC>", ":nohl<CR>", { desc = "no highlight" })

-- open vscode
map("n", "<leader>vsc", ":!code .<CR>", { desc = "open vs code in current directory" })


map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- -- snippets
map("i", "<C-a>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
map("s", "<C-a>", "<cmd>lua require('luasnip').expand_or_jump()<CR>", { silent = true, noremap = true })
map("i", "<C-z", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })
map("s", "<C-z>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true, noremap = true })
map({"i", "s"}, "<C-d>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


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


-- these keep the cursor in the middle when scrolling with ctrl d and u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")




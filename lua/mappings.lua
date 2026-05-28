local map = vim.keymap.set
local ls = function()
	return require("luasnip")
end

local harpoon = require("harpoon")
local list = harpoon:list()
-- =========================
-- BASIC EDITING
-- =========================

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

map({ "i", "v", "c" }, "jk", "<ESC>", { desc = "Escape to normal mode" })

map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
map("n", "<leader>qq", ":q!<CR>", { desc = "Quit force" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

map("n", "<leader><leader>", function()
	require("telescope").extensions.luasnip.luasnip()
end, { desc = "Search snippets (Telescope)" })

map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- =========================
-- TELESCOPE
-- =========================

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Old files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search buffer" })

map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Pick terminals" })

map("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "Colorschemes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Find all files" }
)

-- =========================
-- FILE / UI ACTIONS
-- =========================

map("n", "<leader>sa", "gg0vG$", { desc = "Select all" })
map("n", "<leader><esc>", ":nohl<CR>", { desc = "Clear search highlight" })
map("n", "<leader>vsc", ":!code .<CR>", { desc = "Open VS Code" })
-- buffer navigation (tabs)
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer" })
-- =========================
-- SESSION / TREE
-- =========================

map("n", "<leader>ss", ":AutoSession search<CR>", { desc = "Search sessions" })

map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- =========================
-- LUASNIP
-- =========================

map("i", "<C-a>", function()
	ls.expand_or_jump()
end, { desc = "Snippet expand/jump" })
map("s", "<C-a>", function()
	ls.expand_or_jump()
end, { desc = "Snippet expand/jump" })

map("i", "<C-z>", function()
	ls.jump(-1)
end, { desc = "Snippet jump back" })
map("s", "<C-z>", function()
	ls.jump(-1)
end, { desc = "Snippet jump back" })

map({ "i", "s" }, "<C-d>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { desc = "Snippet choice next" })

-- =========================
-- INSERT NAVIGATION
-- =========================

map("i", "<C-b>", "<ESC>^i", { desc = "Start of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-h>", "<Left>", { desc = "Left" })
map("i", "<C-l>", "<Right>", { desc = "Right" })
map("i", "<C-j>", "<Down>", { desc = "Down" })
map("i", "<C-k>", "<Up>", { desc = "Up" })

-- =========================
-- SCROLL CENTERING
-- =========================

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- =========================
-- COMMENT
-- =========================

map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- =========================
-- FLASH
-- =========================

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash TS" })
map("o", "r", function()
	require("flash").remote()
end, { desc = "Flash remote" })
map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Flash search" })
map("c", "<C-s>", function()
	require("flash").toggle()
end, { desc = "Flash toggle" })

-- =========================
-- TROUBLE
-- =========================

map("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle<CR>", { desc = "Symbols" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP" })
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list" })
map("n", "<leader>tQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list" })

-- =========================
-- HARPOON
-- =========================
map("n", "<leader>ha", function()
	list:append()
end, { desc = "Harpoon add file" })

map("n", "<leader>hr", function()
	list:remove()
end, { desc = "Harpoon remove file" })

map("n", "<leader>hh", function()
	harpoon.ui:toggle_quick_menu(list)
end, { desc = "Harpoon menu" })

map("n", "<Tab>", function()
	list:next()
end, { desc = "Harpoon next" })

map("n", "<S-Tab>", function()
	list:prev()
end, { desc = "Harpoon prev" })
local map = vim.keymap.set
local ls = function()
	return require("luasnip")
end

local harpoon = require("harpoon")
local list = harpoon:list()
-- =========================
-- BASIC EDITING
-- =========================

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Edit: move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Edit: move selection up", silent = true })

map({ "i", "v", "c" }, "jk", "<ESC>", { desc = "Edit: escape to normal mode" })

map("n", "<leader>wq", ":wq<CR>", { desc = "File: save and quit" })
map("n", "<leader>qq", ":q!<CR>", { desc = "File: force quit without saving" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "File: save" })

map("n", "<leader><leader>", function()
	require("telescope").extensions.luasnip.luasnip()
end, { desc = "Snippet: search snippets" })

map({ "n", "x" }, "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Edit: format file / selection" })

-- =========================
-- COMMAND PALETTE
-- =========================

map("n", "<leader>kk", function()
	require("palette").open()
end, { desc = "Palette: run keymap / command / autocommand" })

-- =========================
-- TELESCOPE
-- =========================

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find: files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Find: all files (hidden + ignored)" }
)
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find: live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find: open buffers" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find: recent files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find: text in current buffer" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find: help tags" })
map("n", "<leader>fu", "<cmd>Telescope undo<CR>", { desc = "Find: undo history" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "Find: file browser" })
map("n", "<leader>fp", "<cmd>Telescope project<CR>", { desc = "Find: projects" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Find: document symbols" })
map("n", "<leader>f.", "<cmd>Telescope resume<CR>", { desc = "Find: resume last picker" })

-- prefill :%s with the selection (or word under cursor); cursor lands in the replace slot
local function substitute(pattern)
	local keys = vim.api.nvim_replace_termcodes
	vim.api.nvim_feedkeys(keys("<Esc>", true, false, true), "n", false)
	-- pattern is fed raw (no termcodes) so text like "<Left>" in the buffer stays literal
	vim.api.nvim_feedkeys(":%s/" .. pattern .. "//gc", "n", false)
	vim.api.nvim_feedkeys(keys("<Left><Left><Left>", true, false, true), "n", false)
end

map("x", "<leader>fr", function()
	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
	-- \V = very nomagic, so only / and \ need escaping; newlines become \n for multi-line selections
	substitute("\\V" .. vim.fn.escape(table.concat(lines, "\n"), "/\\"):gsub("\n", "\\n"))
end, { desc = "Edit: find & replace selection in file" })

map("n", "<leader>fr", function()
	substitute("\\V\\<" .. vim.fn.escape(vim.fn.expand("<cword>"), "/\\") .. "\\>")
end, { desc = "Edit: find & replace word under cursor in file" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Find: marks" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Find: terminals" })
map("n", "<leader>th", "<cmd>Telescope colorscheme<CR>", { desc = "UI: pick colorscheme" })

-- =========================
-- GIT (hunk keys live in plugins/git/gitsigns.lua)
-- =========================

map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git: browse commits" })
map("n", "<leader>gf", "<cmd>Telescope git_status<CR>", { desc = "Git: changed files" })

-- =========================
-- FILE / UI ACTIONS
-- =========================

map("n", "<leader>sa", "gg0vG$", { desc = "Edit: select all" })
map("n", "<leader><esc>", ":nohl<CR>", { desc = "UI: clear search highlight" })
map("n", "<leader>vsc", ":!code .<CR>", { desc = "UI: open project in VS Code" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Buffer: close" })
-- =========================
-- SESSION / TREE
-- =========================

map("n", "<leader>ss", ":AutoSession search<CR>", { desc = "Session: search sessions" })

map("n", "<C-n>", "<cmd>NvimTreeFocus<CR>", { desc = "Tree: focus file tree" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Tree: toggle file tree" })

-- =========================
-- LUASNIP
-- =========================

map("i", "<C-a>", function()
	ls().expand_or_jump()
end, { desc = "Snippet: expand / jump forward" })
map("s", "<C-a>", function()
	ls().expand_or_jump()
end, { desc = "Snippet: expand / jump forward" })

map("i", "<C-z>", function()
	ls().jump(-1)
end, { desc = "Snippet: jump back" })
map("s", "<C-z>", function()
	ls().jump(-1)
end, { desc = "Snippet: jump back" })

map({ "i", "s" }, "<C-d>", function()
	if ls().choice_active() then
		ls().change_choice(1)
	end
end, { desc = "Snippet: next choice" })

-- =========================
-- INSERT NAVIGATION
-- =========================

map("i", "<C-b>", "<ESC>^i", { desc = "Move: start of line" })
map("i", "<C-e>", "<End>", { desc = "Move: end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move: left" })
map("i", "<C-l>", "<Right>", { desc = "Move: right" })
map("i", "<C-j>", "<Down>", { desc = "Move: down" })
map("i", "<C-k>", "<Up>", { desc = "Move: up" })

-- =========================
-- WINDOW NAVIGATION
-- =========================

map("n", "<C-h>", "<C-w>h", { desc = "Window: focus left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window: focus down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window: focus up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window: focus right" })

-- =========================
-- SCROLL CENTERING
-- =========================

map("n", "<C-d>", "<C-d>zz", { desc = "Move: half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move: half page up (centered)" })

-- =========================
-- COMMENT
-- =========================

map("n", "<leader>/", "gcc", { desc = "Edit: toggle line comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Edit: toggle comment on selection", remap = true })

-- =========================
-- FLASH
-- =========================

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash: jump to label" })
map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash: select treesitter node" })
map("o", "r", function()
	require("flash").remote()
end, { desc = "Flash: remote operator" })
map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Flash: treesitter search" })
map("c", "<C-s>", function()
	require("flash").toggle()
end, { desc = "Flash: toggle in search" })

-- =========================
-- TROUBLE
-- =========================

map("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble: workspace diagnostics" })
map("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble: buffer diagnostics" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle<CR>", { desc = "Trouble: symbols outline" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle<CR>", { desc = "Trouble: LSP definitions / references" })
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<CR>", { desc = "Trouble: location list" })
map("n", "<leader>tQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Trouble: quickfix list" })

-- =========================
-- HARPOON
-- =========================
map("n", "<leader>ha", function()
	list:add()
end, { desc = "Harpoon: add file" })

map("n", "<leader>hr", function()
	list:remove()
end, { desc = "Harpoon: remove file" })

map("n", "<leader>hh", function()
	harpoon.ui:toggle_quick_menu(list)
end, { desc = "Harpoon: open menu" })

map("n", "<Tab>", function()
	list:next()
end, { desc = "Harpoon: next file" })

map("n", "<S-Tab>", function()
	list:prev()
end, { desc = "Harpoon: previous file" })

-- =========================
-- lsp (nvchad-style)
-- =========================

local function lsp_buf_mappings(bufnr)
	local bufmap = function(mode, lhs, rhs, desc)
		map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	bufmap("n", "gD", vim.lsp.buf.declaration, "LSP: go to declaration")
	bufmap("n", "gd", vim.lsp.buf.definition, "LSP: go to definition")
	bufmap("n", "gi", vim.lsp.buf.implementation, "LSP: go to implementation")
	bufmap("n", "gr", vim.lsp.buf.references, "LSP: list references")
	bufmap("n", "gt", vim.lsp.buf.type_definition, "LSP: go to type definition")
	bufmap("n", "gk", vim.lsp.buf.hover, "LSP: hover docs")
	bufmap("n", "<leader>ra", vim.lsp.buf.rename, "LSP: rename symbol")
	bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
	bufmap("n", "[d", vim.diagnostic.goto_prev, "Diagnostic: previous")
	bufmap("n", "]d", vim.diagnostic.goto_next, "Diagnostic: next")
	bufmap("n", "<leader>dl", vim.diagnostic.open_float, "Diagnostic: show line diagnostics")

	return bufmap
end

return {
	lsp_buf_mappings = lsp_buf_mappings,
}

-- require("nvchad.options")

vim.g.vscode_snippets_path = vim.fn.expand("~/.config/Code/User/snippets")

local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------
-- Base46 cache path (required by NvChad)
g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
g.mapleader = " "

opt.clipboard = "unnamedplus"
-- UI
opt.laststatus = 3
opt.showmode = false
opt.splitkeep = "screen"

opt.cursorline = true
opt.cursorlineopt = "both"

opt.termguicolors = true
opt.signcolumn = "yes"

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Scrolling
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Timing
opt.timeoutlen = 400
opt.updatetime = 250

-- Mouse
opt.mouse = "a"

-- Undo
opt.undofile = true

-- Fill empty lines
opt.fillchars = { eob = " " }

-- Disable nvim intro
opt.shortmess:append("sI")

-- Allow cursor movement between wrapped lines
opt.whichwrap:append("<>[]hl")

-- Better completion menu
opt.completeopt = { "menuone", "noselect" }

-- Optional whitespace chars
opt.list = true
opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

-------------------------------------- providers ----------------------------------------

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.pumheight = 10
opt.cmdheight = 0
opt.showtabline = 0
-------------------------------------- mason path ---------------------------------------

local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"

vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

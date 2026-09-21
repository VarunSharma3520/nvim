vim.g.mapleader = " "

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- lazy config
local lazy_config = require("configs.lazy")

require("lazy").setup({
	{ import = "plugins" },
}, require("configs.lazy"))

-- core configs AFTER plugins
require("options")
require("mappings")
require("autocmds")

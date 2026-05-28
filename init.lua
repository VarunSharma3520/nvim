vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

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

-- autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	command = "silent! w",
})

-- remove transparency
vim.schedule(function()
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
end)

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		for _, group in ipairs({
			"Normal",
			"NormalFloat",
			"FloatBorder",
			"TelescopeNormal",
			"WhichKeyFloat",
		}) do
			vim.api.nvim_set_hl(0, group, { bg = "NONE" })
		end
	end,
})

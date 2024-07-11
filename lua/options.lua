require "nvchad.options"

-- add yours here!

local opt = vim.o
opt.cursorlineopt ='both' -- to enable cursorline!
opt.relativenumber = true -- to enable relativenumber!
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99 -- Open all folds by default

-- Enable UltiSnips
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"


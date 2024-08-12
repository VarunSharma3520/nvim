vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.cmd([[
  augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Folded guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
  augroup END
]])

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  command = "silent! w"
})


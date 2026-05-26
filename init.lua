-- Base46 cache path (required by NvChad)
vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"

vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------
-- Bootstrap lazy.nvim
--------------------------------------------------
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

--------------------------------------------------
-- Load plugins
--------------------------------------------------
local lazy_config = require("configs.lazy")

require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require("options")
    end,
  },

  { import = "plugins" },
}, lazy_config)

--------------------------------------------------
-- Load NvChad theme cache
--------------------------------------------------
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

--------------------------------------------------
-- NvChad autocmds & mappings
--------------------------------------------------
require("nvchad.autocmds")

vim.schedule(function()
  require("mappings")
end)

--------------------------------------------------
-- Extra autocmds
--------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.cmd("hi NvimTreeNormal guibg=NONE ctermbg=NONE")
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  command = "silent! w",
})

vim.schedule(function()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
end)

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, group in ipairs({
      "NormalFloat",
      "FloatBorder",
      "TelescopeNormal",
      "WhichKeyFloat",
    }) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
})

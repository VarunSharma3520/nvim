local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local create_cmd = vim.api.nvim_create_user_command

create_cmd("TSInstallAll", function()
  local spec = require("lazy.core.config").plugins["nvim-treesitter"]
  local opts = type(spec.opts) == "table" and spec.opts or {}
  require("nvim-treesitter").install(opts.ensure_installed)
end, {})

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

-- harpoon smart auto-save (instant)
local harpoon = require("harpoon")
local list = harpoon:list()

local MAX_ITEMS = 15

local function is_valid_file(buf)
	local file = vim.api.nvim_buf_get_name(buf)
	if file == "" then return false end
	if vim.bo[buf].buftype ~= "" then return false end
	if vim.bo[buf].filetype == "TelescopePrompt" then return false end
	if vim.bo[buf].filetype == "lazy" then return false end
	return true
end

local function is_duplicate(file)
	for _, item in ipairs(list.items or {}) do
		if item.value == file then
			return true
		end
	end
	return false
end

local function prune_if_needed()
	local items = list.items or {}

	while #items > MAX_ITEMS do
		table.remove(items, 1)
	end

	list.items = items
end

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		local buf = args.buf

		if not is_valid_file(buf) then
			return
		end

		local file = vim.api.nvim_buf_get_name(buf)

		if is_duplicate(file) then
			return
		end

		list:append()
		prune_if_needed()
	end,
})
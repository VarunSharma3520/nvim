-- VS Code-style command palette: keymaps, commands and autocommands in one Telescope picker.
local M = {}

local MODES = { "n", "x", "s", "o", "i", "c", "t" }

-- labels for plugin/runtime keymaps that ship without a desc (keyed by mode .. lhs)
local FALLBACK = {
	["i>"] = "Autotag: auto-close HTML/JSX tag",
	["n[["] = "Rust: jump to previous item",
	["n]]"] = "Rust: jump to next item",
	["x[["] = "Rust: jump to previous item",
	["x]]"] = "Rust: jump to next item",
	["o[["] = "Rust: jump to previous item",
	["o]]"] = "Rust: jump to next item",
	["n<Plug>PlenaryTestFile"] = "Plenary: run tests in current file",
	["c<Plug>(TelescopeFuzzyCommandSearch)"] = "Telescope: fuzzy search command history",
}

local function collect(buf)
	local items = {}

	-- buffer-local first so they win the same-lhs tie visually
	for _, mode in ipairs(MODES) do
		for _, get in ipairs({ function() return vim.api.nvim_buf_get_keymap(buf, mode) end, function() return vim.api.nvim_get_keymap(mode) end }) do
			for _, km in ipairs(get()) do
				local lhs = km.lhs:gsub("^ ", "<leader>")
				local label = km.desc or FALLBACK[mode .. km.lhs] or km.rhs or ""
				table.insert(items, {
					kind = "key",
					text = string.format("[key]  %s  %-14s %s", mode, lhs, label),
					km = km,
					mode = mode,
				})
			end
		end
	end

	-- every Ex command (builtin + user), with user-command metadata where available
	local defs = vim.tbl_extend("force", vim.api.nvim_get_commands({}), vim.api.nvim_buf_get_commands(buf, {}))
	for _, name in ipairs(vim.fn.getcompletion("", "command")) do
		local def = defs[name]
		local info = def and (def.definition or "") or ""
		table.insert(items, {
			kind = "cmd",
			text = string.format("[cmd]  :%-24s %s", name, info),
			name = name,
			nargs = def and def.nargs,
		})
	end

	for _, ac in ipairs(vim.api.nvim_get_autocmds({})) do
		local label = ac.desc or ac.command
		if (not label or label == "") and type(ac.callback) == "string" then
			label = ac.callback
		end
		table.insert(items, {
			kind = "auto",
			text = string.format("[auto] %-14s %-12s %-16s %s", ac.event, ac.pattern or "", ac.group_name or "", label or "<lua callback>"),
			ac = ac,
		})
	end

	return items
end

local function run(item, buf, win)
	if item.kind == "key" then
		if item.mode ~= "n" then
			vim.notify(("'%s' is a %s-mode keymap; switch to that mode to use it"):format(item.km.lhs, item.mode))
			return
		end
		-- "t" = as if typed, so the mapping (and <leader>) resolves normally
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(item.km.lhs, true, false, true), "t", false)
	elseif item.kind == "cmd" then
		if item.nargs == "0" then
			vim.cmd(item.name)
		else
			-- needs (or may take) arguments: prefill the cmdline instead of guessing
			vim.api.nvim_feedkeys(":" .. item.name .. " ", "n", false)
		end
	else
		local ac = item.ac
		local file = vim.api.nvim_buf_get_name(buf)
		if type(ac.callback) == "function" then
			ac.callback({ id = ac.id, event = ac.event, group = ac.group, buf = buf, file = file, match = file, data = nil })
		elseif type(ac.callback) == "string" then
			vim.fn[ac.callback]()
		elseif ac.command and ac.command ~= "" then
			vim.api.nvim_win_call(win, function() vim.cmd(ac.command) end)
		end
	end
end

function M.open()
	local buf, win = vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win()
	local pickers, finders, conf = require("telescope.pickers"), require("telescope.finders"), require("telescope.config").values
	local actions, state = require("telescope.actions"), require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Command Palette",
			finder = finders.new_table({
				results = collect(buf),
				entry_maker = function(item)
					return { value = item, display = item.text, ordinal = item.text }
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local entry = state.get_selected_entry()
					actions.close(prompt_bufnr)
					if entry then
						vim.schedule(function() run(entry.value, buf, win) end)
					end
				end)
				return true
			end,
		})
		:find()
end

return M

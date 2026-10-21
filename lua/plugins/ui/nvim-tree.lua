return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- default nvim-tree keymaps + custom ones on top
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)

				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, {
						buffer = bufnr,
						noremap = true,
						silent = true,
						nowait = true,
						desc = "nvim-tree: " .. desc,
					})
				end

				-- open / navigate
				map("l", api.node.open.edit, "Open / expand")
				map("<CR>", api.node.open.edit, "Open / expand")
				map("h", api.node.navigate.parent_close, "Collapse folder")
				map("L", api.node.open.vertical, "Open in vertical split")
				map("J", api.node.open.horizontal, "Open in horizontal split")
				map("t", api.node.open.tab, "Open in new tab")
				map("P", api.node.open.preview, "Preview")

				-- file operations
				map("a", api.fs.create, "Create file/dir")
				map("d", api.fs.remove, "Delete")
				map("r", api.fs.rename, "Rename")
				map("R", api.tree.reload, "Refresh")
				map("y", api.fs.copy.filename, "Copy name")
				map("Y", api.fs.copy.absolute_path, "Copy absolute path")
				map("x", api.fs.cut, "Cut")
				map("c", api.fs.copy.node, "Copy")
				map("p", api.fs.paste, "Paste")

				-- tree
				map("H", api.tree.toggle_hidden_filter, "Toggle hidden files")
				map(".", api.tree.change_root_to_node, "Set as root")
				map("-", api.tree.change_root_to_parent, "Go up to parent root")
				map("f", api.live_filter.start, "Filter")
				map("F", api.live_filter.clear, "Clear filter")
				map("q", api.tree.close, "Close tree")
				map("?", api.tree.toggle_help, "Help")
			end

			require("nvim-tree").setup({
				on_attach = on_attach,
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					side = "right",
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
					git_ignored = false,
				},
			})

			-- auto close tree when focus leaves it
			local api = require("nvim-tree.api")
			local group = vim.api.nvim_create_augroup("NvimTreeAutoClose", { clear = true })

			-- moved from tree to another (non-floating) window
			vim.api.nvim_create_autocmd("WinLeave", {
				group = group,
				callback = function()
					if vim.bo.filetype ~= "NvimTree" then
						return
					end
					vim.schedule(function()
						-- keep tree open for floats (rename prompt, help, telescope, etc.)
						if vim.api.nvim_win_get_config(0).relative ~= "" then
							return
						end
						if vim.bo.filetype ~= "NvimTree" then
							api.tree.close()
						end
					end)
				end,
			})

			-- close 50s after opening, even if focused
			local close_timer = vim.uv.new_timer()
			api.events.subscribe(api.events.Event.TreeOpen, function()
				close_timer:stop()
				close_timer:start(50000, 0, vim.schedule_wrap(api.tree.close))
			end)
			api.events.subscribe(api.events.Event.TreeClose, function()
				close_timer:stop()
			end)

			-- terminal/tmux lost focus (new tab, other window, other app)
			vim.api.nvim_create_autocmd("FocusLost", {
				group = group,
				callback = function()
					api.tree.close()
				end,
			})
		end,
	}
}

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
						desc = "Tree: " .. desc,
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

			-- delayed close: wait before closing, cancel if the user comes back
			local CLOSE_DELAY_MS = 5000
			local delay_timer = vim.uv.new_timer()
			local pending_reason = nil -- "winleave" | "focuslost" | nil

			local function cancel_delayed_close()
				delay_timer:stop()
				pending_reason = nil
			end

			local function schedule_close(reason)
				-- a window-leave close is already counting down; let it finish
				if pending_reason == "winleave" and reason == "focuslost" then
					return
				end
				delay_timer:stop()
				pending_reason = reason
				delay_timer:start(CLOSE_DELAY_MS, 0, vim.schedule_wrap(function()
					pending_reason = nil
					-- user is back in the tree: keep it open
					if vim.bo.filetype == "NvimTree" then
						return
					end
					api.tree.close()
				end))
			end

			-- moved from tree to another (non-floating) window
			vim.api.nvim_create_autocmd("WinLeave", {
				desc = "Tree: close 5s after focus moves to another window",
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
							schedule_close("winleave")
						end
					end)
				end,
			})

			-- came back into the tree: cancel any pending close
			vim.api.nvim_create_autocmd("WinEnter", {
				desc = "Tree: cancel pending close when re-entering the tree",
				group = group,
				callback = function()
					if vim.bo.filetype == "NvimTree" then
						cancel_delayed_close()
					end
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
				cancel_delayed_close()
			end)

			-- terminal/tmux lost focus (new tab, other window, other app)
			vim.api.nvim_create_autocmd("FocusLost", {
				desc = "Tree: close 5s after terminal loses focus",
				group = group,
				callback = function()
					if api.tree.is_visible() then
						schedule_close("focuslost")
					end
				end,
			})

			-- terminal regained focus: cancel a focus-lost close
			vim.api.nvim_create_autocmd("FocusGained", {
				desc = "Tree: cancel pending close when terminal regains focus",
				group = group,
				callback = function()
					if pending_reason == "focuslost" then
						cancel_delayed_close()
					end
				end,
			})
		end,
	}
}

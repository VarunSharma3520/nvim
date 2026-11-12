return {
	{
		"folke/trouble.nvim",
		opts = {
			auto_close = true, -- close when there are no items left
			focus = true, -- manual toggles focus the list, so leaving it closes it
		},
		cmd = "Trouble",
		init = function()
			local group = vim.api.nvim_create_augroup("TroubleAuto", { clear = true })

			-- open diagnostics on save if the buffer has warnings/errors (without stealing focus)
			vim.api.nvim_create_autocmd("BufWritePost", {
				desc = "Trouble: open diagnostics on save",
				group = group,
				callback = function()
					if #vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } }) > 0 then
						require("trouble").open({ mode = "diagnostics", focus = false })
					end
				end,
			})

			-- close when focus moves from trouble to another (non-floating) window, like nvim-tree
			vim.api.nvim_create_autocmd("WinLeave", {
				desc = "Trouble: close when focus leaves it",
				group = group,
				callback = function()
					if vim.bo.filetype ~= "trouble" then
						return
					end
					vim.schedule(function()
						if vim.api.nvim_win_get_config(0).relative == "" and vim.bo.filetype ~= "trouble" then
							require("trouble").close()
						end
					end)
				end,
			})

			vim.api.nvim_create_autocmd("FocusLost", {
				desc = "Trouble: close when terminal loses focus",
				group = group,
				callback = function()
					if package.loaded["trouble"] then
						require("trouble").close()
					end
				end,
			})
		end,
	},
}

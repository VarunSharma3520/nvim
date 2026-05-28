return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"cljoly/telescope-repo.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-project.nvim",
			"benfowler/telescope-luasnip.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"debugloop/telescope-undo.nvim",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},

		config = function()
			local telescope = require("telescope")

			telescope.setup({})
			-- Load all extensions in one place
			local extensions = {
				"repo",
				"ui-select",
				"project",
				"luasnip",
				"dap",
				"undo",
				"file_browser",
			}

			for _, ext in ipairs(extensions) do
				pcall(telescope.load_extension, ext)
			end
		end,
	},
}

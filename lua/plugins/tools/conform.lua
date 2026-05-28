return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- format on save trigger

		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					css = { "prettier" },
					html = { "prettier" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
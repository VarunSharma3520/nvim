return {
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	}
}
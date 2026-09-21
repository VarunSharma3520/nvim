return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("plugins.configs.lspconfig")
		end,
	}
}
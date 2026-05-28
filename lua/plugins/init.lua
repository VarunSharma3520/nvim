return {
	-- Core configs

	-- LSP stack
	require("plugins.lsp.mason"),
	require("plugins.lsp.mason-lspconfig"),
	require("plugins.lsp.lspconfig"),
	require("plugins.lsp.nvim-cmp"),

	-- Snippets
	require("plugins.snippets.luasnip"),
	require("plugins.snippets.friendly-snippets"),
	-- require("plugins.snippets.ultisnips"),
	-- require("plugins.snippets.vimsnip"),

	-- Treesitter
	require("plugins.treesitter.treesitter"),
	require("plugins.treesitter.ts-autotag"),

	-- Editor
	require("plugins.editor.autopairs"),
	require("plugins.editor.auto-session"),
	require("plugins.editor.comment"),
	require("plugins.editor.flash"),
	require("plugins.editor.harpoon"),
	require("plugins.editor.surround"),

	-- UI
	require("plugins.ui.rose-pine"),
	require("plugins.ui.lualine"),
	require("plugins.ui.nvim-tree"),
	require("plugins.ui.whichkey"),
	require("plugins.ui.nvim-web-devicons"),
	require("plugins.ui.telescope"),
	-- require("plugins.ui.bufferline"),

	-- Tools
	require("plugins.tools.conform"),
	require("plugins.tools.markdown"),
	require("plugins.tools.trouble"),

	-- Misc
	require("plugins.colorizer"),
	require("plugins.windsurf"),
	require("plugins.sourcegraph"),

	-- Git (empty right now, but reserved properly)
	-- require("plugins.git"),
}

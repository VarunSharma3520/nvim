return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		config = function()
			require("configs.conform")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
	},
	{ "neoclide/coc.nvim", branch = "release", lazy = false },
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"html-lsp",
				"css-lsp",
				"prettier",
				"pyright",
				"typescript-language-server",
				"tailwindcss-language-server",
				"bash-language-server",
				"dockerfile-language-server",
				"json-lsp",
				"gopls",
				"eslint-lsp",
				"typos-lsp",
				"vscode-solidity-server",
				"rust-analyzer",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"python",
				"tsx",
				"go",
				"gomod",
				"gosum",
				"bash",
				"c",
				"css",
				"html",
				"json",
				"typescript",
				"markdown",
				"markdown_inline",
				"rust",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "honza/vim-snippets",
    lazy = false 
  },
	{
		"SirVer/ultisnips",
		lazy = true,
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = false,
	},
}

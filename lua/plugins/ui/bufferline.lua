return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",

				separator_style = "thin", -- 👈 key for bubble look
				always_show_bufferline = true,

				show_buffer_close_icons = false,
				show_close_icon = false,

				color_icons = true,
				diagnostics = "nvim_lsp",

				indicator = {
					style = "icon",
					icon = "●",
				},

				offsets = {
					{
						filetype = "NvimTree",
						text = " Explorer ",
						separator = false,
						padding = 1,
					},
				},

				hover = {
					enabled = true,
					delay = 100,
					reveal = { "close" },
				},
			},

			highlights = {
				fill = {
					bg = "NONE",
				},

				background = {
					fg = "#a6adc8",
					bg = "NONE",
				},

				buffer_selected = {
					fg = "#ffffff",
					bg = "NONE",
					bold = true,
					italic = false,
				},

				buffer_visible = {
					fg = "#a6adc8",
					bg = "NONE",
				},

				separator = {
					fg = "NONE",
					bg = "NONE",
				},

				separator_selected = {
					fg = "NONE",
					bg = "NONE",
				},

				indicator_selected = {
					fg = "#89b4fa",
					bg = "NONE",
				},

				modified = {
					fg = "#f9e2af",
					bg = "NONE",
				},

				modified_selected = {
					fg = "#f9e2af",
					bg = "NONE",
					bold = true,
				},

				close_button = {
					fg = "#6c7086",
					bg = "NONE",
				},

				close_button_selected = {
					fg = "#f38ba8",
					bg = "NONE",
				},
			},
		})
	end,
}
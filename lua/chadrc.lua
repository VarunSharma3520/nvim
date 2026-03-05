---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "night-owl",

	--------------------------------------------------
	-- Transparency
	--------------------------------------------------
	transparency = true,

	--------------------------------------------------
	-- Highlight overrides
	--------------------------------------------------
	hl_override = {

		-- Floating windows
		NormalFloat = { bg = "NONE" },
		FloatBorder = { bg = "NONE" },

		-- Telescope
		TelescopeNormal = { bg = "NONE" },
		TelescopePromptNormal = { bg = "NONE" },
		TelescopeResultsNormal = { bg = "NONE" },
		TelescopePreviewNormal = { bg = "NONE" },
		TelescopeBorder = { bg = "NONE" },
		TelescopePromptBorder = { bg = "NONE" },
		TelescopeResultsBorder = { bg = "NONE" },
		TelescopePreviewBorder = { bg = "NONE" },

		-- WhichKey
		WhichKeyFloat = { bg = "NONE" },
		WhichKeyBorder = { bg = "NONE" },

		-- Main editor
		Normal = { bg = "NONE" },
		NormalNC = { bg = "NONE" },

		-- File tree
		NvimTreeNormal = { bg = "NONE" },
		NvimTreeNormalNC = { bg = "NONE" },
		NvimTreeEndOfBuffer = { bg = "NONE" },

		-- Optional polish
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},

	--------------------------------------------------
	-- Statusline
	--------------------------------------------------
	statusline = {
		theme = "minimal",
		separator_style = "round",
	},

	--------------------------------------------------
	-- LSP
	--------------------------------------------------
	lsp = {
		signature = true,
	},
}

return M

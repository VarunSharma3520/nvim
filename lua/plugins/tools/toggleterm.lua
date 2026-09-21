local float_term

local function toggle_float()
	local Terminal = require("toggleterm.terminal").Terminal
	float_term = float_term or Terminal:new({ direction = "float", float_opts = { border = "curved" } })
	float_term:toggle()
end

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
			{ "<leader>tf", toggle_float, desc = "Toggle floating terminal", mode = { "n", "t" } },
		},
		opts = {
			size = 15,
			open_mapping = [[<C-\>]],
			direction = "horizontal",
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			close_on_exit = true,
			float_opts = {
				border = "curved",
			},
		},
	}
}

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local map = function(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("]c", function() gs.nav_hunk("next") end, "Git: next hunk")
				map("[c", function() gs.nav_hunk("prev") end, "Git: previous hunk")
				map("<leader>gs", gs.stage_hunk, "Git: stage hunk")
				map("<leader>gS", gs.stage_buffer, "Git: stage whole file")
				map("<leader>gu", gs.undo_stage_hunk, "Git: undo stage hunk")
				map("<leader>gr", gs.reset_hunk, "Git: reset hunk")
				map("<leader>gp", gs.preview_hunk, "Git: preview hunk")
				map("<leader>gd", gs.diffthis, "Git: diff file against index")
				map("<leader>gb", gs.blame_line, "Git: blame line")
				map("<leader>gB", gs.toggle_current_line_blame, "Git: toggle inline blame")
			end,
		},
	},
}

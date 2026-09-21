return {
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				log_level = "error",
				suppressed_dirs = { "~/", "~/Downloads", "/" },
				args_allow_files_auto_save = true,
			})
		end,
	}
}
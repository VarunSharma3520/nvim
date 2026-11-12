return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
		},
		keys = {
			{ "<leader>dc", function() require("dap").continue() end, desc = "Debug: continue / start" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Debug: step over" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Debug: step into" },
			{ "<leader>dt", function() require("dap").step_out() end, desc = "Debug: step out" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle debug UI" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- codelldb from mason (on PATH inside nvim)
			dap.adapters.codelldb = { type = "executable", command = "codelldb" }
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.c = dap.configurations.rust
			dap.configurations.cpp = dap.configurations.rust

			dap.listeners.after.event_initialized.dapui = dapui.open
			dap.listeners.before.event_terminated.dapui = dapui.close
			dap.listeners.before.event_exited.dapui = dapui.close
		end,
	},
}

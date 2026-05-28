require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- disable snyk explicitly
-- lspconfig.snyk_ls.setup({
--   autostart = false,
--   cmd = { "false" }, -- hard disable
-- })


require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "gopls",
  "ts_ls",
  "pyright",
  "tailwindcss",
  "eslint",
  "rust_analyzer",
  "bashls",
}

vim.lsp.enable(servers)


-- mason-lspconfig v2 auto-enables installed servers via vim.lsp.config; `handlers` is no longer read
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
    },
  },
})

require("mason-lspconfig").setup()

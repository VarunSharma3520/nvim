local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,
  },
})
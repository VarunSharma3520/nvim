return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "python",
          "tsx",
          "go",
          "gomod",
          "gosum",
          "bash",
          "c",
          "json",
          "typescript",
          "markdown",
          "markdown_inline",
          "rust",
        },
      })
    end,
  }
}
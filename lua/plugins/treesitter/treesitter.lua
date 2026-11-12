return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      -- main branch ignores ensure_installed; install() is the real API (no-op for installed parsers)
      require("nvim-treesitter").install({
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
          "toml",
      })
    end,
  }
}
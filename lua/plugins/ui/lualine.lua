local colors = {
  bg     = "#1e1e2e",
  fg     = "#cdd6f4",
  blue   = "#89b4fa",
  green  = "#a6e3a1",
  yellow = "#f9e2af",
  red    = "#f38ba8",
  mauve  = "#cba6f7",
  grey   = "#313244",
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.mauve, gui = "bold" },
    b = { fg = colors.fg, bg = colors.grey },
    c = { fg = colors.fg, bg = colors.bg },
  },

  insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
  visual = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
  replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },

  inactive = {
    a = { fg = colors.fg, bg = colors.bg },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      vim.opt.laststatus = 3

      require("lualine").setup({
        options = {
          theme = bubbles_theme,

          component_separators = "",
          section_separators = { left = "", right = "" },

          globalstatus = true,
          always_divide_middle = true,
        },

        sections = {
          lualine_a = {
            {
              "mode",
              separator = { left = "" },
              padding = { left = 1, right = 1 },
            },
          },

          lualine_b = {
            { "branch", icon = "" },
            "diff",
          },

          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = { modified = " ●", readonly = " " },
            },
          },

          lualine_x = {
            "diagnostics",
            "encoding",
            "filetype",
          },

          lualine_y = {
            "progress",
          },

          lualine_z = {
            {
              "location",
              separator = { right = "" },
              padding = { left = 1, right = 1 },
            },
          },
        },

        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },

        extensions = {
          "nvim-tree",
          "toggleterm",
        },
      })
    end,
  },
}

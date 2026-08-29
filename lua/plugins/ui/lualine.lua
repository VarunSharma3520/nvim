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
            {
              -- cmdheight=0 hides the built-in "recording @x" message
              function()
                return "󰑊 recording @" .. vim.fn.reg_recording()
              end,
              cond = function()
                return vim.fn.reg_recording() ~= ""
              end,
              color = { fg = colors.red, gui = "bold" },
            },
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

      -- Refresh immediately instead of waiting for lualine's timer.
      -- On RecordingLeave reg_recording() is still set, so defer past it.
      local grp = vim.api.nvim_create_augroup("lualine-recording", { clear = true })

      vim.api.nvim_create_autocmd("RecordingEnter", {
        group = grp,
        callback = function()
          require("lualine").refresh()
        end,
      })

      vim.api.nvim_create_autocmd("RecordingLeave", {
        group = grp,
        callback = function()
          vim.defer_fn(function()
            require("lualine").refresh()
          end, 50)
        end,
      })
    end,
  },
}

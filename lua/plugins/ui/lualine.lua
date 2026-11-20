-- Bubbles statusline, based on lualine's examples/bubbles.lua

-- Nerd Font glyph by codepoint (kept as escapes so editors/tools can't strip them)
local function nf(cp)
  return vim.fn.nr2char(cp)
end

local colors = {
  black  = "#11111b",
  fg     = "#cdd6f4",
  subtle = "#a6adc8",
  blue   = "#89b4fa",
  green  = "#a6e3a1",
  yellow = "#f9e2af",
  red    = "#f38ba8",
  mauve  = "#cba6f7",
  teal   = "#94e2d5",
  peach  = "#fab387",
  grey   = "#313244",
  grey2  = "#45475a",
}

local LEFT, RIGHT = nf(0xe0b6), nf(0xe0b4)

-- editor background, so the gaps between bubbles blend into the buffer
local function editor_bg()
  local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
  return bg and string.format("#%06x", bg) or "NONE"
end

local function bubbles_theme()
  local bg = editor_bg()
  local function mode(color)
    return {
      a = { fg = colors.black, bg = color, gui = "bold" },
      b = { fg = colors.fg, bg = colors.grey },
      c = { fg = colors.fg, bg = bg },
      x = { fg = colors.fg, bg = bg },
      y = { fg = colors.fg, bg = colors.grey },
      z = { fg = colors.black, bg = color, gui = "bold" },
    }
  end
  return {
    normal = mode(colors.mauve),
    insert = mode(colors.blue),
    visual = mode(colors.yellow),
    replace = mode(colors.red),
    command = mode(colors.peach),
    terminal = mode(colors.teal),
    inactive = {
      a = { fg = colors.subtle, bg = colors.grey },
      b = { fg = colors.subtle, bg = bg },
      c = { fg = colors.subtle, bg = bg },
    },
  }
end

local mode_icons = {
  NORMAL = nf(0xe7c5),
  INSERT = nf(0xf040),
  VISUAL = "󰈈",
  ["V-LINE"] = "󰈈",
  ["V-BLOCK"] = "󰈈",
  REPLACE = nf(0xf0ec),
  ["V-REPLACE"] = nf(0xf0ec),
  COMMAND = nf(0xf120),
  TERMINAL = nf(0xf489),
  SELECT = "󰒅",
  ["S-LINE"] = "󰒅",
  ["S-BLOCK"] = "󰒅",
}

-- hide low-priority components on narrow screens (globalstatus => full width)
local function wider_than(n)
  return function()
    return vim.o.columns > n
  end
end

local function git_diff()
  local s = vim.b.gitsigns_status_dict
  if s then
    return { added = s.added, modified = s.changed, removed = s.removed }
  end
end

-- language servers + formatter in one bubble
local function tools()
  local parts = {}

  local lsps = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(lsps, client.name)
  end
  if #lsps > 0 then
    table.insert(parts, nf(0xf085) .. " " .. table.concat(lsps, ", "))
  end

  local ok, conform = pcall(require, "conform")
  if ok and vim.o.columns > 110 then
    local fmts = {}
    for _, f in ipairs(conform.list_formatters(0)) do
      table.insert(fmts, f.name)
    end
    if #fmts > 0 then
      table.insert(parts, "󰉼 " .. table.concat(fmts, ", "))
    end
  end

  return table.concat(parts, "  ")
end

local function dap_active()
  return package.loaded.dap ~= nil and require("dap").session() ~= nil
end

local function setup()
  -- outer bubble caps blend into StatusLine; make it match the editor bg
  local bg = editor_bg()
  -- (fg differs so nvim doesn't fall back to '^' fillchars when they're equal)
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = bg })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.subtle, bg = bg })

  require("lualine").setup({
    options = {
      theme = bubbles_theme(),
      component_separators = "",
      section_separators = { left = RIGHT, right = LEFT },
      globalstatus = true,
      always_divide_middle = true,
      disabled_filetypes = { statusline = { "alpha", "dashboard" } },
    },

    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(m)
            return (mode_icons[m] or "") .. " " .. m
          end,
          separator = { left = LEFT, right = RIGHT },
          padding = { left = 0, right = 1 },
        },
      },

      lualine_b = {
        { "filetype", icon_only = true, colored = true, padding = { left = 1, right = 0 } },
        {
          "filename",
          path = 1,
          symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]", newfile = " " .. nf(0xf15b) },
        },
        {
          function()
            return vim.b.gitsigns_head or ""
          end,
          icon = { nf(0xe0a0), color = { fg = colors.peach } },
          cond = function()
            return vim.b.gitsigns_head ~= nil and vim.o.columns > 80
          end,
          separator = { right = RIGHT },
        },
      },

      lualine_c = {
        {
          "diff",
          source = git_diff,
          symbols = { added = nf(0xf457) .. " ", modified = nf(0xf459) .. " ", removed = nf(0xf458) .. " " },
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.yellow },
            removed = { fg = colors.red },
          },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = nf(0xf057) .. " ", warn = nf(0xf071) .. " ", info = nf(0xf05a) .. " ", hint = "󰌵 " },
          diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.blue },
            hint = { fg = colors.teal },
          },
        },

        "%=", -- center: transient editor state

        {
          -- cmdheight=0 hides the built-in "recording @x" message
          function()
            return "󰑊 REC @" .. vim.fn.reg_recording()
          end,
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
          color = { fg = colors.black, bg = colors.red, gui = "bold" },
          separator = { left = LEFT, right = RIGHT },
          padding = 0,
        },
        { "%S", color = { fg = colors.peach, gui = "bold" } }, -- pending keys, e.g. `d2`
        { "searchcount", maxcount = 999, timeout = 500, icon = nf(0xf002), color = { fg = colors.yellow } },
        { "selectioncount", icon = "󰒅", color = { fg = colors.yellow } },
        {
          function()
            return nf(0xf188) .. " " .. require("dap").status()
          end,
          cond = dap_active,
          color = { fg = colors.red },
        },
      },

      lualine_x = {
        {
          tools,
          cond = function()
            return tools() ~= ""
          end,
          color = { fg = colors.blue, bg = colors.grey },
          separator = { left = LEFT, right = RIGHT },
          padding = 0,
        },
      },

      lualine_y = {
        { "encoding", cond = wider_than(130), separator = { left = LEFT } },
        { "filetype", colored = false, cond = wider_than(90) },
        { "progress", icon = nf(0xf0c9), cond = wider_than(70) },
      },

      lualine_z = {
        {
          "location",
          icon = nf(0xe0a1),
          separator = { left = LEFT, right = RIGHT },
          padding = { left = 1, right = 0 },
        },
      },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", separator = { left = LEFT, right = RIGHT } } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },

    extensions = {
      "nvim-tree",
      "toggleterm",
      "nvim-dap-ui",
      "trouble",
      "lazy",
      "mason",
    },
  })
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      vim.opt.laststatus = 3
      -- cmdheight=0 hides pending keys; render them in the statusline via %S
      vim.opt.showcmd = true
      vim.opt.showcmdloc = "statusline"

      setup()

      local grp = vim.api.nvim_create_augroup("lualine-refresh", { clear = true })
      local refresh = function()
        require("lualine").refresh()
      end

      -- rebuild theme so bubble gaps keep matching the editor background
      vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = setup })

      vim.api.nvim_create_autocmd("RecordingEnter", { group = grp, callback = refresh })
      -- On RecordingLeave reg_recording() is still set, so defer past it.
      vim.api.nvim_create_autocmd("RecordingLeave", {
        group = grp,
        callback = function()
          vim.defer_fn(refresh, 50)
        end,
      })
      vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
        group = grp,
        callback = function()
          vim.schedule(refresh)
        end,
      })
      vim.api.nvim_create_autocmd("User", { group = grp, pattern = "GitSignsUpdate", callback = refresh })
    end,
  },
}

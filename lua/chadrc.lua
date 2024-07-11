-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "bearded-arc",

  hl_override = {
    Normal = { bg = "NONE" },
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeEndOfBuffer = { bg = "NONE" },
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  lsp = { signature = true },
  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
    order = nil,
    modules = nil,
  },
}

-- require("custom.snippets")


return M

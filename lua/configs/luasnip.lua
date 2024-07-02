
local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

ls.add_snippets("python", {
    s("def", {
        t("def"),
        i(1, "name"),
        t("("),
        i(2, "args"),
        t({ "):", "\t" }),
        i(0,"pass"),
    }),
})




require("luasnip.loaders.from_vscode").lazy_load()



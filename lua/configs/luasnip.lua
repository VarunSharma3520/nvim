
local ls = require("luasnip")
local types = require("luasnip.util.types")
require("luasnip.loaders.from_vscode").lazy_load()

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

-- Config
ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

-- Snippets
ls.add_snippets("css", {
    -- CSS rule snippet
    s("rule", {
        t({ "", "" }),
        i(1, "selector"), t({ " {", "    " }),
        i(2, "property: value;"),
        t({ "", "}" }),
    }),
    -- CSS flex container snippet
    s("flex", {
        t("display: flex;"),
        t({ "", "flex-direction: " }), i(1, "row"), t(";"),
        t({ "", "justify-content: " }), i(2, "flex-start"), t(";"),
        t({ "", "align-items: " }), i(3, "stretch"), t(";"),
    }),
    -- CSS grid container snippet
    s("grid", {
        t("display: grid;"),
        t({ "", "grid-template-columns: " }), i(1, "repeat(auto-fit, minmax(100px, 1fr))"), t(";"),
        t({ "", "grid-gap: " }), i(2, "10px"), t(";"),
    }),
    -- CSS media query snippet
    s("media", {
        t("@media (min-width: "), i(1, "768px"), t({ ") {", "    " }),
        i(2, "/* styles go here */"),
        t({ "", "}" }),
    }),
    -- CSS animation keyframes snippet
    s("keyframes", {
        t("@keyframes "), i(1, "animation-name"), t({ " {", "    " }),
        t("0% { "), i(2, "/* initial styles */"), t(" }"),
        t({ "", "    " }),
        t("100% { "), i(3, "/* final styles */"), t(" }"),
        t({ "", "}" }),
    }),
})

ls.add_snippets("javascript", {
    -- Function snippet
    s("func", {
        t("function "), i(1, "name"), t("("), i(2, "params"), t(") {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" }),
    }),
    -- Console log snippet
    s("clg", {
        t("console.log("), i(1, "message"), t(");"),
    }),
    -- Arrow Function snippet
    s("afunc", {
        t("const "), i(1, "name"), t(" = ("), i(2, "params"), t(") => {"),
        t({ "", "\t" }), i(0),
        t({ "", "};" }),
    }),
    -- Express route snippet
    s("express", {
        t("app."), c(1, { t("get"), t("post"), t("put"), t("delete") }),
        t("('"), i(2, "/path"), t("', (req, res) => {"),
        t({ "", "\t" }), i(3, "res.send('Hello World!');"),
        t({ "", "});" }),
    }),
})

ls.add_snippets("html", {
    -- HTML boilerplate snippet
    s("html5", {
        t({ "<!DOCTYPE html>", "<html lang=\"en\">", "<head>", "    <meta charset=\"UTF-8\">", 
        "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "    <title>" }),
        i(1, "Document"),
        t({ "</title>", "</head>", "<body>", "    " }),
        i(2, "<!-- Content goes here -->"),
        t({ "", "</body>", "</html>" }),
    }),
    -- HTML link snippet
    s("link", {
        t("<a href=\""), i(1, "url"), t("\">"), i(2, "link text"), t("</a>"),
    }),
    -- HTML image snippet
    s("img", {
        t("<img src=\""), i(1, "url"), t("\" alt=\""), i(2, "description"), t("\" />"),
    }),
    -- HTML script snippet
    s("script", {
        t("<script src=\""), i(1, "url"), t("\"></script>"),
    }),
})

ls.add_snippets("react", {
    -- React functional component
    s("rfc", {
        t("import React from 'react';"),
        t({ "", "", "const " }), i(1, "ComponentName"), t(" = () => {"),
        t({ "", "    return (" }),
        t({ "        <div>", "            " }), i(2, "content"), t({ "", "        </div>" }),
        t({ "", "    );", "};", "", "export default " }), i(1, "ComponentName"), t(";"),
    }),
    -- React useState hook
    s("useState", {
        t("const ["), i(1, "state"), t(", set"), i(2, "State"), t("] = React.useState("), i(3, "initialValue"), t(");"),
    }),
})


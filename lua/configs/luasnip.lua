local ls = require("luasnip")
local types = require("luasnip.util.types")
require("luasnip.loaders.from_vscode").lazy_load()

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

ls.add_snippets("css", {
    -- CSS rule snippet
    s({
        trig = "rule",
name = "CSS Rule",
        dscr = "Basic CSS rule with selector and properties"
    }, {
        t({ "", "" }),
        i(1, "selector"), t({ " {", "    " }),
        i(2, "property: value;"),
        t({ "", "}" })
    }),
    -- CSS flex container snippet
    s({
        trig = "flex",
        name = "Flex Container",
        dscr = "CSS Flexbox container with common properties"
    }, {
        t("display: flex;"),
        t({ "", "flex-direction: " }),
        i(1, "row"),
        t(";"),
        t({ "", "justify-content: " }),
        i(2, "flex-start"),
        t(";"),
        t({ "", "align-items: " }),
        i(3, "stretch"),
        t(";"),
    }),
    -- CSS grid container snippet
    s({
        trig = "grid",
        name = "Grid Container",
        dscr = "CSS Grid container with common properties"
    }, {
        t("display: grid;"),
        t({ "", "grid-template-columns: " }),
        i(1, "repeat(auto-fit, minmax(100px, 1fr))"),
        t(";"),
        t({ "", "grid-gap: " }),
        i(2, "10px"),
        t(";"),
    }),
    -- CSS media query snippet
    s({
        trig = "media",
        name = "Media Query",
        dscr = "CSS media query template"
    }, {
        t("@media (min-width: "),
        i(1, "768px"),
        t({ ") {", "    " }),
        i(2, "/* styles go here */"),
        t({ "", "}" })
    }),
    -- CSS animation keyframes snippet
    s({
        trig = "keyframes",
        name = "Keyframes",
        dscr = "CSS animation keyframes template"
    }, {
        t("@keyframes "),
        i(1, "animation-name"),
        t({ " {", "    " }),
        t("0% { "),
        i(2, "/* initial styles */"),
        t(" }"),
        t({ "", "    " }),
        t("100% { "),
        i(3, "/* final styles */"),
        t(" }"),
        t({ "", "}" })
    }),
})

ls.add_snippets("go", {
	-- Function snippet
	s("func", {
		t("func "),
		i(1, "name"),
		t("("),
		i(2, "params"),
		t(") "),
		i(3, "returns"),
		t(" {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
	-- Struct snippet
	s("struct", {
		t("type "),
		i(1, "Name"),
		t(" struct {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
	-- Main function snippet
	s("main", {
		t("func main() {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
})

ls.add_snippets("html", {
    -- HTML boilerplate snippet
    s({
        trig = "html5",
        name = "HTML5 Boilerplate",
        dscr = "Basic HTML5 boilerplate"
    }, {
        t({ "<!DOCTYPE html>", "<html lang=\"en\">", "<head>", "    <meta charset=\"UTF-8\">", "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "    <title>" }),
        i(1, "Document"),
        t({ "</title>", "</head>", "<body>", "    " }),
        i(2, "<!-- Content goes here -->"),
        t({ "", "</body>", "</html>" })
    }),
    -- HTML link snippet
    s({
        trig = "link",
        name = "Link",
        dscr = "HTML link tag"
    }, {
        t("<a href=\""),
        i(1, "url"),
        t("\">"),
        i(2, "link text"),
        t("</a>")
    }),
    -- HTML image snippet
    s({
        trig = "img",
        name = "Image",
        dscr = "HTML image tag"
    }, {
        t("<img src=\""),
        i(1, "url"),
        t("\" alt=\""),
        i(2, "description"),
        t("\" />")
    }),
    -- HTML script snippet
    s({
        trig = "script",
        name = "Script",
        dscr = "HTML script tag"
    }, {
        t("<script src=\""),
        i(1, "url"),
        t("\"></script>")
    }),
    -- HTML style snippet
    s({
        trig = "style",
        name = "Style",
        dscr = "HTML style tag"
    }, {
        t("<style>"),
        t({ "", "    " }),
        i(1, "/* CSS styles go here */"),
        t({ "", "</style>" })
    }),
})

ls.add_snippets("javascript", {
	-- Function snippet
	s("func", {
		t("function "),
		i(1, "name"),
		t("("),
		i(2, "params"),
		t(") {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
	-- Express route snippet
	s("request_express", {
		t("app."),
		c(1, { t("get"), t("post"), t("put"), t("patch"), t("delete") }),
		t("('"),
		i(2, "/"),
		t("', "),
		i(3, "(req, res) => { "),
		i(4, "res.send('Hello World!')"),
		t(" })"),
		t(");"),
		i(0),
	}),
	-- Arrow Function snippet
	s("afunc", {
		t("const "),
		i(1, "name"),
		t(" = ("),
		i(2, "params"),
		t(") => {\n"),
		t("\t"),
		i(0),
		t("\n};\n"),
	}),
	-- Console log snippet
	s("clg", {
		t("console.log("),
		i(1, "message"),
		t(");\n"),
	}),
	s("clg", {
		t("console.log("),
		i(1, "message"),
		t(");\n"),
	}),
})

ls.add_snippets("javascriptreact", {
	s("rfc", {
		t("import React from 'react';\n\n"),
		t("const "),
		i(1, "ComponentName"),
		t(" = () => {\n"),
		t("    return (\n"),
		t("        <div>\n"),
		t("            "),
		i(2, "content"),
		t("\n"),
		t("        </div>\n"),
		t("    );\n"),
		t("};\n\n"),
		t("export default "),
		i(1, "ComponentName"),
		t(";\n"),
	}),
	s({
		trig = "impp",
		name = 'import "package-name"',
		desc = "Import a package that only has side effects",
	}, {
		t('import "'),
		i(1, ""),
		t('"'),
	}),
})

ls.add_snippets("lua", {
    -- Lua function snippet
    s({
        trig = "xfn",
        name = "Function",
        dscr = "Lua function"
    }, {
        t("function "),
        i(1, "name"),
        t("("),
        i(2, "args"),
        t({ ")", "    " }),
        i(3, "-- body"),
        t({ "", "end" })
    }),
    -- Lua local function snippet
    s({
        trig = "lfn",
        name = "Local Function",
        dscr = "Lua local function"
    }, {
        t("local function "),
        i(1, "name"),
        t("("),
        i(2, "args"),
        t({ ")", "    " }),
        i(3, "-- body"),
        t({ "", "end" })
    }),
    -- Lua table snippet
    s({
        trig = "tbl",
        name = "Table",
        dscr = "Lua table"
    }, {
        t("local "),
        i(1, "tbl_name"),
        t(" = {"),
        t({ "", "    " }),
        i(2, "-- key-value pairs"),
        t({ "", "}" })
    }),
    -- Lua for loop snippet
    s({
        trig = "for",
        name = "For Loop",
        dscr = "Lua for loop"
    }, {
        t("for "),
        i(1, "i"),
        t(" = "),
        i(2, "1"),
        t(", "),
        i(3, "10"),
        t(" do"),
        t({ "", "    " }),
        i(4, "-- body"),
        t({ "", "end" })
    }),
    -- Lua pairs loop snippet
    s({
        trig = "pairs",
        name = "Pairs Loop",
        dscr = "Lua pairs loop"
    }, {
        t("for "),
        i(1, "k, v"),
        t(" in pairs("),
        i(2, "table"),
        t(") do"),
        t({ "", "    " }),
        i(3, "-- body"),
        t({ "", "end" })
    }),
    -- Lua require snippet
    s({
        trig = "req",
        name = "Require Module",
        dscr = "Lua require module"
    }, {
        t("local "),
        i(1, "module"),
        t(" = require('"),
        i(2, "module_name"),
        t("')")
    }),
})

ls.add_snippets("python", {
	s("def", {
		t("def"),
		i(1, "name"),
		t("("),
		i(2, "argsji"),
		t({ "):", "\t" }),
		i(0, "pass"),
	}),
})

ls.add_snippets("react", {
	s("asddef", {
		t("def"),
		i(1, "name"),
		t("("),
		i(2, "argsji"),
		t({ "):", "\t" }),
		i(0, "pass"),
	}),
})

ls.add_snippets("rust", {
	-- Function snippet
	s("fn", {
		t("fn "),
		i(1, "name"),
		t("("),
		i(2, "params"),
		t(") -> "),
		i(3, "return_type"),
		t(" {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
	-- Struct snippet
	s("struct", {
		t("struct "),
		i(1, "Name"),
		t(" {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
	-- Main function snippet
	s("main", {
		t("fn main() {\n"),
		t("\t"),
		i(0),
		t("\n}\n"),
	}),
})

ls.add_snippets("tailwindcss", {
    -- Tailwind CSS container class snippet
    s({
        trig = "container",
        name = "Container",
        dscr = "Tailwind CSS container class"
    }, {
        t("container mx-auto px-4")
    }),
    -- Tailwind CSS flex class snippet
    s({
        trig = "flex",
        name = "Flex",
        dscr = "Tailwind CSS flex container with common properties"
    }, {
        t("flex "),
        i(1, "flex-row"),
        t(" "),
        i(2, "justify-start"),
        t(" "),
        i(3, "items-stretch")
    }),
    -- Tailwind CSS grid class snippet
    s({
        trig = "grid",
        name = "Grid",
        dscr = "Tailwind CSS grid container with common properties"
    }, {
        t("grid grid-cols-"),
        i(1, "1"),
        t(" gap-"),
        i(2, "4")
    }),
    -- Tailwind CSS button class snippet
    s({
        trig = "btn",
        name = "Button",
        dscr = "Tailwind CSS button class"
    }, {
        t("px-4 py-2 bg-"),
        i(1, "blue-500"),
        t(" text-white font-bold rounded")
    }),
    -- Tailwind CSS text class snippet
    s({
        trig = "text",
        name = "Text",
        dscr = "Tailwind CSS text class"
    }, {
        t("text-"),
        i(1, "base"),
        t(" text-"),
        i(2, "gray-800"),
        t(" "),
        i(3, "font-normal")
    }),
})
ls.add_snippets("typescriptreact", {
    -- TypeScript React function component snippet
    s({
        trig = "rfc",
        name = "React Functional Component",
        dscr = "TypeScript React functional component"
    }, {
        t("import React from 'react';"),
        t({ "", "", "interface " }),
        i(1, "Props"),
        t({ " {", "    " }),
        i(2, "/* props go here */"),
        t({ "", "}", "", "", "const " }),
        i(3, "ComponentName"),
        t(": React.FC<"),
        t({ "> = (props) => {", "    return (", "        " }),
        i(4, "<div></div>"),
        t({ "", "    );", "};", "", "export default " }),
        t(";")
    }),
    -- TypeScript React useState snippet
    s({
        trig = "useState",
        name = "useState Hook",
        dscr = "TypeScript React useState hook"
    }, {
        t("const ["),
        i(1, "state"),
        t(", set"),
        t("] = React.useState<"),
        i(2, "type"),
        t(">("),
        i(3, "initialValue"),
        t(");")
    }),
    -- TypeScript React useEffect snippet
    s({
        trig = "useEffect",
        name = "useEffect Hook",
        dscr = "TypeScript React useEffect hook"
    }, {
        t("React.useEffect(() => {"),
        t({ "", "    " }),
        i(1, "// effect"),
        t({ "", "    return () => {", "        " }),
        i(2, "// cleanup"),
        t({ "", "    };", "}, [" }),
        i(3, "dependencies"),
        t("]);")
    }),
    -- TypeScript React useContext snippet
    s({
        trig = "useContext",
        name = "useContext Hook",
        dscr = "TypeScript React useContext hook"
    }, {
        t("const "),
        i(1, "context"),
        t(" = React.useContext("),
        i(2, "Context"),
        t(");")
    }),
    -- TypeScript React component with props snippet
    s({
        trig = "rfcprops",
        name = "React Functional Component with Props",
        dscr = "TypeScript React functional component with props"
    }, {
        t("import React from 'react';"),
        t({ "", "", "interface " }),
        i(1, "Props"),
        t({ " {", "    " }),
        i(2, "/* props go here */"),
        t({ "", "}", "", "", "const " }),
        i(3, "ComponentName"),
        t(": React.FC<"),
        t({ "> = ({ ", "" }),
        i(4, "props"),
        t({ " }) => {", "    return (", "        " }),
        i(5, "<div></div>"),
        t({ "", "    );", "};", "", "export default " }),
        t(";")
    }),
})



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
		i(0, "pass"),
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

require("luasnip.loaders.from_vscode").lazy_load()

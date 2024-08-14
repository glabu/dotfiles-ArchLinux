local helpers = require("personal/luasnip-helper-funcs")
local get_visual = helpers.get_visual

-- Math context detection
local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

-- Return snippet tables
return {
	-- Paréntesis de apertura y cierre dinámicos
	s(
		{ trig = "([^%a])l%(", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\left(<>\\right)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Corchetes de apertura y cierre dinámicos
	s(
		{ trig = "([^%a])l%[", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\left[<>\\right]", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Llaves de apertura y cierre dinámicos
	s(
		{ trig = "([^%a])l%{", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\left\\{<>\\right\\}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Paréntesis grandes
	s(
		{ trig = "([^%a])b%(", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\bigg(<>\\bigg)", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Corchetes grandes
	s(
		{ trig = "([^%a])b%[", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\big[<>\\big]", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Llaves grandes
	s(
		{ trig = "([^%a])b%{", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\big\\{<>\\big\\}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Símbolo de las llaves
	s(
		{ trig = "([^%a])\\%{", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\{<>\\}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- Entrecomillados de LaTeX
	s(
		{ trig = "``", snippetType = "autosnippet" },
		fmta("``<>''", {
			d(1, get_visual),
		})
	),
}

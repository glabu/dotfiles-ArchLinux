local helpers = require("personal/luasnip-helper-funcs")
local get_visual = helpers.get_visual

-- Un OR lógico de `line_begin` y de regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
	local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
	local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
	return line_begin or non_letter
end

-- Math context detection
local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

local line_begin = function(line_to_cursor, matched_trigger)
	-- +1 because `string.sub("abcd", 1, -2)` -> abc
	return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

-- Return snippet tables
return {
	-- TYPEWRITER (i.e. \texttt)
	s(
		{ trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\texttt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_text }
	),
	-- NEGRITA (i.e. \textbf)
	s(
		{ trig = "([^%a])tbf", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("<>\\textbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_text }
	),
	-- CURSIVA (i.e. \emph, utilizo emph que es más dinámico)
	s(
		{ trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\emph{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_text }
	),
	-- NÚMEROS ROMANOS (i.e. \RN con 'biblatex')
	s(
		{ trig = "nrr", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\RN{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_text }
	),
	-- MATES RECTAS i.e. \mathrm
	s(
		{ trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathrm{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES CALIGRÁFICAS i.e. \mathcal
	s(
		{ trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES GÓTICAS i.e. \mathfrak
	s(
		{ trig = "([^%a])mkk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathfrak{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES EN NEGRITA i.e. \mathbf
	s(
		{ trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES DE PIZARRA i.e. \mathbb
	s(
		{ trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES EN SANS SERIF (un solo símbolo) i.e. \symsfup
	s(
		{ trig = "([^%a])ssf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symsf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES EN SANS SERIF Y NEGRITA (un solo símbolo) i.e. \symbfsfup
	s(
		{ trig = "([^%a])sbs", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symbfsf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES RECTAS (un solo símbolo) i.e. \symrm
	s(
		{ trig = "([^%a])rsm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symrm{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES CALIGRÁFICAS (un solo símbolo) i.e. \symcal
	s(
		{ trig = "([^%a])scc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES GÓTICAS (un solo símbolo) i.e. \symfrak
	s(
		{ trig = "([^%a])skk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symfrak{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES EN NEGRITA (un solo símbolo) i.e. \symbf
	s(
		{ trig = "([^%a])sbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES DE PIZARRA (un sólo símbolo) i.e. \symbb
	s(
		{ trig = "([^%a])spi", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES CALIGRÁFICAS Y NEGRITAS (un solo símbolo) i.e. \symbfcal
	s(
		{ trig = "([^%a])sbc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\symbfcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- TEXTO PLANO i.e. \text (dentro de un entorno matemático)
	s(
		{ trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\text{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
}

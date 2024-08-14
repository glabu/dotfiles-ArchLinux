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
	-- SUPERÍNDICE
	s(
		{ trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE
	s(
		{ trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE Y SUPERÍNDICE
	s(
		{ trig = "([%w%)%]%}])__", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>^{<>}_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE CON TEXTO
	s(
		{ trig = "sd", snippetType = "autosnippet", wordTrig = false },
		fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
		{ condition = tex.in_mathzone }
	),
	-- SUPERÍNDICE RÁPIDO
	-- El primer carácter alfanumérico después del trigger (comillas dobles) lo meto en un superíndice.
	s(
		{ trig = '([%w%)%]%}])"([%w])', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE RÁPIDO
	-- El primer carácter alfanumérico después del trigger (dos puntos) lo meto en un subíndice.
	s(
		{ trig = "([%w%)%]%}]):([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUPERÍNDICE RÁPIDO DEL NÚMERO DE EULER
	s(
		{ trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\eu^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE CERO RÁPIDO
	s(
		{ trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("0"),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUBÍNDICE j RÁPIDO (jk está reservado para saltar hacia delante los snippets)
	s(
		{ trig = "([%a%)%]%}])JJ", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("j"),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUPERÍNDICE + RÁPIDO
	s(
		{ trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("+"),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUPERÍNDICE DEL CONJUGADO (ASTERISCO) RÁPIDO
	s(
		{ trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			t("*"),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VECTOR CON FLECHITA, i.e. \vec
	s(
		{ trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\vec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VECTORES DE LA BASE CON SUBÍNDICE, i.e. \unitvector_{}
	s(
		{ trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\unitvector_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VECTORES DE LA BASE CON GORRITO, i.e. \uvec
	s(
		{ trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\uvec{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- GORRITO, i.e. \hat
	s(
		{ trig = "([^%a])grr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\hat{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- BARRITA, i.e. \bar
	s(
		{ trig = "([^%a])brr", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\bar{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- FRACCIONES
	s(
		{ trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\frac{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- ÁNGULOS
	s(
		{ trig = "([^%a])dee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\ang{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VALOR ABSOLUTO
	s(
		{ trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\abs{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VALOR ESPERADO EN FORMA COMPACTA
	s(
		{ trig = "([^%a])xv", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\xval{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- VALOR ESPERADO EN FORMA EXPANDIDA
	s(
		{ trig = "([^%a])XV", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\Xval{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
			i(3),
		}),
		{ condition = tex.in_mathzone }
	),
	-- BRA DEL ESPACIO DE HILBERT
	s(
		{ trig = "([^%a])bb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\bra{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- KET DEL ESPACIO DE HILBERT
	s(
		{ trig = "([^%a])kk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\ket{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- PRODUCTO INTERNO
	s(
		{ trig = "([^%a])bk", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>\\braket{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- RAÍZ CUADRADA
	s(
		{ trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sqrt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SÍMBOLO DEL BINOMIO
	s(
		{ trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\binom{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- LOGARITMOS CON BASE CUALQUIERA
	s(
		{ trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\log_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA SOLO CON DENOMINADOR
	s(
		{ trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA CON NUMERADOR Y DENOMINADOR
	s(
		{ trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA CON NUMERADOR, DENOMINADOR Y ORDEN DE DERIVACIÓN SUPERIOR
	s(
		{ trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\dvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA PARCIAL SOLO CON DENOMINADOR
	s(
		{ trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvOne{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA PARCIAL CON NUMERADOR Y DENOMINADOR
	s(
		{ trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdv{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- DERIVADA PARCIAL CON NUMERADOR, DENOMINADOR Y ORDEN SUPERIOR
	s(
		{ trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\pdvN{<>}{<>}{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
			i(3),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUMA CON LÍMITE INFERIOR
	s(
		{ trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		}),
		{ condition = tex.in_mathzone }
	),
	-- SUMA CON LÍMITE SUPERIOR E INFERIOR
	s(
		{ trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\sum_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- INTEGRAL con límite superior e inferior
	s(
		{ trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{<>}^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		}),
		{ condition = tex.in_mathzone }
	),
	-- INTEGRAL de menos a más infinito (todo R)
	s(
		{ trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
		fmta("<>\\int_{\\infty}^{\\infty}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_mathzone }
	),
	---------------------------
	-- BEGIN STATIC SNIPPETS
	---------------------------

	-- DIFERENCIAL TOTAL, i.e. \diff
	s({ trig = "df", snippetType = "autosnippet", priority = 2000 }, {
		t("\\diff"),
	}, { condition = tex.in_mathzone }),
	-- DIFERENCIAL PARCIAL, i.e. \pdiff
	s({ trig = "pdf", snippetType = "autosnippet", priority = 2000 }, {
		t("\\pdiff"),
	}, { condition = tex.in_mathzone }),
	-- INTEGRAL SIMPLE, i.e. \int
	s({ trig = "in1", snippetType = "autosnippet" }, {
		t("\\int"),
	}, { condition = tex.in_mathzone }),
	-- INTEGRAL DOBLE, i.e. \iint
	s({ trig = "in2", snippetType = "autosnippet" }, {
		t("\\iint"),
	}, { condition = tex.in_mathzone }),
	-- INTEGRAL TRIPLE, i.e. \iiint
	s({ trig = "in3", snippetType = "autosnippet" }, {
		t("\\iiint"),
	}, { condition = tex.in_mathzone }),
	-- INTEGRAL CERRADA, i.e. \oint
	s({ trig = "oi1", snippetType = "autosnippet" }, {
		t("\\oint"),
	}, { condition = tex.in_mathzone }),
	-- INTEGRAL DOBLE CERRADA, i.e. \oiint
	s({ trig = "oi2", snippetType = "autosnippet" }, {
		t("\\oiint"),
	}, { condition = tex.in_mathzone }),
	-- OPERADOR GRADIENTE, i.e. \grad
	s({ trig = "gdd", snippetType = "autosnippet" }, {
		t("\\grad "),
	}, { condition = tex.in_mathzone }),
	-- OPERADOR ROTACIONAL, i.e. \curl
	s({ trig = "cll", snippetType = "autosnippet" }, {
		t("\\curl "),
	}, { condition = tex.in_mathzone }),
	-- OPERADOR DIVERGENCIA, i.e. \divergence
	s({ trig = "DI", snippetType = "autosnippet" }, {
		t("\\diver "),
	}, { condition = tex.in_mathzone }),
	-- OPERADOR LAPLACIANO, i.e. \laplacian
	s({ trig = "laa", snippetType = "autosnippet" }, {
		t("\\laplacian "),
	}, { condition = tex.in_mathzone }),
	-- D'ALAMBERTIANO, i.e. \dalambert
	s({ trig = "dlt", snippetType = "autosnippet" }, {
		t("\\dalambert "),
	}, { condition = tex.in_mathzone }),
	-- DERIVADA CON SÍMBOLO DE LA COMILLA (i.e. \prime)
	s({ trig = "fpr", snippetType = "autosnippet" }, {
		t("\\prime "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO DE PARALELISMO, i.e. \parallel
	s({ trig = "pll", snippetType = "autosnippet" }, {
		t("\\parallel "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO DE PERPENDICULARIDAD, i.e. \perp
	s({ trig = "prp", snippetType = "autosnippet" }, {
		t("\\perp "),
	}, { condition = tex.in_mathzone }),
	-- PUNTOS SUSPENSIVOS CENTRADOS, i.e. \cdots
	s({ trig = "cdd", snippetType = "autosnippet" }, {
		t("\\cdots "),
	}, { condition = tex.in_mathzone }),
	-- PUNTOS SUSPENSIVOS BAJOS, i.e. \ldots
	s({ trig = "ldd", snippetType = "autosnippet" }, {
		t("\\ldots "),
	}, { condition = tex.in_mathzone }),
	-- EQUIVALENTE, i.e. \equiv
	s({ trig = "eqq", snippetType = "autosnippet" }, {
		t("\\equiv "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO DEL IGUAL CON PUNTO ENCIMA
	s({ trig = "dqq", snippetType = "autosnippet" }, {
		t("\\doteq "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO DEL MENOS ENTRE CONJUNTOS, i.e. \setminus
	s({ trig = "stm", snippetType = "autosnippet" }, {
		t("\\setminus "),
	}, { condition = tex.in_mathzone }),
	-- SUBCONJUNTO, i.e. \subset
	s({ trig = "sbb", snippetType = "autosnippet" }, {
		t("\\subset "),
	}, { condition = tex.in_mathzone }),
	-- APPROX, i.e. \approx
	s({ trig = "px", snippetType = "autosnippet" }, {
		t("\\approx "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO DEL ORDEN DE, i.e. \sim
	s({ trig = "qs", snippetType = "autosnippet" }, {
		t("\\sim "),
	}, { condition = tex.in_mathzone }),
	-- SÍMBOLO MÁS/MENOS, i.e. \pm
	s({ trig = "+-", snippetType = "autosnippet" }, {
		t("\\pm "),
	}, { condition = tex.in_mathzone }),
	-- PROPORCIONAL, i.e. \propto
	s({ trig = "pt", snippetType = "autosnippet" }, {
		t("\\propto "),
	}, { condition = tex.in_mathzone }),
	-- DOS PUNTOS SEPARADORES, i.e. \colon
	s({ trig = "::", snippetType = "autosnippet" }, {
		t("\\colon "),
	}, { condition = tex.in_mathzone }),
	-- IMPLICA, i.e. \implies
	s({ trig = "->", snippetType = "autosnippet" }, {
		t("\\implies "),
	}, { condition = tex.in_mathzone }),
	-- MUCHO MENOS QUE
	s({ trig = "<<", snippetType = "autosnippet" }, {
		t("\\ll "),
	}, { condition = tex.in_mathzone }),
	-- MUCHO MÁS QUE
	s({ trig = ">>", snippetType = "autosnippet" }, {
		t("\\gg "),
	}, { condition = tex.in_mathzone }),
	-- PRODUCTO ESCALAR, i.e. \cdot
	s({ trig = ",.", snippetType = "autosnippet" }, {
		t("\\cdot "),
	}, { condition = tex.in_mathzone }),
	-- PRODUCTO VECTORIAL, i.e. \times
	s({ trig = "xx", snippetType = "autosnippet" }, {
		t("\\times "),
	}, { contidion = tex.in_mathzone }),
	-- El NÚMERO i
	s({ trig = "uii", snippetType = "autosnippet" }, {
		t("\\iu "),
	}, { condition = tex.in_mathzone }),
	-- PARTE REAL DE UN COMPLEJO
	s({ trig = "rpt", snippetType = "autosnippet" }, {
		t("\\RE "),
	}, { condition = tex.in_mathzone }),
	-- PARTE IMAGINARIA DE UN COMPLEJO
	s({ trig = "ipt", snippetType = "autosnippet" }, {
		t("\\IM "),
	}, { condition = tex.in_mathzone }),
	-- LA CONSTANTE DE PLANCK (cuantizada)
	s({ trig = "pkk", snippetType = "autosnippet" }, {
		t("\\hslash "),
	}, { contidion = tex.in_mathzone }),
}

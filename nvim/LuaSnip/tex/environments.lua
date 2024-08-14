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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return {
	-- ENTORNO RANDOM
	s(
		{ trig = "new", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENTORNO RANDOM CON UN ARGUMENTO
	s(
		{ trig = "n2", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				i(2),
				d(3, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENTORNO RANDOM CON DOS ARGUMENTOS
	s(
		{ trig = "n3", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{<>}{<>}{<>}
            <>
        \end{<>}
      ]],
			{
				i(1),
				i(2),
				i(3),
				d(4, get_visual),
				rep(1),
			}
		),
		{ condition = line_begin }
	),
	-- ECUACIÓN NO NUMERADA
	s(
		{ trig = "nn", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- ECUACIÓN PARTIDA A CACHOS NO NUMERADA
	s(
		{ trig = "ss", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{equation*}
            \begin{split}
                <>
            \end{split}
        \end{equation*}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- ALINEAR ECUACIONES SIN NUMERAR
	s(
		{ trig = "all", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{align*}
            <>
        \end{align*}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- ECUACIONES ALINEADAS DENTRO DE UNA CAJA PERSONALIZADA (utilizo 'empheq' y 'tcolorbox')
	s(
		{ trig = "bem", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{empheq}[box=\tcbhighmath]{align}
            <>
        \end{empheq}
      ]],
			{
				i(1),
			}
		),
		{ condition = line_begin }
	),
	-- ENTORNO PERSONALIZADO PARA HACER CAJAS RESUMEN DE ECUACIONES
	s(
		{ trig = "btreq", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{footheorem*}{<>}
            <>
        \end{footheorem*}
      ]],
			{
				i(1, "titulo"),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- LISTAS
	s(
		{ trig = "itt", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
			{
				i(0),
			}
		),
		{ condition = line_begin }
	),
	-- ENUMERAR
	s(
		{ trig = "enn", snippetType = "autosnippet" },
		fmta(
			[[
        \begin{enumerate}

            \item <>

        \end{enumerate}
      ]],
			{
				i(0),
			}
		)
	),
	-- MATES ENTRE LÍNEAS
	s(
		{ trig = "([^%a^%{])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATES ENTRE LÍNEAS (en nueva línea)
	s(
		{ trig = "^mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("$<>$", {
			i(1),
		})
	),
	-- TABLA
	s(
		{ trig = "tab" },
		fmta(
			[[
        \begin{tab}[htbp]
          \centering
          \caption{<>}
          \label{tab:<>}
          \begin{tabular}{<>}
          \toprule
            <>
          \midrule
            <>
          \bottomrule
          \end{tabular}
        \end{table}
        ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(5),
			}
		),
		{ condition = line_begin }
	),
	-- FIGURA
	s(
		{ trig = "fig" },
		fmta(
			[[
        \begin{figure}[htbp]
          \centering
          \includegraphics[width=<>\textwidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
			}
		),
		{ condition = line_begin }
	),
}

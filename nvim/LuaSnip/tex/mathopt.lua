local helpers = require("personal/luasnip-helper-funcs")
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection
local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

return {
	-- Ecuación con opción de escoger etiqueta
	s(
		{
			trig = "beq",
			dscr = "Expande 'beq' para abrir el entorno equation, pero con opción de poner labels",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{equation}<>
          <>
        \end{equation}
      ]],
			{
				c(1, {
					sn(
						2, -- Decide si quieres poner label o no en la ecuación
						{
							t("\\label{eq:"),
							i(1),
							t("}"),
						}
					),
					t([[]]), -- Choose no label
				}, {}),
				i(2),
			}
		),
		{ condition = line_begin }
	),

	-- Ecuación de varias líneas con opción de escoger etiqueta
	s(
		{
			trig = "bsp",
			dscr = "Expande 'bsp' para abrir el entorno split, pero con opción de poner labels",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{equation}<>
          \begin{split}
            <>
          \end{split}
        \end{equation}
      ]],
			{
				c(1, {
					sn(
						2, -- Decide si quieres poner label o no en la ecuación
						{
							t("\\label{eq:"),
							i(1),
							t("}"),
						}
					),
					t([[]]), -- Choose no label
				}, {}),
				i(2),
			}
		),
		{ condition = line_begin }
	),

	-- Ecuación a trozos con opción de escoger etiqueta
	s(
		{
			trig = "bcs",
			dscr = "Expande 'bcs' para abrir el entorno cases, pero con opción de poner labels",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{equation}<>
          <>  
          \begin{cases}
            <>
          \end{cases}
        \end{equation}
      ]],
			{
				c(1, {
					sn(
						2, -- Decide si quieres poner label o no en la ecuación
						{
							t("\\label{eq:"),
							i(1),
							t("}"),
						}
					),
					t([[]]), -- Choose no label
				}, {}),
				i(2),
				i(3),
			}
		),
		{ condition = line_begin }
	),

	-- Entorno para figuras simples
	s(
		{
			trig = "foofig",
			dscr = "Expande 'foofig' para abrir el entorno figure, con opciones",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{figure}<>
          \centering
          \includegraphics<>{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
      ]],
			{
				-- Campo [htbp] opcional
				c(1, {
					t([[]]), -- Opción 1, vacío
					t("[htbp]"), -- Opción 2, podrías convertirlo en snippet
				}, {}),
				-- Opciones para incluir las figuras
				c(2, {
					t([[]]), -- Opción 1, vacío
					sn(
						3, -- Opción 2, podrías convertirlo en snippet
						{
							t("[width="),
							i(1),
							t("\\textwidth]"),
						}
					),
				}, {}),
				i(3, "filename"),
				i(4, "text"),
				i(5, "label"),
			}
		),
		{ condition = line_begin }
	),

	-- Entorno para figuras múltiples
	s(
		{
			trig = "foo2fig",
			dscr = "Expande 'foo2fig' para abrir el entorno figure, con opciones",
			snippetType = "autosnippet",
		},
		fmta(
			[[
	      \begin{figure}<>
	        \centering
	        \begin{subcaptionblock}{<>}
	          \centering
	          \includegraphics<>{<>}
	          \caption{<>}\label{fig:<>}
	        \end{subcaptionblock}
	        \begin{subcaptionblock}{<>}
	          \centering
	          \includegraphics<>{<>}
	          \caption{<>}\label{fig:<>}
	        \end{subcaptionblock}
          \caption{<>}
          \label{fig:<>}
	      \end{figure}
	    ]],
			{
				-- Campo [htbp] opcional
				c(1, {
					t([[]]), -- Opción 1, vacío
					t("[htbp]"), -- Opción 2, podrías convertirlo en snippet
				}, {}),
				-- Opciones para incluir la figura izquierda
				i(2, "tamañocaja1"),
				c(3, {
					t([[]]), -- Opción 1, vacío
					sn(
						4, -- Opción 2, podrías convertirlo en snippet
						{
							t("[width="),
							i(1),
							t("\\textwidth]"),
						}
					),
				}, {}),
				i(4, "filename1"),
				i(5, "text1"),
				i(6, "label1"),
				-- Opciones para incluir la figura derecha
				i(7, "tamañocaja2"),
				c(8, {
					t([[]]), -- Opción 1, vacío
					sn(
						9, -- Opción 2, podrías convertirlo en snippet
						{
							t("[width="),
							i(2),
							t("\\textwidth]"),
						}
					),
				}, {}),
				i(9, "filename1"),
				i(10, "text1"),
				i(11, "label1"),
				i(12, "text"),
				i(13, "label"),
			}
		),
		{ condition = line_begin }
	),

	-- Entorno para tablas
	s(
		{
			trig = "footab",
			dscr = "Expande 'footab' para abrir el entorno table, con opciones",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{table}<>
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
				-- Campo [htbp] opcional
				c(1, {
					t([[]]), -- Opción 1, vacío
					t("[htbp]"), -- Opción 2, podrías convertirlo en snippet
				}, {}),
				i(2, "texto"),
				i(3, "label"),
				i(4, "columnas"),
				i(5),
				i(6),
			}
		),
		{ condition = line_begin }
	),

	-- Entorno para códigos
	s(
		{
			trig = "foocod",
			dscr = "Expande 'foocod' para abrir el entorno listings, con opciones",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{listing}<>
          \caption{<>}
          \inputminted[firstline=<>, lastline=<>]{<>}{Programas/<>}
          \label{cod:<>}
        \end{listing}
      ]],
			{
				-- Campo [htbp] opcional
				c(1, {
					t([[]]), -- Opción 1, vacío
					t("[htbp!]"), -- Opción 2, podrías convertirlo en snippet
				}, {}),
				i(2, "caption"),
				i(3, "inilinea"),
				i(4, "finlinea"),
				i(5, "lenguaje"),
				i(6, "nombre"),
				i(7, "label"),
			}
		),
		{ condition = line_begin }
	),
}

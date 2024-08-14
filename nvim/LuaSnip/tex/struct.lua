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

-- Return snippet tables
return {
	-- ANOTACIONES (comando personalizado para escribir razonamiento de ecuaciones y otras historias)
	s(
		{ trig = "ann", snippetType = "autosnippet" },
		fmta(
			[[
        \annotate{<>}{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
			}
		)
	),
	-- CITAR ENTRADA BIBLIOGRÁFICA
	s(
		{ trig = "XC", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
        \autocite{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- MENCIONAR ETIQUETAS DE FIGURAS, TABLAS Y CÓDIGOS
	s(
		{ trig = "XR", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
        \ref{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- MENCIONAR SECCIONES (utilizo el símbolo \S)
	s(
		{ trig = "XM", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
        \S\ref{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- MENCIONAR ECUACIONES (con eqref de la ams)
	s(
		{ trig = "XE", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
        \eqref{eq:<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- METER ECUACIONES EN CAJAS BONITAS (con \tcboxmath)
	s(
		{ trig = "tcb", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
        \tcboxmath{<>}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = tex.in_mathzone }
	),
	-- CLASE DEL DOCUMENTO
	s(
		{ trig = "dcc", snippetType = "autosnippet" },
		fmta(
			[=[
        \documentclass[<>]{<>}
      ]=],
			{
				i(1, "opciones"),
				i(2, "tipo"),
			}
		),
		{ condition = line_begin }
	),
	-- INVOCAR PAQUETE DE LATEX
	s(
		{ trig = "pack", snippetType = "autosnippet" },
		fmta(
			[[
        \usepackage{<>}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- INVOCAR PAQUETE DE LATEX (EN ARCHIVOS .CLS)
	s(
		{ trig = "qpack", snippetType = "autosnippet" },
		fmta(
			[[
        \RequirePackage{<>}
      ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- INCLUIR ARCHIVO EN LATEX
	s(
		{ trig = "inn", snippetType = "autosnippet" },
		fmta(
			[[
        \include{<>/<>}
      ]],
			{
				i(1, "Campo"),
				i(2, "Archivo"),
			}
		),
		{ condition = line_begin }
	),
	-- LABELS
	s(
		{ trig = "lbl", snippetType = "autosnippet" },
		fmta(
			[[
        \label{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- NUEVA ENTRADA GLOSARIO DE ACRÓNIMOS
	s(
		{ trig = "nac" },
		fmta(
			[[
        \newacronym{<>}{<>}{<>}
      ]],
			{
				i(1, "Atajo"),
				i(2, "Abreviatura"),
				i(3, "Descripción"),
			}
		),
		{ condition = line_begin }
	),
	-- ACRÓNIMO (forma compacta) EN EL TEXTO
	s(
		{ trig = "aks", snippetType = "autosnippet" },
		fmta(
			[[
        \acrshort{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- ACRÓNIMO (forma desarrollada) EN EL TEXTO
	s(
		{ trig = "akl", snippetType = "autosnippet" },
		fmta(
			[[
        \acrlong{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- ACRÓNIMO (forma completa) EN EL TEXTO
	s(
		{ trig = "akf", snippetType = "autosnippet" },
		fmta(
			[[
        \acrfull{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- CREAR CAJA CON ESPACIO EN BLANCO OCUPADO POR EL ARGUMENTO
	s(
		{ trig = "hpp", snippetType = "autosnippet" },
		fmta(
			[[
        \hphantom{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- ENTRECOMILLADO ESPAÑOL (comillas angulares), i.e. enquote
	s(
		{ trig = "cqq", snippetType = "autosnippet" },
		fmta(
			[[
        \enquote{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	s(
		{ trig = "nc" },
		fmta(
			[[
        \newcommand*{<>}{<>}
      ]],
			{
				i(1),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- UNIDADES FÍSICAS (del paquete siunitx)
	s(
		{ trig = "sii", snippetType = "autosnippet" },
		fmta([[\unit{<>}]], {
			i(1),
		})
	),
	-- MAGNITUD Y UNIDADES FÍSICAS (del paquete siunitx)
	s(
		{ trig = "qty", snippetType = "autosnippet" },
		fmta([[\qty{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	-- RANGO DE VALORES CON UNIDADES (del paquete siunitx)
	s(
		{ trig = "rqty", snippetType = "autosnippet" },
		fmta([[\qtyrange{<>}{<>}{<>}]], {
			i(1),
			i(2),
			i(3),
		})
	),
	-- RANGO DE VALORES SIN UNIDADES (del paquete siunitx)
	s(
		{ trig = "nrng", snippetType = "autosnippet" },
		fmta([[\numrange{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	-- URLs
	s(
		{ trig = "url" },
		fmta([[\url{<>}]], {
			d(1, get_visual),
		})
	),
	-- href con URL para seleccionar en modo visual
	s(
		{ trig = "LU", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			d(1, get_visual),
			i(2),
		})
	),
	-- href con texto para seleccionar en modo visual
	s(
		{ trig = "LL", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			i(1),
			d(2, get_visual),
		})
	),
	-- ESPACIO HORIZONTAL
	s(
		{ trig = "hss", snippetType = "autosnippet" },
		fmta([[\hspace{<>}]], {
			d(1, get_visual),
		})
	),
	-- ESPACIO VERTICAL
	s(
		{ trig = "vss", snippetType = "autosnippet" },
		fmta([[\vspace{<>}]], {
			d(1, get_visual),
		})
	),
	-- SECCIÓN
	s(
		{ trig = "h1", snippetType = "autosnippet" },
		fmta([[\section{<>}]], {
			d(1, get_visual),
		})
	),
	-- SUBSECCIÓN
	s(
		{ trig = "h2", snippetType = "autosnippet" },
		fmta([[\subsection{<>}]], {
			d(1, get_visual),
		})
	),
	-- SUBSUBSECCIÓN
	s(
		{ trig = "h3", snippetType = "autosnippet" },
		fmta([[\subsubsection{<>}]], {
			d(1, get_visual),
		})
	),
	-- PARAGRAPH
	s(
		{ trig = "h4", snippetType = "autosnippet" },
		fmta([[\paragraph{<>}]], {
			d(1, get_visual),
		})
	),
}

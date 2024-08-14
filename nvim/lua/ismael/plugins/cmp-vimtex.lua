-- nvim-cmp source providing bespoke support for Vimtex's omnifunc.
return {
	"micangl/cmp-vimtex",
	config = function()
    local cmpvtex = require("cmp_vimtex") -- import cmp-vimtex plugin safely
		cmpvtex.setup({
			additional_information = {
				info_in_menu = true,
				info_in_window = true,
				info_max_length = 60,
				match_against_info = true,
				symbols_in_menu = true,
			},
			bibtex_parser = {
				enabled = true,
			},
			search = {
				browser = "xdg-open",
				default = "google_scholar",
				search_engines = {
					google_scholar = {
						name = "Google Scholar",
						get_url = cmpvtex.url_default_format(
							"https://scholar.google.com/scholar?hl=en&q=%s"
						),
					},
					-- Pon otros motores de busqueda si quieres aquí debajo si quieres
          --
				},
			},
		})
	end,
}

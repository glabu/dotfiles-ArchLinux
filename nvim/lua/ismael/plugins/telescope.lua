-- A highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim", -- lua functions used by lots of plugins
		"nvim-telescope/telescope-bibtex.nvim", -- telescope extension for bibtex integration
		"debugloop/telescope-undo.nvim", -- telescope extension for visualizing your undo tree and fuzzy-search changes
		{
			"nvim-telescope/telescope-fzf-native.nvim", -- dependency for better sorting performance
			build = "make",
		},
		"nvim-tree/nvim-web-devicons", -- VS-Code like icons for the nvim-tree
	},
	config = function()
		local telscp = require("telescope") -- import telescope plugin safely
		local actions = require("telescope.actions") -- for conciseness
		telscp.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						-- ["<C-n>"] = actions.cycle_history_next,
						-- ["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						-- ["<C-x>"] = actions.select_horizontal,
						-- ["<C-v>"] = actions.select_vertical,
						-- ["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						-- ["<C-l>"] = actions.complete_tag,
						-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},
					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						-- ["<C-x>"] = actions.select_horizontal,
						-- ["<C-v>"] = actions.select_vertical,
						-- ["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["K"] = actions.move_to_top,
						-- ["M"] = actions.move_to_middle,
						["J"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
			load_extension = {
				"fzf",
				"yank_history",
				"bibtex",
				"lazygit",
			},
			extensions = {
				undo = {
					mappings = {
						i = {
							["<C-a>"] = require("telescope-undo.actions").yank_additions,
							["<C-d>"] = require("telescope-undo.actions").yank_deletions,
							["<C-u>"] = require("telescope-undo.actions").restore,
							-- ["<C-Y>"] = require("telescope-undo.actions").yank_deletions,
							-- ["<C-cr>"] = require("telescope-undo.actions").restore,
							-- alternative defaults, for users whose terminals do questionable things with modified <cr>
						},
						n = {
							["y"] = require("telescope-undo.actions").yank_additions,
							["Y"] = require("telescope-undo.actions").yank_deletions,
							["u"] = require("telescope-undo.actions").restore,
						},
					},
				},
				bibtex = {
					depth = 1,
					-- Depth for the *.bib file
					global_files = { "~/Library/texmf/bibtex/bib/Zotero.bib" },
					-- Path to global bibliographies (placed outside of the project)
					search_keys = { "author", "year", "title" },
					-- Define the search keys to use in the picker
					citation_format = "{{author}} ({{year}}), {{title}}.",
					-- Template for the formatted citation
					citation_trim_firstname = true,
					-- Only use initials for the authors first name
					citation_max_auth = 2,
					-- Max number of authors to write in the formatted citation
					-- following authors will be replaced by "et al."
					custom_formats = {
						{ id = "miformatonatbib", cite_marker = "\\autocite{%s}" },
					},
					-- Custom format for citation label
					format = "miformatonatbib",
					-- Format to use for citation label.
					-- Try to match the filetype by default, or use 'plain'
					context = true,
					-- Context awareness disabled by default
					context_fallback = true,
					-- Fallback to global/directory .bib files if context not found
					-- This setting has no effect if context = false
					wrap = false,
					-- Wrapping in the preview window is disabled by default
				},
			},
		})
	end,
}

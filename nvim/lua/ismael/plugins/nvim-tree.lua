-- A file explorer for neovim written in lua
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtr = require("nvim-tree") -- import nvim-tree plugin safely

		-- Las opciones recomendadas por la documentación de nvim-tree
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

    local HEIGHT_RATIO = 0.8 -- for the floating window height in view.float
    local WIDTH_RATIO = 0.5 -- for the floating window width in view.float

		local function on_attach(bufnr)
			local api = require("nvim-tree.api") -- for conciseness
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			-- custom mappings
			local keymap = vim.keymap -- for conciseness
			keymap.set("n", "<CR>", api.node.open.tab, opts("Open"))
			keymap.set("n", "<S-M>", api.node.show_info_popup, opts("Info"))
			keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			keymap.set("n", "l", api.node.open.edit, opts("Open"))
			keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
			keymap.set("n", "a", api.fs.create, opts("Create"))
			keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
			keymap.set("n", "d", api.fs.remove, opts("Delete"))
			keymap.set("n", "D", api.fs.trash, opts("Trash"))
			keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			keymap.set("n", "p", api.fs.paste, opts("Paste"))
			keymap.set("n", "O", api.node.navigate.parent, opts("Parent Directory"))
			keymap.set("n", "q", api.tree.close, opts("Close"))
			keymap.set("n", "r", api.fs.rename, opts("Rename"))
			keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			keymap.set("n", "o", api.node.run.system, opts("System Open"))
			keymap.set("n", "s", api.tree.search_node, opts("Search"))
			keymap.set("n", "v", api.node.open.vertical, opts("Vertical Split"))
			keymap.set("n", "x", api.fs.cut, opts("Cut"))
			keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		end

		-- configure nvim-tree
		nvimtr.setup({
			on_attach = on_attach,
			sort = {
				sorter = "name",
				folders_first = true,
				files_first = false,
			},
			view = {
				centralize_selection = false,
				cursorline = true,
				debounce_delay = 15,
				--side = "left",
				preserve_window_proportions = false,
        number = true,
				relativenumber = true,
				signcolumn = "yes",
				--width = 30,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = 0.5 * (screen_w - window_w)
            local center_y = (0.5 * (vim.opt.lines:get() - window_h)) - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              col = center_x,
              row = center_y,
              width = window_w_int,
              height = window_h_int
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				full_name = false,
				root_folder_label = ":t",
				indent_width = 2,
				special_files = {},
				symlink_destination = true,
				highlight_git = false,
				highlight_diagnostics = false,
				highlight_opened_files = "none",
				highlight_modified = "none",
				highlight_bookmarks = "none",
				highlight_clipboard = "name",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						item = "│ ",
						bottom = "─ ",
						none = " ",
					},
				},
				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},
					git_placement = "before",
					modified_placement = "after",
					diagnostics_placement = "signcolumn",
					bookmarks_placement = "signcolumn",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = false, -- enable this to activate the arrows next to folders
						git = true,
						modified = true,
						diagnostics = true,
						bookmarks = false,
					},
					glyphs = {
						default = "",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",
						folder = {
							arrow_open = "󰍝",
							arrow_closed = "󰍟",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "➜",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = {},
				update_cwd = true,
			},
			system_open = {
				cmd = "",
				args = {},
			},
			git = {
				enable = true,
				show_on_dirs = true,
				-- show_on_open_dirs = true,
				disable_for_dirs = {},
				timeout = 500,
				cygwin_support = false,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			modified = {
				enable = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			filters = {
				git_ignored = false,
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				no_bookmark = false,
				-- custom = { ".git" },
				-- custom = { ".DS_Store" },
				exclude = {},
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {},
			},
			actions = {
				open_file = {
					quit_on_open = true,
					eject = true,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				change_dir = {
					enable = false,
					global = false,
					restrict_above_cwd = false,
				},
				use_system_clipboard = true,
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			trash = {
				cmd = "gio trash",
			},
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			notify = {
				threshold = vim.log.levels.ERROR,
				absolute_path = true,
			},
			help = {
				sort_by = "key",
			},
			ui = {
				confirm = {
					remove = true,
					trash = true,
					default_yes = true,
				},
			},
			experimental = {},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})
	end,
}

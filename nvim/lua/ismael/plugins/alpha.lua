-- Fully programmable greater for nvim
return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- VS-Code like icons for the nvim-tree
		"Shatur/neovim-session-manager", -- manage sessions like folders in VSCode.
	},
	config = function()
		local alpha = require("alpha") -- import alpha plugin safely
		local dashboard = require("alpha.themes.dashboard") -- for conciseness

		-- Set header
		local logo = { -- for conciseness
			[[                                                    ]],
			[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
			[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
			[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
			[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
			[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
			[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
			[[                                                    ]],
		}
		dashboard.section.header.val = logo

		-- Set color
		dashboard.section.header.opts.hl = "Include" -- lookup other hl groups with :highlight

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("s", "  Sessions", "<cmd>SessionManager load_session<CR>"),
			dashboard.button("r", "󰈚  Recent", ":Telescope oldfiles <CR>"),
			dashboard.button("e", "󰱼  Explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "  Find", ":Telescope find_files <CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
			dashboard.button("i", "  Info", "<cmd>e ~/.config/CheatSheet.md<cr>"),
			dashboard.button("p", "  Plugins", "<cmd>Lazy<cr>"),
			dashboard.button("h", "  Checkhealth", "<cmd>checkhealth<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa!<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Set footer
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats() -- for conciseness
				local ms = (0.01 * math.floor(stats.startuptime * 100 + 0.5) ) -- for conciseness

				-- local now = os.date "%d-%m-%Y %H:%M:%S"
				local version = "   v" -- for conciseness
					.. vim.version().major
					.. "."
					.. vim.version().minor
					.. "."
					.. vim.version().patch
				-- local fortune = require "alpha.fortune"
				-- local quote = table.concat(fortune(), "\n")
				local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" -- for conciseness
        -- for conciseness
				local footer = version .. "\t" .. plugins -- .. "\n" .. quote 
				dashboard.section.footer.val = footer
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}

-- LSP
-- managing & installing lsp servers, linters & formatters
return {
	"williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
	ft = { "py", "html", "js", "ts", "lua" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- install or upgrade all of mason tools.
	},

	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- import mason-tool-installer
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "",
					package_pending = "",
					package_uninstalled = "",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- "html",
				-- "emmet_ls",
				"pyright",
				-- "texlab",
				-- "tsserver",
				-- "lua_ls",   -- there's something wrong with this server
				-- "cssls",
				-- "tailwindcss",
				-- "svelte"
				-- "graphql",
				-- "prismals",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same option as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- "prettier", -- ts/js formatter (prettier formatter seems to be required)
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				-- "eslint_d", -- js linter
			},
		})
	end,
}

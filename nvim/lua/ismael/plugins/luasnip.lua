-- Snippet engine for lua
return {
	"L3MON4D3/LuaSnip",
	event = { "BufReadPre", "BufNewFile" },
	version = "v2.*",
  build = "make install_jsregexp",
	config = function()
		vim.cmd([[
      " Expandir el Snippet con 'Tab'
      imap <silent><expr> <Tab> luasnip#expandable() ? "<Plug>luasnip-expand-snippet" : "<Tab>"

      " Salto hacia delante en los nodos del snippet
      imap <silent><expr> jk luasnip#jumpable(1) ? "<Plug>luasnip-jump-next" : "jk"
      smap <silent><expr> jk luasnip#jumpable(1) ? "<Plug>luasnip-jump-next" : "jk"

      " Salto hacia atras en los nodos del snippet 
      imap <silent><expr> <C-b> luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<C-j>"
      smap <silent><expr> <C-b> luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<C-j>"

      " Me muevo cíclicamente entre los nodos opcionales con Ctrl-f
      imap <silent><expr> <C-f> luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-f>"
      smap <silent><expr> <C-f> luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-f>"
    ]])
		---------------- Variables locales ----------------
		---------------------------------------------------
		local ls = require("luasnip") -- import the LuaSnip plugin safely
		local s = ls.snippet
		local sn = ls.snippet_node
		local isn = ls.indent_snippet_node
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local c = ls.choice_node
		local d = ls.dynamic_node
		local r = ls.restore_node
		local events = require("luasnip.util.events")
		local ai = require("luasnip.nodes.absolute_indexer")
		local fmt = require("luasnip.extras.fmt").fmt
		local m = require("luasnip.extras").m
		local lambda = require("luasnip.extras").l
		local postfix = require("luasnip.extras.postfix").postfix
		-----------------------------------------------

		ls.config.set_config({
			-- Don't store snippet history for less overhead
			history = false,
			-- Allow autotrigger snippets
			enable_autosnippets = true,
			-- For equivalent of UltiSnips visual selection
			store_selection_keys = "<Tab>",
			-- Event on which to check for exiting a snippet's region
			region_check_events = "InsertEnter",
			delete_check_events = "InsertLeave",
		})

    require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

    vim.keymap.set("", "<S-R>", '<Cmd>lua require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})<CR><Cmd>echo "Snippets refreshed!"<CR>')
	end,
}



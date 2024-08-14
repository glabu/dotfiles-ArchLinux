-- Para evitar una repetición excesiva de la función get_visual en los snippets
local M = {}

-- Abreviaciones de los nodos de LuaSnip
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.get_visual(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else
		return sn(nil, i(1, ""))
	end
end

return M

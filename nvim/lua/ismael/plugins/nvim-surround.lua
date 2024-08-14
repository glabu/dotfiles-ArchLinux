-- Surround selections easily and with style
return {
	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = function()
    local srr = require("nvim-surround")
		srr.setup({
			keymaps = {
				insert = false,
				insert_line = false,
				normal = false,
				normal_cur = false,
				normal_line = false,
				normal_cur_line = false,
				visual = "<S-s>",
				visual_line = false,
				delete = false,
				change = false,
			},
			aliases = {
				["a"] = false,
				["b"] = false,
				["B"] = false,
				["r"] = false,
				["q"] = false,
				["s"] = false,
			},
		})
	end,
}

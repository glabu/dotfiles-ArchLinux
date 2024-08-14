-- Smart and powerful commenting plugin for Neovim
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- A Neovim plugin for setting the commentstring option based on the cursor location in the file. The location is checked via treesitter queries.
	},
	config = function()
		local comment = require("Comment") -- import comment plugin safely
		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim") -- for conciseness
		-- enable comment
		comment.setup({
			--Add a space b/w comment and the line
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = nil,
			---Function to call before (un)comment
			pre_hook = ts_context_commentstring.create_pre_hook(), -- for commenting tsx and jsx files
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = false,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = false,
			},
		})
	end,
}

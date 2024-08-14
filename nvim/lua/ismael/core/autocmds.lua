local api = vim.api

-- Cierro las ventanas help, man, qf, lspinfo con 'q'
api.nvim_create_autocmd("FileType", {
	pattern = { "man", "help", "qf", "lspinfo" }, -- "startuptime",auto
	command = "nnoremap <buffer><silent> q :close<CR>",
})

-- Terminal mappings
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-c>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = { "term://*" }, -- use term://*toggleterm#* for only ToggleTerm
	command = "lua set_terminal_keymaps()",
})

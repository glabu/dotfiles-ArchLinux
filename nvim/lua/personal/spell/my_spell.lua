vim.opt.spelllang = "es_es" -- Español de España como opción base

vim.b.SPELL_ESPAÑOL = true -- Variable binaria para cambiar entre diccionarios

function ToggleSpanishSpell()
	if vim.b.SPELL_ESPAÑOL then -- si Español es la opción activa, cambia a Inglés
		vim.opt.spelllang:remove("es_es")
		vim.opt.spelllang:append("en_gb")
		vim.b.SPELL_ESPAÑOL = false
	else -- si Inglés es la opción activa, cambia a Español
		vim.opt.spelllang:remove("en_gb")
		vim.opt.spelllang:append("es_es")
		vim.b.SPELL_ESPAÑOL = true
	end
end

-- Atajos de teclado para activar/desactivar el spell checker de NeoVim
vim.keymap.set("n", "<S-S>", "<Cmd>set spell!<CR>") -- Activo 'spell', i.e. vim.opt.spell = "true"
vim.keymap.set("n", "<S-T>", ToggleSpanishSpell) -- Cambio entre el diccionario español e inglés
--vim.keymap.set("n", "<Leader>zz", "<Cmd>set spell!<CR>") -- Activo 'spell', i.e. vim.opt.spell = "true"
--vim.keymap.set("n", "<Leader>zs", ToggleSpanishSpell) -- Cambio entre el diccionario español e inglés

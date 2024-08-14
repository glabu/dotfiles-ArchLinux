local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- NOTE Check mapping with :verbose map ____

-- Set 'space' space as leader key 
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "


-------------------- General Keymaps --------------------

-- delete single character without copying into register
-- keymap("n", "x", '"_x', opts)
-- keymap("v", "p", '"_p', opts)

-- Elimino mappings
keymap("n", "<C-z>", "<nop>", opts)
keymap("n", "gc", "<nop>", opts)
keymap("n", "gcc", "<nop>", opts)

-- Gramática
vim.keymap.set("n", "<C-s>", function()
  require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
      previewer = false,
      layout_config = {
        width = 50,
        height = 15,
      }
    })
  )
end, { remap = true })

-- Elimino el resaltado de las búsquedas
keymap("n", "<CR>", "<cmd>noh<CR>", opts)

-- Buscar archivos del proyecto
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { remap = true })

-- Activar comentarios
keymap('n', '<C-Bslash>', '<Plug>(comment_toggle_linewise_current)', opts)
keymap('x', '<C-Bslash>', '<Plug>(comment_toggle_linewise_visual)', opts)

-- Abrir la ventana de ayuda sobre una palabra
keymap("n", "<S-m>", ':execute "help " . expand("<cword>")<cr>', opts)

-- Arreglo 'Y', 'E'
keymap("n", "Y", "y$", opts)
keymap("n", "E", "ge", opts)
keymap("v", "Y", "y$", opts)

-- Centrar el cursor
keymap("n", "m", "zt", opts)
keymap("v", "m", "zt", opts)

-- Moverse entra las ventanas y opciones
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Ajustar tamaño con las flechas
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Navegar entre buffers (con BS y TAB hacia atras y hacia delante)
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)
keymap("n", "<BS>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<S-BS>", ":BufferLineMovePrev<CR>", opts)

-- Arrastrar líneas
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", ":m'>+<CR>gv", opts)
keymap("v", "<A-k>", ":m-2<CR>gv", opts)

-- Movimiento en vertical en una línea (cuando la "línea" del código ocupa muchas líneas del display)
keymap("n", "<c-u>", "<c-u>zz", opts)
keymap("n", "<c-d>", "<c-d>zz", opts)

-- Movimiento en horizontal en una línea (cuando la "línea" del código ocupa muchas líneas del display)
keymap("v", "<S-h>", "g^", opts)
keymap("v", "<S-l>", "g$", opts)
keymap("n", "<S-h>", "g^", opts)
keymap("n", "<S-l>", "g$", opts)

-- Sangrados
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", "<", "<S-v><<esc>", opts)
keymap("n", ">", "<S-v>><esc>", opts)

-- Para navegar entre las líneas de display en vertical
keymap("n", "J", "gj", opts)
keymap("n", "K", "gk", opts)
keymap("v", "J", "gj", opts)
keymap("v", "K", "gk", opts)








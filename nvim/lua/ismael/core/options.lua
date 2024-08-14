-----------------------------------------------------------
-- Configuración general y opciones de NeoVim
-----------------------------------------------------------

-- Las opciones por defecto he intentado no incluirlas
-- Ver: https://neovim.io/doc/user/vim_diff.html
-- [2] Predeterminadas - *nvim-defaults*

local g = vim.g -- Variables globales
local opt = vim.opt -- Opciones (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.encoding = "utf-8" -- Just in case
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.completeopt = "menuone,noselect" -- Autocomplete options
opt.swapfile = false -- Don't use swapfile
opt.hlsearch = true -- Highlight all matches on previous search pattern

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.relativenumber = true -- Set relative numbered lines
opt.cursorline = true -- Highlight the current line
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.numberwidth = 4 -- Set number column width to 4 {default 4}
opt.scrolloff = 7 -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 7 -- Minimal number of screen columns either side of cursor if wrap is `false`
opt.pumheight = 10 -- Pop up menu height
opt.cmdheight = 2 -- More space in the neovim command line for displaying messages

opt.signcolumn = "yes" -- Show the sign column, otherwise it would shift the text each time
opt.showmode = false -- Do not show the --INSERT-- or any mode messages anymore
opt.wrap = true -- Display lines as one long line
opt.linebreak = true -- Wrap on word boundary
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.undofile = true -- Enable persistent undo
opt.termguicolors = true -- Sets terminal GUI colors (any terminal should support this)

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.shiftwidth = 2 -- Shift 4 spaces when tab
opt.tabstop = 2 -- 1 tab == 2 spaces
opt.showtabline = 2 -- Always show tabs
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = false -- Autoindent new lines
opt.breakindent = true -- Tab wrapped lines
opt.showbreak = "  " -- Set indent of wrapped lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.updatetime = 300 -- Time to wait for trigger an event (in milliseconds)
opt.timeoutlen = 100 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.backup = false -- Creates a backup file
opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-----------------------------------------------------------
-- LaTeX global options (ver vimtex.lua)
-----------------------------------------------------------
g.tex_flavor = "latex"
g.tex_indent_items = 0 -- Turn off enumerate indent
g.tex_indent_brace = 0 -- Turn off brace indent

-----------------------------------------------------------
-- Prelude
-----------------------------------------------------------
opt.shortmess:append("c") -- Don't pass messages to |ins-completion-menu|

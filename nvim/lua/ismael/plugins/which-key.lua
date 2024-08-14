-- WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    defaults = {},
    spec = {
      {
        -- Nested mappings are allowed and can be added in any order
        -- Most attributes can be inherited or overridden on any level
        -- There's no limit to the depth of nesting
        mode = { "n", "v" }, -- NORMAL and VISUAL mode
        -------------------
        -- MAIN MAPPINGS --
        -------------------
        { "<leader>b", "<cmd>VimtexCompile<CR>", desc = "Build", icon = {icon = "", color = "green" } }, -- vimtex build mapping
        { "<leader>c", "<cmd>vert sb<CR>", desc = "Create split", icon = { icon = "", color = "blue" } }, -- vertical split mapping
        { "<leader>d", "<cmd>update! | bdelete!<CR>", desc = "Delete buffer", icon = { icon = "", color = "green" } }, -- delete buffer mapping
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer", icon = { icon = "󰙅", color = "orange" } }, -- nvim-tree mapping
        { "<leader>i", "<cmd>VimtexTocOpen<CR>", desc = "Index", icon = {icon = "", color = "green" } }, -- vimtex index mapping
        { "<leader>j", "<cmd>clo<CR>", desc = "Drop split", icon = { icon = "", color = "blue" } }, -- drop split mapping
        { "<leader>k", "<cmd>on<CR>", desc = "Max split", icon = { icon = "", color = "blue" } }, -- maximize split mapping
        { "<leader>q", "<cmd>wa! | qa!<CR>", desc = "Quit", icon = { icon = "󰈆", color = "red"} }, -- exit mapping
        { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo", icon = { icon = "", color = "yellow" } }, -- undo mapping
        { "<leader>v", "<cmd>VimtexView<CR>", desc = "View", icon = { icon = "", color = "green" } }, -- vimtex view mapping
        { "<leader>w", "<cmd>wa!<CR>", desc = "Write", icon = { icon = "", color = "azure"} }, -- write mapping
        --- ACTION MAPPINGS
        { "<leader>a", group = "ACTIONS", icon = {icon = "󰩕", color = "purple" } },
        { "<leader>aa", "<cmd>lua PdfAnnots()<CR>", desc = "annotate" },
        { "<leader>ab", "<cmd>terminal bibexport -o %:p:r.bib %:p:r.aux<CR>", desc = "bib export" },
        { "<leader>ac", "<cmd>:VimtexClearCache All<CR>", desc = "clear vimtex", icon = {icon = "", color = "green" } },
        { "<leader>ag", "<cmd>e ~/config/nvim/templates/Glosario.tex<CR>", desc = "edit glossary", icon = {icon = "", color = "green" } },
        --- EDIT SNIPPETS MAPPINGS ---
        { "<leader>ae", group = "EDIT SNIPPETS", icon = { icon = "", color = "blue" } },
        { "<leader>aea", "<cmd>e ~/.config/nvim/LuaSnip/all.lua<CR>", desc = "all.lua" },
        { "<leader>aed", "<cmd>e ~/.config/nvim/LuaSnip/tex/delimiters.lua<CR>", desc = "delimiters.lua" },
        { "<leader>aee", "<cmd>e ~/.config/nvim/LuaSnip/tex/environments.lua<CR>", desc = "environments.lua" },
        { "<leader>aef", "<cmd>e ~/.config/nvim/LuaSnip/tex/fonts.lua<CR>", desc = "fonts.lua" },
        { "<leader>aeg", "<cmd>e ~/.config/nvim/LuaSnip/tex/greek.lua<CR>", desc = "greek.lua" },
        { "<leader>ael", "<cmd>e ~/.config/nvim/LuaSnip/tex/mathopt.lua<CR>", desc = "opten.lua" },
        { "<leader>aem", "<cmd>e ~/.config/nvim/LuaSnip/tex/math.lua<CR>", desc = "math.lua" },
        { "<leader>aes", "<cmd>e ~/.config/nvim/LuaSnip/tex/static.lua<CR>", desc = "static.lua" },
        { "<leader>aet", "<cmd>e ~/.config/nvim/LuaSnip/tex/struct.lua<CR>", desc = "struct.lua" },
        ------------------------------
        { "<leader>af", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "format" },
        --- { "<leader>ah", "<cmd>lua _HTOP_TOGGLE()<CR>", , desc = "htop" },
        { "<leader>ah", "<cmd>LocalHighlightToggle<CR>", desc = "highlight" },
        { "<leader>ak", "<cmd>VimtexClean<CR>", desc = "kill aux", icon = {icon = "", color = "green" } },
        { "<leader>ap", "<cmd>TermExec cmd='python %:p:r.py'<CR>", desc = "python", icon = { icon = "", color = "yellow" } },
        { "<leader>ar", "<cmd>VimtexErrors<CR>", desc = "report errors", icon = {icon = "", color = "green" } },
        { "<leader>as", "<cmd>TermExec cmd='ssh -X ismael@138.100.75.50<CR>", desc = "ssh", icon = { icon = "󰣀", color = "red"} },
        { "<leader>au", "<cmd>cd %:p:h<CR>", desc = "update cwd" },
        { "<leader>av", "<plug>(vimtex-context-menu)", desc = "vimtex menu", icon = {icon = "", color = "green" } },
        { "<leader>aw", "<cmd>VimtexCountWords!<CR>", desc= "word count", icon = {icon = "", color = "green" } },
        -- { "<leader>aw", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>", desc = "word"},
        -- { "<leader>as", "<cmd>lua function() require('cmp_vimtex.search').search_menu() end<CR>", desc = "search citations" },
        -- FIND MAPPINGS
        { "<leader>f", group = "FIND", icon = { icon = "", color = "yellow" } },
        { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", desc = "buffers" },
        { "<leader>fc", "<cmd>Telescope bibtex format_string=\\autocite{%s}<CR>", desc = "citations", icon = {icon = "", color = "green" } },
        { "<leader>ff", "<cmd>Telescope live_grep theme=ivy<CR>", desc = "project" },
        { "<leader>fg", "<cmd>Telescope git_commits<CR>", desc = "git history", icon = { icon = "", color = "orange" } },
        -- { "<leader>fg", "<cmd>Telescope git_branches<CR>", desc = "branches" },
        { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "help" },
        { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "keymaps" },
        -- { "<leader>fm", "<cmd>Telescope man_pages<CR>", desc = "man pages" },
        { "<leader>fr", "<cmd>Telescope registers<CR>", desc = "registers" },
        { "<leader>ft", "<cmd>Telescope colorscheme<CR>", desc = "theme" },
        { "<leader>fw", "<cmd>lua SearchWordUnderCursor()<CR>", desc = "word" },
        { "<leader>fy", "<cmd>YankyRingHistory<CR>", desc = "yanks" },
        -- ARCH LINUX MAPPINGS
        --{ "<leader>F", group = "ARCH" },
        --{ "<leader>Fd", "<cmd>TermExec cmd='sudo develop'<CR><C-w>j", desc = "develop" },
        --{ "<leader>Fg", "<cmd>TermExec cmd='sudo-collect-garbage --delete-older-than 15d'<CR><C-w>j", desc = "garbage" },
        --{ "<leader>Fh", "<cmd>TermExec cmd='home-manager switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "home-manager" },
        --{ "<leader>Fm", "<cmd>TermExec cmd='brave https://mynixos.com' open=0<CR>", desc = "my-fedora" },
        --{ "<leader>Fp", "<cmd>TermExec cmd='brave https://search.fedora.org/packages' open=0<CR>", desc = "packages" },
        --{ "<leader>Fr", "<cmd>TermExec cmd='sudo rebuild switch --flake ~/.dotfiles/'<CR><C-w>l", desc = "rebuild flake" },
        --{ "<leader>Fu", "<cmd>TermExec cmd='sudo flake update'<CR><C-w>j", desc = "update" },
        -- GIT MAPPINGS
        { "<leader>g", group = "GIT", icon = { icon = "", color = "orange" } },
        { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "checkout branch" },
        -- { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "diff" },
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "lazygit" },
        -- { "<leader>gh", "<cmd>Gitsigns hunk_history<CR>", desc = "hunk history" },
        { "<leader>gj", "<cmd>Gitsigns next_hunk<CR>", desc = "next hunk" },
        { "<leader>gk", "<cmd>Gitsigns prev_hunk<CR>", desc = "prev hunk" },
        { "<leader>gl", "<cmd>Gitsigns blame_line<CR>", desc = "line blame" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "preview hunk" },
        { "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "toggle blame" },
        -- LIST MAPPINGS
        { "<leader>L", group = "LIST", icon = { icon = "", color = "azure" } },
        { "<leader>Lc", "<cmd>lua HandleCheckbox()<CR>", desc = "checkbox" },
        { "<leader>Ln", "<cmd>AutolistCycleNext<CR>", desc = "next" },
        { "<leader>Lp", "<cmd>AutolistCyclePrev<CR>", desc = "previous" },
        { "<leader>Lr", "<cmd>AutolistRecalculate<CR>", desc = "reorder" },
        -- LSP MAPPINGS
        { "<leader>l", group = "LSP", icon = { icon = "", color = "purple" } },
        { "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "buffer diagnostics" },
        { "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code action" },
        { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "declaration" },
        { "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", desc = "definition" },
        { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "help" },
        { "<leader>li", "<cmd>Telescope lsp_implementations<CR>", desc = "implementations" },
        { "<leader>lk", "<cmd>LspStop<CR>", desc = "kill lsp" },
        { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "line diagnostics" },
        { "<leader>ln", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "next diagnostic" },
        { "<leader>lp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "previous diagnostic" },
        { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "rename" },
        { "<leader>lr", "<cmd>Telescope lsp_references<CR>", desc = "references" },
        { "<leader>ls", "<cmd>LspRestart<CR>", desc = "restart lsp" },
        { "<leader>lt", "<cmd>LspStart<CR>", desc = "start lsp" },
        -- MARKDOWN MAPPINGS
        { "<leader>m", group = "MARKDOWN", icon = { icon = "", color = "grey" } },
        { "<leader>mv", "<cmd>Slides<CR>", desc = "view slides" },
        -- PANDOC MAPPINGS
        { "<leader>p", group = "PANDOC", icon = { icon = "󱁥", color = "purple" } },
        { "<leader>ph", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.html'<CR>", desc = "html" },
        { "<leader>pl", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.tex'<CR>", desc = "latex" },
        { "<leader>pm", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.md'<CR>", desc = "markdown" },
        { "<leader>pp", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.pdf' open=0<CR>", desc = "pdf" },
        { "<leader>pv", "<cmd>TermExec cmd='skim %:p:r.pdf &' open=0<CR>", desc = "view" },
        { "<leader>pw", "<cmd>TermExec cmd='pandoc %:p -o %:p:r.docx'<CR>", desc = "word" },
        -- SESSIONS MAPPINGS
        { "<leader>S", group = "SESSIONS", icon = { icon = "", color = "azure"} },
        { "<leader>Sd", "<cmd>SessionManager delete_session<CR>", desc = "delete" },
        { "<leader>Sl", "<cmd>SessionManager load_session<CR>", desc = "load" },
        { "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", desc = "save" },
        -- SURROUND MAPPINGS
        { "<leader>s", group = "SURROUND", icon = { icon = "󰗅", color = "red" } },
        { "<leader>sc", "<Plug>(nvim-surround-change)", desc = "change" },
        { "<leader>sd", "<Plug>(nvim-surround-delete)", desc = "delete" },
        { "<leader>ss", "<Plug>(nvim-surround-normal)", desc = "surround" },
        -- OPEN TEMPLATE MAPPINGS 
        { "<leader>t", group = "TEMPLATES", icon = { icon = "", color = "green" } },
        { "<leader>tb", "<cmd>read ~/.config/nvim/templates/plantilla_beamer1.tex<CR>", desc = "plantilla_beamer1.tex" },
        { "<leader>tc", "<cmd>read ~/.config/nvim/templates/plantilla_beamer2.tex<CR>", desc = "plantilla_beamer2.tex" },
        { "<leader>td", "<cmd>read ~/.config/nvim/templates/plantilla_beamer3.tex<CR>", desc = "plantilla_beamer3.tex" },
        { "<leader>tl", "<cmd>read ~/.config/nvim/templates/isma_beamer.tex<CR>", desc = "isma_beamer.tex" },
        { "<leader>tp", "<cmd>read ~/.config/nvim/templates/informes.tex<CR>", desc = "informes.tex" },
        { "<leader>tr", "<cmd>read ~/.config/nvim/templates/troubleshooting.tex<CR>", desc = "troubleshooting.tex" },
        { "<leader>ts", "<cmd>read ~/.config/nvim/templates/isma_tikz.tex<CR>", desc = "isma_tikz.tex" },
      },
    },
    triggers = { -- manually set up the triggers
      { "<leader>", mode = { "n", "v" } },
    },
    plugins = {
      marks = false,        -- shows a list of your marks on ' and `
      registers = false,    -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = false,    -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 10,   -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false,      -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false,      -- default bindings on <c-w>
        nav = false,          -- misc bindings to work with windows
        z = false,            -- bindings for folds, spelling and others prefixed with z
        g = false,            -- bindings for prefixed with g
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
      },
    },
    win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = true,
      -- height = { min = 4, max = 25 }, -- min and max height of the columns
      -- width = 1,
      -- col = 0,
      -- row = math.huge,
      border = "rounded",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- { "<Space>", "SPC" },
      -- { "<CR>", "RET" },
      -- { "<Tab>", "TAB" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      -- set to false to disable all mapping icons,
      -- both those explicitely added in a mapping
      -- and those from rules
      mappings = true,
      -- Set to `false` to disable keymap icons from rules
      rules = {},
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line,
    -- Disable the WhichKey popup for certain buf types and file types.
    -- disabled by default for Telescope
    disable = {
      ft = {},
      bt = {},
    },
    debug = false,
  },
}

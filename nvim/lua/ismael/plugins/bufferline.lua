-- A bufferline with tabpage integration for Neovim using built-in lua
return {
	"akinsho/bufferline.nvim",
	dependencies = {
    "nvim-tree/nvim-web-devicons", -- VS-Code like icons for the nvim-tree
    "catppuccin",
  },
	version = "*",
	config = function()
		local bff = require("bufferline") -- import bufferline plugin safely
		bff.setup({
      options = {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        diagnostics = false, -- OR: | "nvim_lsp"
        diagnostics_update_in_insert = false,
        show_tab_indicators = false,
        show_close_icon = false,
        -- numbers = "ordinal", -- Display buffer numbers as ordinal numbers
        sort_by = "insert_at_end", -- OR: 'insert_after_current' | 'tabs' | 'extension' | 'relative_directory' | 'directory' | 'id' |
        -- sort_by = function(buffer_a, buffer_b)
        -- --   -- add custom logic
        --   return buffer_a.ordinal < buffer_b.ordinal
        -- end,
        offsets = {
          {
            filetype = "NvimTree",
            -- text = "Explorer",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            separator = "", -- use a "true" to enable the default, or set your own character
            -- padding = 1
          },
        },
        hover = {
          enabled = true,
          delay = 30,
          reveal = { "close" },
        },
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          desc = "disable tabline for alpha",
          callback = function()
            vim.opt.showtabline = 0
          end,
        }),
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          desc = "enable tabline after alpha",
          callback = function()
            vim.opt.showtabline = 2
          end,
        }),
      },
    })
	end,
}

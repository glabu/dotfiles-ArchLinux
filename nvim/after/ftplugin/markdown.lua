-- import surround plugin safely
local surround_buffer_ok, nvim_surround_tex = pcall(require, "nvim-surround")
if not surround_buffer_ok then
  return
end

nvim_surround_tex.buffer_setup({
  surrounds = {
    -- ["e"] = {
    --   add = function()
    --     local env = require("nvim-surround.config").get_input ("Environment: ")
    --     return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
    --   end,
    -- },
    ["b"] = {
      add = { "**", "**" },
      find = "**.-**",
      delete = "^(**)().-(**)()$",
    },
    ["i"] = {
      add = { "_", "_" },
      find = "_.-_",
      delete = "^(_)().-(_)()$",
    },
  },
})

-- prevents markdown from changing tabs to 4 spaces
-- vim.g.markdown_recommended_style = 0

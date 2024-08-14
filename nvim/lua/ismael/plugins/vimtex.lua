-- My configuration of the VimTeX plugin
-- VimTeX is a modern Vim and Neovim filetype and syntax plugin for LaTeX files.
return {
	"lervag/vimtex",
	lazy = false, -- We do not want to lazy load VimTeX since it already uses autoload mechanisms
	init = function()
		-- PDF Viewer (Skim):
		vim.g.vimtex_view_method = "skim"

		-- PDF Viewer (Skim) for viewing a citation .pdf file
		vim.g.vimtex_context_pdf_viewer = "skim"

		-- Do not auto open quickfix on compile erros
		vim.g.vimtex_quickfix_mode = 0

		-- Auto Indent
		vim.g.vimtex_indent_enabled = 0
		vim.g.tex_indent_items = 0 -- turn off enumerate indent
		vim.g.tex_indent_brace = 0 -- turn off brace indent

		-- Ignore mappings
		vim.g.vimtex_mappings_enabled = 0

		-- Don't open quickfix for warning messages if no errors are present
		vim.g.vimtex_quickfix_open_on_warning = 0

		-- Disable syntax conceal
		vim.g.vimtex_syntax_conceal_disable = 1

		-- Default is 500 lines and gave me lags on missed key presses
		vim.g.vimtex_delim_stopline = 50

		-- Ignorar en el .log los siguientes avisos (warnings):
		vim.g.vimtex_log_ignore = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}

		-- Don't automatically open PDF viewer after first compilation
		vim.g.vimtex_view_automatic = 0

		-- The latexmk compiler options and operation modes
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "_auxfiles",
			callback = 1,
			continuous = 0, -- OR: 1 for continuous mode compilation
			executable = "latexmk",
			hooks = {},
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}
		vim.g.vimtex_compiler_latexmk_engine = {
			_ = "-lualatex",
		}

		-- Toggles shell escape on an off when using minted package
		---------------------------------------------
		-- Toggles shell escape compilation on and off
		--vim.cmd([[function! s:TexToggleShellEscape() abort
    --  if g:vimtex_compiler_latexmk.options[0] ==# "-shell-escape"
    --    " Disable shell escape
    --    call remove(g:vimtex_compiler_latexmk.options, 0)
    --  else
    --    " Enable shell escape
    --    call insert(g:vimtex_compiler_latexmk.options, "-shell-escape", 0)
    --  endif
    --  VimtexReload
    --  VimtexClean
    --endfunction

    --nmap <leader>te <Plug>TexToggleShellEscape
    --nnoremap <script> <Plug>TexToggleShellEscape <SID>TexToggleShellEscape
    --nnoremap <SID>TexToggleShellEscape :call <SID>TexToggleShellEscape()<CR>
    --]])

		---- When loading new buffers, search for references to minted package in the
		---- document preamble and enable shell escape if minted is detected.
		--vim.cmd([[silent execute "!head -n 20 " . expand("%") . ' | grep "minted" > /dev/null'
    --if ! v:shell_error  " 'minted' found in preamble
    --  call insert(g:vimtex_compiler_latexmk.options, "-shell-escape", 0)
    --endif
    --]])
		---------------------------------------------

		-- Close viewers when VimTeX buffers are closed (see :help vimtex-events)
		vim.cmd([[ function! CloseViewers()
      if executable("xdotool")
        \ && exists("b:vimtex.viewer.xwin_id")
        \ && b:vimtex.viewer.xwin_id > 0
        call system("xdotool windowclose ". b:vimtex.viewer.xwin_id)
      endif
    endfunction

    augroup vimtex_event_close
      au!
      au User VimtexEventQuit call CloseViewers()
    augroup END
    ]])
	end,
}

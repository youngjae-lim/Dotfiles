vim.api.nvim_exec(
	[[
    augroup Treat_jet_To_html
      autocmd!
      autocmd BufRead, BufNewFile *.jet set filetype=html
    augroup end
  ]],
	false
)

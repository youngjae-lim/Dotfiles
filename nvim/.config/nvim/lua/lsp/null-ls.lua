local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
	debug = false,
	sources = {
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/prettier.lua
		formatting.prettier.with {
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		},
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/black.lua
		formatting.black.with { extra_args = { "--fast" } },
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/stylua.lua
		formatting.stylua,
		formatting.rustfmt,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			-- Save on format
			vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
		end
	end,
}

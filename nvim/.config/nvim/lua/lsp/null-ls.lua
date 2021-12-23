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
	-- TODO: Add corresponding formatters(linters) and diagnostics to the language servers installed!
	sources = {
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/prettier.lua
		formatting.prettier.with {
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		},

		-- Python
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/black.lua
		formatting.black.with { extra_args = { "--fast" } },

		-- Lua
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/stylua.lua
		formatting.stylua,
		diagnostics.luacheck.with { extra_args = { "--globals vim hs" } },

		-- Rust
		formatting.rustfmt,

		-- Go
		formatting.gofmt,

		-- Shell
		formatting.shfmt,
		diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			-- Save on format
			vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
		end
	end,
}

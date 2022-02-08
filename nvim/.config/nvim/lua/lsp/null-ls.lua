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
		------------------------------------------------------------------------
		-- Make sure you install all of the corresponding formatter and linters
		-- in your machine and make them available in your PATH.
		------------------------------------------------------------------------

		-- Javascript
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/prettier.lua
		-- TODO: I would like to use prettierd for fast formatting, but currently it doesn't support passing args. https://github.com/fsouza/prettierd/issues/237
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
		-- diagnostics will be done by pyright language server.
		formatting.black.with { extra_args = { "--fast" } },

		-- Lua
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/formatting/stylua.lua
		formatting.stylua,
		diagnostics.luacheck.with { extra_args = { "--globals vim hs" } },

		-- Rust
		formatting.rustfmt,

		-- Go
		formatting.gofmt,
		diagnostics.golangci_lint,

		-- Shell
		formatting.shfmt,
		diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

		-- Markdown
		-- Make sure you install https://github.com/igorshubovych/markdownlint-cli
		-- formatting.markdownlint,
		-- diagnostics.markdownlint, -- grammarly language server will be supporting markdown as well
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			-- Save on format
			vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
		end
	end,
}

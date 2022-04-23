local M = {}

-- TODO: backfill this to template
-- setup function will be called by inin.lua
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = { active = signs },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	-- Configure diagnostic options globally
	vim.diagnostic.config(config)

	-- lsp-handlers are functions with special signatures that are designed to handle
	-- responses and notifications from LSP servers.
	-- The vim.lsp.handlers table defines default handlers used
	-- when creating a new client. Keys are LSP method names:
	-- :lua print(vim.inspect(vim.tbl_keys(vim.lsp.handlers)))
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

-- Add functionality of highlighting document for the current text position.
-- Note that not all colorschemes are supporting this feature.
local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

-- TODO: do I really need thses extra redundant keybindings?
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Attach 'format on save' functionality for the servers that are not part of null-ls
local function lsp_format_on_save(client)
	if client.resolved_capabilities.document_formatting then
		-- Save on format
		vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
	end
end

-- Callback (client, bufnr) invoked when client attaches to a buffer
M.on_attach = function(client, bufnr)
	-- TODO: if statement will be getting longer in the future as formatters are reduntant in some of language servers and null-ls. So I need to think about how to make this more pretty and efficient. Or I could just default to false for all servers, so that null-ls acts as a default diagnostic and formatting tools.
	if
		client.name == "tsserver"
		or client.name == "jsonls"
		or client.name == "rust_analyzer"
		or client.name == "gopls"
		or client.name == "html"
		or client.name == "sumneko_lua"
		or client.name == "intelephense"
	then
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
		-- null-ls will take care of formatting any languages included in tsserver
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
	lsp_highlight_document(client)
	lsp_keymaps(bufnr)
	lsp_format_on_save(client)
end

-- Map overriding the default capabilities defined by vim.lsp.protocol.make_client_capabilities(),
-- passed to the language server on initialization.
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- for emmet_ls server: https://github.com/aca/emmet-ls#configuration
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M

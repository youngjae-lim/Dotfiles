local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	----------------------------------------------------------------
	-- Feel free to add any customized settings for each language --
	----------------------------------------------------------------
	-- intelephense for php
	if server.name == "intelephense" then
		local intelephense_opts = require "lsp.settings.intelephense"
		opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
	end

	-- jsonls
	if server.name == "jsonls" then
		local jsonls_opts = require "lsp.settings.jsonls"
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	-- Lua
	if server.name == "sumneko_lua" then
		local luadev_opts = require("lsp.settings.lua-dev").luadev
		opts = vim.tbl_deep_extend("force", luadev_opts, opts)
	end

	-- Rust
	-- https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
	-- https://github.com/simrat39/rust-tools.nvim/issues/89 🔥
	-- https://github.com/simrat39/rust-tools.nvim/issues/114
	if server.name == "rust_analyzer" then
		local rust_analyzer_opts = require "lsp.settings.rust-analyzer"

		-- Update this path
		local extension_path = "/Users/youngjaelim/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

		local rust_opts = {
			-- FIX: I don't need to specify tools variable unless I want to override the default values.
			tools = require "lsp.settings.rust-tools",
			-- debuggin stuffs
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			-- The following server options are to send to nvim-lspconfig
			-- these override the defaults set by rust-tools.nvim
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts, rust_analyzer_opts),
		}
		-- Initialize the LSP via rust-tools instead
		require("rust-tools").setup(rust_opts)
		-- Attaches this server to all current open buffers with a 'filtype' that matches the server's configured filetypes
		server:attach_buffers()
	end

	-- ls_emmet
	if server.name == "emmet_ls" then
		local ls_emmet_opts = require "lsp.settings.ls_emmet"
		opts = vim.tbl_deep_extend("force", ls_emmet_opts, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- NOTE: In other words, the server gets all the default values that nvim-lspconfig sets for us.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	-- Sets up the language server and attaches all open buffers
	server:setup(opts)
end)

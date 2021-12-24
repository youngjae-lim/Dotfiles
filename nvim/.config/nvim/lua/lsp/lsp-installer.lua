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
	if server.name == "rust_analyzer" then
		-- Initialize the LSP via rust-tools instead
		require("rust-tools").setup {
			-- The "server" property provided in rust-tools setup function are the
			-- settings rust-tools will provide to lspconfig during init.
			-- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
			-- with the user's own settings (opts).
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
		}
		-- Attaches this server to all current open buffers witha 'filtype' that matches the server's configured filetypes
		server:attach_buffers()
	end

	-- ls_emmet
	if server.name == "emmet_ls" then
		local ls_emmet_opts = require "lsp.settings.ls_emmet"
		opts = vim.tbl_deep_extend("force", ls_emmet_opts, opts)
	end

	-- tailwindcss
	if server.name == "tailwindcss" then
		local tailwindcss = require "lsp.settings.tailwindcss"
		opts = vim.tbl_deep_extend("force", tailwindcss, opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	-- Sets up the language server and attaches all open buffers
	server:setup(opts)
end)

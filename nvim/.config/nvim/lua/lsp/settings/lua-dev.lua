local M = {}

M.luadev = require("lua-dev").setup {
	runtime_path = true, -- get completion in require strings
	lspconfig = {
		-- Use a lua language server from a lsp-installer, not from lua-dev default
		cmd = {
			"/Users/youngjaelim/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server",
			"-E",
			"/Users/youngjaelim/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/main.lua",
		},
		settings = {
			Lua = {
				diagnostics = {
					globals = { "hs" },
				},
			},
		},
	},
}

return M

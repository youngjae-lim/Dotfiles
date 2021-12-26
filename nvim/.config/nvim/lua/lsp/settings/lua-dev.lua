local M = {}

M.luadev = require("lua-dev").setup {
	runtime_path = true, -- get completion in require strings
	lspconfig = {
		-- Use a lua language server(i.e., sumneko_lua) from a lsp-installer, not from lua-dev default
		-- This way, we can use the orginal server but with extra settings done by lua-dev
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
				workspace = {
					preloadFileSize = 350,
				},
			},
		},
	},
}
-- TODO: take a look at what M.luadev variable is passing to lsp-installer.lua
-- run :luafile %:p
P(M.luadev)

return M

return {
	-- overwrite the original path that is used by lsp-installer
	-- This is a workaround to use ls_emmet server instead of default emmet_ls that was installed in /.local/share/nvim/lsp_servers/
	cmd = {
		"/Users/youngjaelim/.nvm/versions/node/v16.13.0/bin/ls_emmet",
		"--stdio",
	},
	filetypes = {
		"html",
		"css",
		"scss",
		"js",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"sass",
		"svelte",
		"jsx",
		"php",
	},
	settings = {},
}

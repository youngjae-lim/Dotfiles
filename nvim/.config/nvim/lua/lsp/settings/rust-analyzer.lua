return {
	root_dir = require("lspconfig.util").root_pattern "Cargo.toml",
	settings = {
		-- Refer to all available options here: https://rust-analyzer.github.io/manual.html
		-- https://github.com/sharksforarms/dotfiles/blob/main/config/nvim/lua/sharks/lsp/init.lua
		["rust-analyzer"] = {
			updates = { channel = "stable" },
			notifications = { cargoTomlNotFound = false },
			assist = {
				importGroup = true,
				importMergeBehaviour = "full",
				importPrefix = "by_crate",
			},

			callInfo = {
				full = true,
			},

			cargo = {
				allFeatures = true,
				autoreload = true,
				loadOutDirsFromCheck = true,
			},

			checkOnSave = {
				command = "clippy",
				allFeatures = true,
				extraArgs = "--tests",
			},

			completion = {
				addCallArgumentSnippets = true,
				addCallParenthesis = true,
				postfix = {
					enable = true,
				},
				autoimport = {
					enable = true,
				},
			},

			diagnostics = {
				enable = true,
				enableExperimental = true,
			},

			hoverActions = {
				enable = true,
				debug = true,
				gotoTypeDef = true,
				implementations = true,
				run = true,
				linksInHover = true,
			},

			inlayHints = {
				chainingHints = true,
				parameterHints = true,
				typeHints = true,
			},

			lens = {
				enable = true,
				debug = true,
				implementations = true,
				run = true,
				methodReferences = true,
				references = true,
			},

			procMacro = {
				enable = true,
			},
		}, -- ["rust-analyzer"]
	},
}

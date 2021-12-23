-- Setup Language Servers using lspconfig.configs
-- This file is not being used by my neovim environment becasue I switched to using nvim-lsp-installer.
-- However, you can still use whenever you want if you need to install any languager servers that are not
-- supported by nvim-lsp-installer.
local configs = require "lspconfig.configs"
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local on_attach = require("lsp.handlers").on_attach
local capabilities = require("lsp.handlers").capabilities

-- Use the following format to add any new server that is not supported by lsp-installer
-- https://github.com/pedro757/emmet#configuration
-- Don't be confused ls_emmet with emmet_ls: ls_emmet is a forked and maintained version of emmet_ls.
if not configs.ls_emmet then
	configs.ls_emmet = {
		default_config = {
			cmd = { "ls_emmet", "--stdio" },
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
			},
			root_dir = function()
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end

local system_name
if vim.fn.has "mac" == 1 then
	system_name = "macOS"
elseif vim.fn.has "unix" == 1 then
	system_name = "Linux"
elseif vim.fn.has "win32" == 1 then
	system_name = "Windows"
else
	require "notify"("Unsupported system for sumneko", "info", { title = "LSP Error" })
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- vim.fn.stdpath('config') gives us ${HOME}/.config/nvim as a path
local sumneko_root_path = vim.fn.stdpath "config" .. "/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- @TODO: Add 'taplo' for toml langauge server later. Currently there is a cargo build issue with the server.
-- https://github.com/tamasfe/taplo/issues/197
-- Add any supported language server here after you install the corresponding languageserver.
-- Please make sure that you have already installed these language servers and make them available in your PATH
local langservers = {
	"texlab",
	"html",
	"cssls",
	"tsserver",
	"pyright",
	"gopls",
	"rust_analyzer",
	"ls_emmet",
	"sumneko_lua",
	"vimls",
	"bashls",
	"svelte",
}

-- LSP settings (for overriding per client)
for _, server in ipairs(langservers) do
	if server == "sumneko_lua" then
		require("lspconfig")[server].setup {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = {
				sumneko_binary,
				"-E",
				sumneko_root_path .. "/main.lua",
			},
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Setup your lua path
						path = runtime_path,
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global and 'hs' for Hammperspoon
						globals = { "vim", "hs" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = { enable = false },
				},
			},
		}
	else
		require("lspconfig")[server].setup {
			on_attach = on_attach,
			capabilities = capabilities,
		}
	end
end

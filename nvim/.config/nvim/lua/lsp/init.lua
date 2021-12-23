-- require('lsp/cmp')
-- require('lsp/diagnostic_signs')
-- require('lsp/language_servers')
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("lsp.handlers").setup()
require "lsp.lsp-installer"
require "lsp.null-ls"
require "lsp.signature"

-- Setup lspconfigo.
local configs = require 'lspconfig.configs'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = {'ls_emmet', '--stdio'},
      filetypes = {
        'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml', 'xml', 'xsl', 'pug', 'slim', 'sass',
        'stylus', 'less', 'sss'
      },
      root_dir = function(fname)
        return vim.loop.cwd()
      end,
      settings = {}
    }
  }
end

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- vim.fn.stdpath('config') gives us ${HOME}/.config/nvim as a path
local sumneko_root_path = vim.fn.stdpath('config') .. '/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Add any supported language server here after you install the corresponding languageserver.
local langservers = {'texlab', 'html', 'cssls', 'tsserver', 'pyright', 'gopls', 'rust_analyzer', 'ls_emmet', 'sumneko_lua'}

for _, server in ipairs(langservers) do
  if server == 'sumneko_lua' then
    require'lspconfig'[server].setup {
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global and 'hs' for Hammperspoon
            globals = {'vim', 'hs'}
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {vim.api.nvim_get_runtime_file("", true), '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'},
            checkThirdParty = true
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {enable = false}
        }
      }
    }
  else
    require'lspconfig'[server].setup {capabilities = capabilities}
  end
end


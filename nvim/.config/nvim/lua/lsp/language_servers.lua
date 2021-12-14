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
        'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript',
        'typescriptreact', 'haml', 'xml', 'xsl', 'pug', 'slim', 'sass',
        'stylus', 'less', 'sss'
      },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {}
    }
  }
end

-- korean_ls is not included in the lsp server setup due to some issues.
if not configs.korean_ls then
  configs.korean_ls = {
    default_config = {
      cmd = {'korean-ls', '--stdio'},
      filetypes = {'text'},
      root_dir = function()
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
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name
                           .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Add any supported language server here after you install the corresponding languageserver.
-- @TODO: Add 'taplo' for toml langauge server later. Currently there is a cargo build issue with the server.
-- https://github.com/tamasfe/taplo/issues/197
-- korean_ls is removded now. I don't think it is stable enough to use it.
local langservers = {
  'texlab', 'html', 'cssls', 'tsserver', 'pyright', 'gopls', 'rust_analyzer',
  'ls_emmet', 'sumneko_lua', 'vimls'
}

local border = {
  {"╭", "FloatBorder"}, {"─", "FloatBorder"}, {"╮", "FloatBorder"},
  {"│", "FloatBorder"}, {"╯", "FloatBorder"}, {"─", "FloatBorder"},
  {"╰", "FloatBorder"}, {"│", "FloatBorder"}
}

-- If you want to avoid being overwritten by your colorscheme, please remove comment below.
-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=yellow guibg=#1f2335]]

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                                        {border = border}),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
                                                {border = border}),
  ['txtDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic
                                                        .on_publish_diagnostics,
                                                    {
    underline = true,
    virtual_text = {prefix = '●', spacing = 5, severity_limit = 'Warning'},
    update_in_insert = true,
    signs = true
  })
}

-- LSP settings (for overriding per client)
for _, server in ipairs(langservers) do
  if server == 'sumneko_lua' then
    require'lspconfig'[server].setup {
      cmd = {
        sumneko_binary, "-E --locale=\"en-US\"",
        sumneko_root_path .. "/main.lua"
      },
      handlers = handlers,
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
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {enable = false}
        }
      }
    }
  else
    require'lspconfig'[server].setup {
      capabilities = capabilities,
      handlers = handlers
    }
  end
end


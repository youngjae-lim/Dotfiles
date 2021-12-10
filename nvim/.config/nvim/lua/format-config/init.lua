require'format'.setup {
  -- Install prettier globally on your machine: npm install -g prettier
  html = {{cmd = {"prettier -w"}}},
  css = {{cmd = {"prettier -w"}}},
  json = {{cmd = {"prettier -w"}}},
  yaml = {{cmd = {"prettier -w"}}},
  javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
  javascriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
  typescript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
  typescriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},

  -- Install cmake: brew install cmake
  -- Install luaformatter: luarocks install --server=https://luarocks.org/dev luaformatter
  lua = {
    {
      cmd = {
        function(file)
          return string.format(
                     'lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=80 --break-after-table-lb --indent-width=2 %s',
                     file)
        end
      }
    }
  },
  -- Install black: pip install black
  python = {
    {
      cmd = {
        function(file)
          return string.format('black --quiet %s', file)
        end
      }
    }
  },
  -- Install shfmt: go install mvdan.cc/sh/v3/cmd/shfmt@latest
  sh = {
    {
      cmd = {
        function(file)
          return string.format('shfmt -w %s', file)
        end
      }
    }
  },
  go = {
    {
      cmd = {
        function(file)
          return string.format("gofmt -w %s", file)
        end
      },
      tempfile_postfix = ".tmp"
    }
  },
  rust = {
    {
      cmd = {
        function(file)
          return string.format("rustfmt %s", file)
        end
      },
      tempfile_postfix = ".tmp"
    }
  },
  ruby = {
    {
      cmd = {
        function(file)
          return string.format("rufo %s", file)
        end
      },
      tempfile_postfix = ".tmp"
    }
  },
  -- Install vue-beautify: npm install -g vue-beautify
  vue = {
    {
      cmd = {
        function(file)
          return string.format("vue-beautify %s", file)
        end
      },
      tempfile_postfix = ".tmp"
    }
  },
  php = {
    {
      cmd = {
        function(file)
          return string.format("php-formatter formatter:use:sort --quiet %s", file)
        end
      },
      tempfile_postfix = ".tmp"
    }
  }
}

-- To format on save
vim.cmd('autocmd BufWritePost * FormatWrite')

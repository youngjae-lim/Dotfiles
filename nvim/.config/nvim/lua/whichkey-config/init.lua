local wk = require("which-key")
wk.setup {
  plugins = {
    marks = false,
    registers = false,
    spelling = {enabled = false, suggestions = 20},
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = false,
      z = false,
      g = false
    }
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2}, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = {min = 4, max = 25}, -- min and max height of the columns
    width = {min = 20, max = 50}, -- min and max width of the columns
    spacing = 6, -- spacing between columns
    align = "left" -- align columns left, center or right
  }
}

-- @TODO: organize which-keys
local mappings = {
  x = {":bdelete<cr>", "Close"},
  E = {":e ~/.config/nvim/init.lua<cr>", "Edit nvim config"},
  f = {":Telescope find_files<cr>", "Telescope Find Files"},
  r = {":Telescope live_grep<cr>", "Telescope Live Grep"},
  b = {
    "<cmd>lua require(\"telescope\").extensions.file_browser.file_browser() <cr>",
    "Telescope File Browser"
  },
  O = {"<cmd>!mostRecentNote.sh<cr>", "Open Most Recent Note in PDF"},
  l = {
    name = "LSP",
    i = {":LspInfo<cr>", "Connected Language Servers"},
    w = {
      '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add Workspace Folder"
    },
    W = {
      '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
      "Remove Workspace Folder"
    },
    l = {
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      "List Workspace Folder"
    },
    t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type Definition"},
    d = {'<cmd>lua vim.lsp.buf.definition()<CR>', "Go to Definition"},
    D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', "Go to Declaration"},
    r = {'<cmd>lua vim.lsp.buf.references()<CR>', "References"}, -- Better use telescope builtin
    R = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
    h = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover"},
    s = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature Help"},
    a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Actions"},
    e = {
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
      "Show Line Diagnostics"
    }, -- Better use telescope builtin
    n = {
      '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', "Go To Next Diagnostics"
    }, -- Better use telescope builtin
    N = {
      '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', "Go To Prev Diagnostics"
    }, -- Better use telescope builtin
    q = {'<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', "Show Loclist"}
  },
  t = {
    name = "Toggle",
    t = {":ToggleTerm<cr>", "Split Below"},
    f = {"<cmd>lua _TOGGLE_FLOAT()<CR>", "Floating Terminal"},
    l = {"<cmd>lua _TOGGLE_LAZYGIT()<CR>", "Floating Lazygit"},
    n = {"<cmd>lua _TOGGLE_NOTETAKER()<CR>", "Floating Notetaker"}
  }
}

local opts = {prefix = '<leader>'}
wk.register(mappings, opts)


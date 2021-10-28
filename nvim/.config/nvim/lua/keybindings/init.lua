vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

map('i', 'jk', '<ESC>', {noremap = true, silent = false})
map('i', 'kj', '<ESC>', {noremap = true, silent = false})

map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = false})

map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

-- ** the Telescope comma maps **
map(
  'n',
  ',h',
  [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
  { noremap = true, silent = true }
)
map(
  'n',
  ',k',
  [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
  { noremap = true, silent = true }
)
-- Telescopic version of FZF's :Lines
map(
  "n",
  ",l",
  [[<Cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>]],
  { noremap = true, silent = true }
)
-- show LSP diagnostics for all open buffers
map(
  "n",
  ",d",
  [[<Cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>]],
  { noremap = true, silent = true }
)


-- run packer sync
map("n", "<leader>ps", [[<Cmd>PackerSync<CR>]], { noremap = true, silent = true })


vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

-- Windows navigation horizontally/vertically
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

-- Toggle NvimTree
map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = false})

-- Continuous tab on selection
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

---------------------------------
-- ** the Telescope comma maps **
---------------------------------
-- Search in help
map(
  'n',
  ',h',
  [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
  { noremap = true, silent = true }
)
-- Search keymaps
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

-- yank all in buffer (i.e., select all)
map("n", "<leader>a", ":%y<cr>", { noremap = false, silent = true })

-- Tab out of parenthesis, curly/square brackets
map("i", "<C-o>", "<C-o>$", { noremap = false, silent = true })

-- open file in directory of current file
map("n", "<leader>ob", ":e %:h/", { noremap = false, silent = false })
map("n", "<leader>ov", ":vs %:h/", { noremap = false, silent = false })

-- Open File Name under cursor in vert split
map("n", "<leader>gf", ":vs <cfile><CR>", { noremap = false, silent = true })

-- Resize split windows
map('n', '<left>', ':vertical resize -2<CR>', {noremap = true, silent = false})
map('n', '<down>', ':resize -2<CR>', {noremap = true, silent = false})
map('n', '<up>', ':resize +2<CR>', {noremap = true, silent = false})
map('n', '<right>', ':vertical resize +2<CR>', {noremap = true, silent = false})

vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap

-- Windows navigation horizontally/vertically
map('n', '<left>', '<C-w>h', {noremap = true, silent = false})
map('n', '<right>', '<C-w>l', {noremap = true, silent = false})
map('n', '<down>', '<C-w>j', {noremap = true, silent = false})
map('n', '<up>', '<C-w>k', {noremap = true, silent = false})

-- Toggle NvimTree
map('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = false})

-- Continuous tab on selection
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

---------------------------------
-- ** the Telescope comma maps **
---------------------------------
-- Find files with names that contain cursor word
map("n", ",f",
    [[<Cmd>lua require'telescope.builtin'.find_files({find_command={'fd', vim.fn.expand('<cword>')}})<CR>]],
    {noremap = true, silent = true})
-- Search in help
map('n', ',h',
    [[<Cmd>lua require'telescope.builtin'.help_tags({results_title='Help Results'})<CR>]],
    {noremap = true, silent = true})
-- Search keymaps
map('n', ',k',
    [[<Cmd>lua require'telescope.builtin'.keymaps({results_title='Key Maps Results'})<CR>]],
    {noremap = true, silent = true})
-- Grep from the files opened only
map("n", ",l",
    [[<Cmd>lua require'telescope.builtin'.live_grep({grep_open_files=true})<CR>]],
    {noremap = true, silent = true})
-- Grep from the current buffer
map("n", ",s",
    [[<Cmd>lua require'telescope.builtin'.live_grep({search_dirs={"%:p"}})<CR>]],
    {noremap = true, silent = true})
-- Search in Marks
map("n", ",m",
    [[<Cmd>lua require'telescope.builtin'.marks({results_title='Marks Results'})<CR>]],
    {noremap = true, silent = true})
-- Find notes
map("n", ",n",
    [[<Cmd>lua require'telescope-config'.find_notes({results_title='Notes Results'})<CR>]],
    {noremap = true, silent = true})
-- Grep notes
map("n", ",g",
    [[<Cmd>lua require'telescope-config'.grep_notes({results_title='Notes Results'})<CR>]],
    {noremap = true, silent = true})
-- Browse notes
map("n", ",p",
    [[<Cmd>lua require'telescope-config'.browse_webdev_projects()<CR>]],
    {noremap = true, silent = true})
-- Search Google Chrome Bookmarks & Go
map("n", ",b",
    [[<Cmd>lua require'telescope'.extensions.bookmarks.bookmarks()<CR>]],
    {noremap = true, silent = true})
-- Neoclip
map("n", ",c", [[<Cmd>lua require'telescope'.extensions.neoclip.plus()<CR>]],
    {noremap = true, silent = true})
-- Grep word under cursor
map("n", ",w", [[<Cmd>lua require'telescope.builtin'.grep_string()<CR>]],
    {noremap = true, silent = true})
-- Grep word under cursor - case-sensitive (exact word) - made for use with Replace All - see <leader>ra
map("n", ",W",
    [[<Cmd>lua require'telescope.builtin'.grep_string({word_match='-w'})<CR>]],
    {noremap = true, silent = true})
-- Get list of repos
map("n", ",r", [[<Cmd>lua require'telescope-config'.repo_list()<CR>]],
    {noremap = true, silent = true})
-- Run a color picker
map("n", ",i",
    [[<Cmd>lua require'telescope-config.color_picker'.color_picker()<CR>]],
    {noremap = true, silent = true})
-- Run a directory picker(it uses zoxide underneath it)
map("n", ",z",
    [[<Cmd>lua require'telescope-config.directory_picker'.directory_picker()<CR>]],
    {noremap = true, silent = true})
--------------------------------------
-- ** the Telescope <leader>s maps **
--------------------------------------
-- show LSP diagnostics for all open buffers
map("n", "<leader>sG", [[<Cmd>Telescope diagnostics<CR>]],
    {noremap = true, silent = true})
-- show LSP diagnostics for the current buffer
map("n", "<leader>sg", [[<Cmd>Telescope diagnostics bufnr=0<CR>]],
    {noremap = true, silent = true})
-- show LSP document symbols(function, property, variable, etc) in the current buffer
map("n", "<leader>ss",
    [[<Cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]],
    {noremap = true, silent = true})
-- show LSP document symbols(function, property, variable, etc) in the current workspace
map("n", "<leader>sw",
    [[<Cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>]],
    {noremap = true, silent = true})
-- show LSP references for word under the cursor
map("n", "<leader>sr",
    [[<Cmd>lua require'telescope.builtin'.lsp_references()<CR>]],
    {noremap = true, silent = true})
-- show LSP implementations - go to the implementation of the word under the cursor if there's only one, otherwise show all options
map("n", "<leader>si",
    [[<Cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]],
    {noremap = true, silent = true})
-- show LSP definitions - go to the definition of the word under the cursor, if there's only one, otherwise show all options
map("n", "<leader>sd",
    [[<Cmd>lua require'telescope.builtin'.lsp_definitions({layout_config = { preview_width = 0.50, width = 0.92 }, path_display = { "shorten" }, results_title='Definitions'})<CR>]],
    {noremap = true, silent = true})
-- show LSP code actions - lists any LSP actions for the word under the cursor, that can be triggered with <cr>
map("n", "<leader>sc",
    [[<Cmd>lua require'telescope.builtin'.lsp_code_actions()<CR>]],
    {noremap = true, silent = true})
-- search @TODOs
map("n", "<leader>st",
    [[<Cmd>lua require'telescope-config'.search_todos()<CR>]],
    {noremap = true, silent = true})

-- Yank from the curent position to the end of line
-- @TODO: Is this default on or after neovim version 0.6?
map("n", "Y", "y$", {noremap = true, silent = true})

-- Keep it centered
map("n", "n", "nzzzv", {noremap = true, silent = true})
map("n", "N", "Nzzzv", {noremap = true, silent = true})
map("n", "J", "mzJ`z", {noremap = true, silent = true})

-- Undo break points
map("i", ",", ",<c-g>u", {noremap = true, silent = true})
map("i", ".", ".<c-g>u", {noremap = true, silent = true})
map("i", "!", "!<c-g>u", {noremap = true, silent = true})
map("i", "?", "?<c-g>u", {noremap = true, silent = true})

-- run packer sync
map("n", "<leader>ps", [[<Cmd>PackerSync<CR>]], {noremap = true, silent = true})

-- yank all in buffer (i.e., select all)
map("n", "<leader>a", ":%y<cr>", {noremap = false, silent = true})

-- Tab out of parenthesis, curly/square brackets
map("i", "<C-o>", "<C-o>$", {noremap = false, silent = true})

-- Clear highlights searched
map("n", "<esc><esc>", ":noh<CR>", {noremap = false, silent = true})

-- open file in directory of current file
map("n", "<leader>ob", ":e %:h/", {noremap = false, silent = false})
map("n", "<leader>ov", ":vs %:h/", {noremap = false, silent = false})

-- Open File Name under cursor in vert split
map("n", "<leader>gf", ":vs <cfile><CR>", {noremap = false, silent = true})

-- Resize split windows
map('n', '<S-left>', ':vertical resize -2<CR>', {noremap = true, silent = false})
map('n', '<S-down>', ':resize -2<CR>', {noremap = true, silent = false})
map('n', '<S-up>', ':resize +2<CR>', {noremap = true, silent = false})
map('n', '<S-right>', ':vertical resize +2<CR>',
    {noremap = true, silent = false})

-- Easy align (type 'vipga' = this selects a paragraph and invokes :EasyAlign command)
map("x", "ga", ":EasyAlign", {noremap = false, silent = true})

-- Remap gs to type out the global substitution command and put your cursor in position to type what you want to find/replace
map("n", "gs", ":%s//g<Left><Left>", {noremap = false, silent = true})

-- Replace word under cursor in Buffer (case-sensitive)
map("n", ";sb", ":%s/<C-R><C-W>//gI<left><left><left>", {noremap = false})
-- Replace word under cursor on Line (case-sensitive)
map("n", ";sl", ":s/<C-R><C-W>//gI<left><left><left>", {noremap = false})

-- ** Project-wide renaming with Telescope (optional) ** --
-- Replace <cword> in all files listed in quickfix list:
-- Step 0: Skip steps 1 & 2 if you populate your quickfix list another way
-- Step 1. Use Telescope's grep_string({word_match='-w'}) - <leader>Q below
-- Step 2. In Telescope `Normal` mode, type <C-q> (default for sending all to qf)
-- Step 3. Run this mapping, fill in new word and press <CR> (!Don't do this without VCS!!)
-- Mnemonic: Replace All - case-sensitive - ignore errors about files not having the word
-- -- (you will get LSP errors if you jack something up, that's a good thing)
-- With Telescope you can also only send selected files to the qf. See  Telescope docs.
-- There are plugins or combiations of plugins that can do this. But, this is the 'magic'
-- This can also be leveraged to open your multi-selected files in Telescope (for now: https://git.io/telescope807)
map("n", ";sa",
    ":cfdo %s/<C-R><C-W>//geI<bar>update<left><left><left><left><left><left><left><left><left><left><left>",
    {noremap = false})

-- Surround word under cursor w/ backticks (required vim-surround)
map("n", "<leader>`", "ysiW`", {noremap = false})

-- REPLACE: delete inner word & replace with last yanked (including system)
map("n", ";r", '"_diwhp', {noremap = true})

-- paste last thing yanked(not system copied), not deleted
map("n", ";p", '"0p', {noremap = true})
map("n", ";P", '"0P', {noremap = true})

-- Terminal windows mappings
-- It can be helpful to add mappings to make moving in and out of a terminal easier once toggled, whilst still keeping it open.
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Turn a markdown file into a presentation pdf
map('n', '<leader>mp', ':!buildPresentation.sh "%:p"<CR>',
    {noremap = true, silent = true})

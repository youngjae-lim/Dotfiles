-- don't call globals unneccessarily
local o = vim.o -- > both global and local
local bo = vim.bo -- > buffer only use bo
local wo = vim.wo -- > window only use wo

-- no need for a global function
local set_options = function(locality, options)
  for key, value in pairs(options) do locality[key] = value end
end

-- define our global local options
-- Some buffers or windows always have a copy of their own, but others may not.
-- So vim uses the current local option if set, otherwise, it uses the global option.
local options_global_local = {
  shortmess = vim.o.shortmess .. 'c',
  hidden = true,
  whichwrap = 'b,s,<,>,[,],h,l',
  pumheight = 10,
  fileencoding = 'utf-8',
  cmdheight = 2,
  splitbelow = true,
  splitright = true,
  conceallevel = 0,
  showtabline = 2,
  showmode = false,
  backup = false,
  writebackup = false,
  updatetime = 300,
  timeoutlen = 300,
  clipboard = "unnamedplus",
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  scrolloff = 3,
  sidescrolloff = 5,
  mouse = "a",
  cursorline = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  autoindent = true,
  expandtab = true
}

-- All buffers always have a copy of this setting.
-- And so global options are only meaningful as the default value.
local options_buffer = {
  tabstop = 4,
  shiftwidth = 4,
  autoindent = true,
  expandtab = true
}
-- All windows always have a copy of this setting.
-- And so global options are only meaningful as the default value.
local options_window = {
  number = true,
  signcolumn = "yes",
  wrap = true,
  linebreak = true
}

-- set locally. no need to call elsewhere
set_options(o, options_global_local)
set_options(bo, options_buffer)
set_options(wo, options_window)

vim.cmd('filetype plugin indent on')
vim.cmd('set fillchars+=vert:│')
vim.opt.termguicolors = true
vim.cmd("colorscheme rose-pine")

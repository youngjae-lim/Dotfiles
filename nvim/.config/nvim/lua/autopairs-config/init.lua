require('nvim-autopairs').setup({
  check_ts = true,
})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- add option map_cr
npairs.setup({ map_cr = true })

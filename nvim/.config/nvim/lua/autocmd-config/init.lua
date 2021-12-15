-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local nvim_create_augroups = function(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autocmds = {
  -- Turn a markdown note file into a pdf
  turn_markdown_to_pdf = {
    {"BufWritePost", "*note-*.md", "silent !buildNote.sh \"%:p\""}
  },
  -- Run PackerSync automatically whenever ~./config/nvim/lua/plugins/init.lua file is saved
  run_packersync = {
    {
      "BufWritePost", "*/nvim/lua/plugins/init.lua",
      "source <afile> | PackerSync"
    }
  }
}

nvim_create_augroups(autocmds)
-- autocommands END

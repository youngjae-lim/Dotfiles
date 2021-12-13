-- This is a template for making a customized telescope picker
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local action_state = require "telescope.actions.state"

-- enter applies a selected item to window
local enter = function(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  -- Show selected items
  -- print(vim.inspect(selected))
  local cmd = 'mycmd ' .. selected[1]
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

-- next_item selects next item and applies it to window immediately
local next_item = function(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'mycmd ' .. selected[1]
  vim.cmd(cmd)
end

-- prev_item selects previous item and applies it to window immediately
local prev_item = function(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'mycmd ' .. selected[1]
  vim.cmd(cmd)
end

-- customized layout
local mini = {
  layout_strategy = "vertical",
  layout_config = {height = 50, width = 0.2, prompt_position = "top"},
  sorting_strategy = "ascending"
}

-- get all available items you want from input source
local items = vim.fn.getcompletion("", "item_source")

local opts = {
  finder = finders.new_table(items),
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(_, map)
    map("i", "<CR>", enter)
    map("i", "<C-J>", next_item)
    map("i", "<C-K>", prev_item)

    map("n", "<CR>", enter)
    map("n", "j", next_item)
    map("n", "k", prev_item)
    return true
  end
}

local my_picker = pickers.new(mini, opts)

local M = {}

function M.my_picker()
  my_picker:find()
end

return M

-- Example of keybinding to use this picker
-- map("n", "<your_key_binding>",
--     [[<Cmd>lua require'telescope-config.picker_template'.my_picker()<CR>]],
--     {noremap = true, silent = true})

local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
-- local dropdown = require "telescope.themes".get_dropdown()
local action_state = require "telescope.actions.state"

-- enter applies a selected colorscheme to window and saves it to /lua/options/init.lua file
local enter = function(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  -- print(vim.inspect(selected))
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)

  -- @TODO figure out how to set the changed colorscheme to config in a better way
  local vim_cmd = string.format("vim.cmd(\"%s\")", cmd)
  local init = vim.fn.expand("~/.config/nvim/lua/options/init.lua")
  local job_cmd =
      "sed -i '' '$d' " .. init .. " && echo '" .. vim_cmd .. "' >> " .. init
  vim.fn.jobstart(job_cmd)

  actions.close(prompt_bufnr)
end

-- next_color selects next color and applies it to window immediately
local next_color = function(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

-- prev_color selects previous color and applies it to window immediately
local prev_color = function(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = 'colorscheme ' .. selected[1]
  vim.cmd(cmd)
end

local mini = {
  layout_strategy = "vertical",
  layout_config = {height = 50, width = 0.2, prompt_position = "top"},
  sorting_strategy = "ascending"
}

local colors = vim.fn.getcompletion("", "color")

local opts = {
  finder = finders.new_table(colors),
  sorter = sorters.get_generic_fuzzy_sorter({}),

  attach_mappings = function(_, map)
    map("i", "<CR>", enter)
    map("i", "<C-J>", next_color)
    map("i", "<C-K>", prev_color)

    map("n", "<CR>", enter)
    map("n", "j", next_color)
    map("n", "k", prev_color)
    return true
  end
}

colors = pickers.new(mini, opts)

local M = {}

function M.color_picker()
  colors:find()
end

return M


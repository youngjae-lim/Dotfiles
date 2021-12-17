-- local utils = require('utils')
-- local Job = require('plenary.job')
local M = {}

function M.notify_current_datetime()
  local dt = vim.fn.strftime "%c"
  require "notify"("Current Date Time: " .. dt, "info", {title = "Date & Time"})
end

return M

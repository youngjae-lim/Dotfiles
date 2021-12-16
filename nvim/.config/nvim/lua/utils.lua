local Job = require "plenary.job"

local M = {}

-- Source: 🔭 utils: https://git.io/JK3ht
-- Use this function to run a command and get an output
-- For example, you can pass the output(stdout) to telescope's finders.new_table() function
-- so that the telescope finder can be populated with a list of items.
function M.get_os_command_output(cmd, cwd)
  if type(cmd) ~= "table" then
    print "Utils: [get_os_command_output]: cmd has to be a table"
    return {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end
  }):sync()
  return stdout, ret, stderr
end

return M

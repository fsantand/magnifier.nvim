local io = require("io")

local M = {}

local function check_if_exists(directory)
  local ok, err, code = os.rename(directory, directory)
  if not ok then
    if code == 13 then
      return true
    end
  end
  return ok, err
end

M.dir_exists = function(path)
  return check_if_exists(path .."/")
end

M.scan_dir = function(path)
  local pfile = io.popen("fd . " .. path .. " --type directory")
  local dirs = {}
  if pfile == nil then
    return
  end

  for dir in pfile:lines() do
    table.insert(dirs, dir)
  end

  pfile:close()

  return dirs
end

return M


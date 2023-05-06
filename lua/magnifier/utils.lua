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

return M

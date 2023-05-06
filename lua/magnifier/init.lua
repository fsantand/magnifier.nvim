local M = {}

M.enabled = false

local function toggle_magnifier(opts, is_active)
 M.enabled = is_active
end

local function add_to_scope()
  local buf_name = vim.api.nvim_buf_get_name(0)
  print(string.format("Directory %s added to scope!", buf_name))
end

local function remove_from_scope()
  print("Removed from scope")
end

local function list_scope()
  print(M.enabled)
end

function M.setup (opts)
  M.enabled = opts.enabled_by_default or true

  vim.api.nvim_create_user_command("MagnifierEnable", function(_) toggle_magnifier(M, true) end, {})
  vim.api.nvim_create_user_command("MagnifierDisable", function(_) toggle_magnifier(M, false) end, {})
  vim.api.nvim_create_user_command("MagnifierDisable", function(_) toggle_magnifier(M, not M.is_active) end, {})
  vim.api.nvim_create_user_command("MagnifierAdd", add_to_scope, {})
  vim.api.nvim_create_user_command("MagnifierRemove", remove_from_scope, {})
  vim.api.nvim_create_user_command("MagnifierList", list_scope, {})
end

return M

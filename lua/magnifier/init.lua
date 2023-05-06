local utils = require("magnifier.utils")
local finders = require("magnifier.finders")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local M = {}

M.enabled = false
M.scoped_workspaces = {}
M.current_workspace = vim.fn.getcwd()

M.current_dirs = function ()
  return M.scoped_workspaces[M.current_workspace]
end


local function add_to_scope()
  local directory = vim.fn.expand("%:h")
  vim.ui.input(
    {
      prompt="Dir to scope: ",
      default=directory,
      completion="dir"
    },
    function (input)
      vim.cmd(":redraw")
      if input == "" then
        vim.notify("\nThe directory can't be the current working directory", vim.log.levels.ERROR)
        return
      end
      if utils.dir_exists(input) then
        table.insert(M.current_dirs(), input)
        vim.notify("Directory scoped succesfully", vim.log.levels.INFO)
      else
        vim.notify("The directory doesn't exists", vim.log.levels.ERROR)
      end
    end
  )
end

local function remove_from_scope()
  local rev_ipairs = {}
  for i, k in ipairs(M.current_dirs()) do
    rev_ipairs[k] = i
  end

  vim.ui.select(M.current_dirs(), {}, function (choice)
    table.remove(M.current_dirs(), rev_ipairs[choice])
  end)
end

local function list_scoped_workspace()
  if M.current_workspace == nil then
    print("No workspace set")
    return
  end
  print(M.current_workspace)
  for i, dir in ipairs(M.current_dirs()) do
    print(i .. ": " .. dir)
  end
end

local function refresh_scoped_cwd()
  local workspace_cwd = vim.fn.getcwd()
  M.current_workspace = workspace_cwd
  if M.scoped_workspaces[workspace_cwd] == nil then
    M.scoped_workspaces[M.current_workspace] = {}
  end
end

local function find_files_scoped()
  finders.find_files_scoped(M.current_dirs())
end

local function grep_files_scoped()
  finders.grep_files_scoped(M.current_dirs())
end

local function add_commands()
  vim.api.nvim_create_user_command("MagnifierSet", add_to_scope, {})
  vim.api.nvim_create_user_command("MagnifierList", list_scoped_workspace, {})
  vim.api.nvim_create_user_command("MagnifierRefresh", refresh_scoped_cwd, {})
  vim.api.nvim_create_user_command("MagnifierAdd", add_to_scope, {})
  vim.api.nvim_create_user_command("MagnifierRemove", remove_from_scope, {})
  vim.api.nvim_create_user_command("MagnifierFindFiles", find_files_scoped, {})
  vim.api.nvim_create_user_command("MagnifierGrepFiles", grep_files_scoped, {})
end

M.setup = function(opts)
  M.enabled = opts.enabled_by_default or false
  refresh_scoped_cwd()
  add_commands()
  augroup('MagnifierCwdChange', { clear = true })
  autocmd('DirChanged', {
    group = 'MagnifierCwdChange',
    callback = function()
      refresh_scoped_cwd()
      vim.notify("Scope refreshed")
    end
  })
end

return M

local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local action_state =  require("telescope.actions.state")
local actions =  require("telescope.actions")
local conf = require("telescope.config").values

local magnifier_utils = require("magnifier.utils")
local magnifier = require("magnifier")

local current_workspace = require("magnifier").current_workspace
local current_dirs = require("magnifier").current_dirs()

local function add_to_current_dirs(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)

  local new_dirs_entries = {}
  for _, entry in ipairs(picker) do
    table.insert(new_dirs_entries, entry)
  end
  actions.close(prompt_bufnr)

  magnifier.scoped_workspaces[magnifier.current_workspace] = new_dirs_entries
end

local magnifier = function (opts)
  opts = opts or require("telescope.themes").get_cursor()
  local dirs = magnifier_utils.scan_dir(current_workspace)
  pickers
    .new(opts, {
      prompt_title = "Scoped directories - "..current_workspace,
      finder = finders.new_table({
        results = dirs
      }),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        map("n", "<M-q>", )
      end
  }):find()
end

magnifier()

return telescope.register_extension{
  exports = {
    magnifier = magnifier,
  }
}

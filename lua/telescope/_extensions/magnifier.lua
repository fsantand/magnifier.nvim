local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local current_workspace = require("magnifier").current_workspace
local current_dirs = require("magnifier").current_dirs()


local magnifier_scope = function (opts)
  opts = opts or require("telescope.themes").get_dropdown()
  pickers
    .new(opts, {
      prompt_title = "Scoped directories - "..current_workspace,
      finder = finders.new_table({
        results = current_dirs
      }),
  }):find()
end

return telescope.register_extension{
  exports = {
    magnifier_scope = magnifier_scope
  }
}

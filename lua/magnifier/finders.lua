local builtin = require("telescope.builtin")

local M = {}

M.find_files_scoped = function(directories)
  builtin.find_files{search_dirs=directories}
end

M.grep_files_scoped = function(directories)
  builtin.live_grep{search_dirs=directories}
end

-- vim.ui.input({prompt="Enter dir: \n"}, function (input)
--   print(string.format("%s was saved\n", input))
-- end)

return M

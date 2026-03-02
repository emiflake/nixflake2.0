local M = {}

-- Check if running in VSCode
function M.is_vscode()
  return vim.fn.exists('g:vscode') ~= 0
end

return M

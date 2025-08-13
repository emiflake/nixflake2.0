if vim.fn.exists('g:vscode') ~= 0 then
  return {
    {},
  }
end

return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
  },
}

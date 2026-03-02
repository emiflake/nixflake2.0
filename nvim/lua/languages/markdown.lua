if require('utils').is_vscode() then
  return {}
end

return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
  },
}

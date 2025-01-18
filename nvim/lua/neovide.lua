if vim.g.neovide then
  -- Some weird stuff with neovide and Windows/WSL
  --
  -- This is a workaround for the fact that neovide doesn't respect the
  -- $PATH variable. It's a bit of a hack, but it works.
  vim.cmd('let $PATH .= ":' .. vim.fn.expand('~/.nix-profile/bin') .. '"')

  -- For some reason direnv.vim can't find direnv on its own
  vim.g.direnv_cmd = vim.fn.expand('~/.nix-profile/bin/direnv')

  vim.g.neovide_refresh_rate = 480
  vim.g.neovide_refrash_rate_idle = 30

  -- Make sure we start in nvim dir, because otherwise we will start in
  -- a windows dir.
  local default_path = vim.fn.expand('~/.config/nvim')
  vim.api.nvim_set_current_dir(default_path)
end

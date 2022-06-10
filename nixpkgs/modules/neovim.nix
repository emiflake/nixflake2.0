{ config, pkgs, libs, ... }:
{     
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    package = pkgs.neovim-unwrapped;
    plugins = with pkgs.vimPlugins; [
      yankring
      vim-nix
      ctrlp
      { plugin = onedark-vim;
        config = ''
          colo onedark
        '';
      }
      vim-nix
      gitgutter
      fugitive
      airline
      { plugin = vim-airline;
        config = ''
          let g:airline#extensions#tabline#enabled = 1
          let g:airline_left_sep = ''
          let g:airline_right_sep = ''
        '';
      }
      vim-airline-themes
    ];

    coc = {
      enable = true;
      package = pkgs.vimPlugins.coc-nvim;
      settings = {
        "suggest.noselect" = true;
        "suggest.enablePreview" = true;
        "suggest.enablePreselect" = false;
        "suggest.disableKind" = true;
        languageserver = {
          haskell = {
            command = "haskell-language-server";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" ];
          };
        };
      };
    };

    extraConfig = ''
       let mapleader=","
       set termguicolors
       set t_Co=256
       set number
       set mouse=a
       set clipboard+=unnamedplus
       set tabstop=4
       set shiftwidth=4
       set expandtab
    '';
  };
}

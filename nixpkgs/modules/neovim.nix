{ config, pkgs, libs, inputs, system, ... }:

let
  unison-git =
    pkgs.fetchFromGitHub {
      owner = "unisonweb";
      repo = "unison";
      rev = "e7023cd54b7f8cb2fc606f244607016e7776fdc2";
      sha256 = "YTDQm86ccbHyeo4RHnmqKkJod1Bs4cY5KzGxVCusOpo=";
    };
  unison-src =
    pkgs.runCommand "unison-src" { } '' 
      cp -r ${unison-git}/editor-support/vim $out
    '';
  unison = pkgs.vimUtils.buildVimPlugin {
    name = "unison";
    src = unison-src;
  };
in

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
      nvim-lspconfig
      vim-nix
      ctrlp
      {
        plugin = onedark-vim;
        config = ''
          colo onedark
        '';
      }
      {
        plugin = unison;
      }
      dhall-vim
      vim-nix
      gitgutter
      fugitive
      airline
      {
        plugin = vim-airline;
        config = ''
          let g:airline#extensions#tabline#enabled = 1
          let g:airline_left_sep = ''
          let g:airline_right_sep = ''
        '';
      }
      {
        plugin = vim-ormolu;
        config = ''
          let g:ormolu_command="fourmolu"
          let g:ormolu_options=["-o -XTypeApplications -o -XOverloadedRecordDot"]
          let g:ormolu_suppress_stderr=1
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
        "coc.preferences.formatOnSaveFiletypes" = [ "nix" ];

        languageserver = {
          nix = {
            command = "${inputs.rnix-lsp.defaultPackage.${system}}/bin/rnix-lsp";
            filetypes = [
              "nix"
            ];
          };
          dhall = {
            command = "dhall-lsp-server";
            filetypes = [
              "dhall"
            ];
          };
          unison = {
            filetypes = [ "unison" ];
            host = "127.0.0.1";
            port = 5757;
          };
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

      vmap <leader>ca <Plug>(coc-codeaction-selected)
      nmap <leader>ca <Plug>(coc-codeaction-cursor)

      " autocmd BufWritePre <buffer> call CocActionAsync('format')
      command! -nargs=0 Format :call CocActionAsync('format')
    '';
  };
}

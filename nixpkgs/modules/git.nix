{ pkgs, ... }:

let
  enableSigning = false;

  defaultGitConfig = {
    init.defaultBranch = "main";

    # Automatically rebase instead of merging upon `git pull`ing.
    pull.rebase = true;
    user = { };

    # Signing using SSH key. Commits may be Unverified because of this issue:
    # https://github.com/github/feedback/discussions/7744#discussioncomment-1794438.
  } // (if enableSigning then
    {
      gpg = {
        format = "ssh";
        program = "${pkgs.gnupg22}/bin/gpg";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # user.signingKey = "${builtins.readFile ~/.ssh/id_ed25519.pub}";

      commit.gpgsign = true;
    } else { });

in

{
  programs.git =
    {
      ignores = [ ".envrc" "*.~undo-tree~" ];
      includes = [
        # Invariant: the folder containing the subfolder comes first
        # i.e. overwrite the ~/ rule
        {
          condition = "gitdir:~/";
          contents = defaultGitConfig // {
            user = defaultGitConfig // {
              name = "Emily Martins";
              email = "emi@haskell.fyi";
            };
          };
        }
        {
          condition = "gitdir:~/work/";
          contents = defaultGitConfig // {
            user = defaultGitConfig.user // {
              name = "Emily Martins";
              email = "emily@liqwid.finance";
            };
          };
        }
      ];
      enable = true;
    };
}

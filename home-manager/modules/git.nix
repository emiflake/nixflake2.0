{ pkgs, ... }:

let
  enableSigning = true;

  defaultGitConfig = {
    init.defaultBranch = "main";

    # Automatically rebase instead of merging upon `git pull`ing.
    pull.rebase = true;
    user = { };
    url = { "ssh://git@github.com" = { insteadOf = "https://github.com"; }; };

    # Signing using SSH key. Commits may be Unverified because of this issue:
    # https://github.com/github/feedback/discussions/7744#discussioncomment-1794438.
  } // (if enableSigning then {
    user.signingKey = "F97B83CDDAF96F60";

    commit.gpgsign = true;
  } else
    { });
in {
  programs.git = {
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
            email = "emi@haskell.fyi";
          };
        };
      }
    ];
    enable = true;
  };
}

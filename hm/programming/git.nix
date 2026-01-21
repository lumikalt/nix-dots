{ pkgs, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    settings = {
      user = {
        name = "lumi";
        email = "lumi.mia.kalt@gmail.com";
      };

      init.defaultBranch = "main";
    };
  };

  programs.delta = {
    enable = true;

    enableGitIntegration = true;
  };

  # Required for git auth
  programs.gh.enable = true;
}

{ ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "Lumi Kalt";
    userEmail = "lumi.mia.kalt@gmail.com";

    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Required for git auth
  programs.gh.enable = true;
}
{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gitFull
  ];

  home-manager.users.lumi = {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      settings = {
        user = {
          name = "lumi";
          email = "lumi.mia.kalt@gmail.com";
        };

        init.defaultBranch = "trunk";

        push.autoSetupRemote = true;
      };
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };

    programs.gh.enable = true;

    # SSH over HTTPS for Github; SSH port 22 is blocked in the home network.
    programs.ssh.matchBlocks = lib.genAttrs [ "github.com" "ssh.github.com" ] (_: {
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
      identitiesOnly = true;

      hostname = "ssh.github.com";
      port = 443;
    });
  };
}

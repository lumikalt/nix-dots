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

    programs.gh = {
      enable = true;
      # Clone/push over SSH (uses the github key configured below)
      settings.git_protocol = "ssh";
    };

    # SSH over HTTPS for Github; SSH port 22 is blocked in the home network.
    programs.ssh.settings = lib.genAttrs [ "github.com" "ssh.github.com" ] (_: {
      User = "git";
      IdentityFile = "~/.ssh/id_ed25519";
      IdentitiesOnly = true;

      HostName = "ssh.github.com";
      Port = 443;
    });
  };
}

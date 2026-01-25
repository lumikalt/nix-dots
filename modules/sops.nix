{ config, pkgs, ... }:
{
  sops =
    let
      home = config.users.users.lumi.home;
    in
    {
      age.keyFile = "${home}/.config/sops/age/keys.txt";

      secrets."ssh/github/private_key" = {
        owner = "lumi";
        mode = "0600";
        path = "${home}/.ssh/id_ed25519";
        neededForUsers = true;
      };
    };

  environment.systemPackages = [ pkgs.age ];

  home-manager.users.lumi = {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;

      matchBlocks."github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
        hostname = "ssh.github.com";
        port = 443;
      };

      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };
}

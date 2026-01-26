{ config, pkgs, ... }:
{
  sops =
    let
      home = config.users.users.lumi.home;
    in
    {
      age.keyFile = "${home}/.config/sops/age/keys.txt";
      defaultSopsFile = ../secrets/lumi.yaml;

      secrets = {
        "ssh/github/private_key" = {
          owner = "lumi";
          mode = "0600";
          path = "${home}/.ssh/id_ed25519";
        };

        "vpn/tecnico/auth" = {
          owner = "lumi";
          mode = "0600";
        };
      };
    };

  environment.systemPackages = [ pkgs.age ];

  home-manager.users.lumi = {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks."*" = {
        user = "lumi";
        identityFile = "~/.ssh/id_ed25519";
      };

      extraConfig = ''
        AddKeysToAgent yes
      '';
    };
  };
}

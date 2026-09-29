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

        "ssh/tecnico/private_key" = {
          owner = "lumi";
          mode = "0600";
          path = "${home}/.ssh/id_ed25519_tecnico";
        };

        "ssh/fatima2/private_key" = {
          owner = "lumi";
          mode = "0600";
          path = "${home}/.ssh/id_ed25519_fatima2";
        };

        "ssh/fatima2/password" = {
          owner = "lumi";
          mode = "0400";
        };

        "ssh/csph30/password" = {
          owner = "lumi";
          mode = "0400";
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

      settings."*" = {
        User = "lumi";
        IdentityFile = "~/.ssh/id_ed25519";
        AddKeysToAgent = "yes";
      };
    };
  };
}

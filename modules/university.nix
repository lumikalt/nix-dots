{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = [
      (pkgs.writeShellScriptBin "fatima2" ''
        exec ${pkgs.sshpass}/bin/sshpass -f /run/secrets/ssh/fatima2/password ${pkgs.openssh}/bin/ssh fatima2 "$@"
      '')

      (pkgs.writeShellScriptBin "csph30" ''
        exec ${pkgs.sshpass}/bin/sshpass -f /run/secrets/ssh/csph30/password ${pkgs.openssh}/bin/ssh csph30 "$@"
      '')
    ];

    programs.ssh.settings = {
      "fatima2" = {
        HostName = "fatima2.vps.tecnico.ulisboa.pt";
        User = "ist1109813";
        IdentityFile = "~/.ssh/id_ed25519_fatima2";
        IdentitiesOnly = true;

        # Cadence Virtuoso (Microelectronica lab) needs X11 forwarding.
        ForwardX11 = "yes";
      };

      "csph30" = {
        HostName = "193.136.143.36";
        User = "csph30";
        IdentityFile = "~/.ssh/id_ed25519_csph30";
        IdentitiesOnly = true;

        ForwardX11 = "yes";
      };
    };
  };
}

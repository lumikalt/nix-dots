{
  home-manager.users.lumi = {
    programs.ssh.matchBlocks."fatima2" = {
      hostname = "fatima2.vps.tecnico.ulisboa.pt";
      user = "ist1109813";
      identityFile = "~/.ssh/id_ed25519_fatima2";
      identitiesOnly = true;

      # Cadence Virtuoso (Microelectronica lab) needs X11 forwarding.
      extraOptions = {
        ForwardX11 = "yes";
      };
    };
  };
}

{ config, pkgs, lib, ... }: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # Can still call doas as sudo
  security.sudo.enable = false;

  # Configure doas
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "lumi" ];
      keepEnv = true;
      persist = true;  
    }];
  };
}